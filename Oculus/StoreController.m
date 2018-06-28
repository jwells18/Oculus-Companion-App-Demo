//
//  StoreController.m
//  Oculus
//
//  Created by Justin Wells on 6/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "StoreController.h"
#import "Constants.h"
#import "StoreManager.h"
#import "NotificationsController.h"
#import "StoreFeaturedCell.h"
#import "StoreDefaultCell.h"
#import "AppDetailController.h"
#import "AlertsManager.h"
#import "StoreCategoryController.h"

static NSString *featuredCellIdentifier = @"featuredCell";
static NSString *defaultCellIdentifier = @"defaultCell";
static NSString *searchCellIdentifier = @"searchCell";

@interface StoreController () <UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate, UISearchResultsUpdating, StoreDefaultCellDelegate, StoreFeaturedCellDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) StoreManager *storeManager;
@property (strong, nonatomic) UIActivityIndicatorView *downloadingActivityView;
@property BOOL isInitialDownload;
@property BOOL isLoading;
@property BOOL isAtEndOfData;
@property (strong, nonatomic) NSMutableArray *appSections;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) UITableViewController *searchResultsController;
@property (strong, nonatomic) UIBarButtonItem *searchButtonItem;
@property (strong, nonatomic) UIBarButtonItem *notificationsButtonItem;
@property (strong, nonatomic) AlertsManager *alertsManager;

@end

@implementation StoreController

- (instancetype)init {
    self = [super init];
    
    //Setup TabBar Items
    [self.tabBarItem setTitle:NSLocalizedString(@"store", nil)];
    [self.tabBarItem setImage:[UIImage imageNamed:@"store"]];
    [self.tabBarItem setSelectedImage:[UIImage imageNamed:@"storeSelected"]];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Setup NavigationBar
    [self setupNavigationBar];
    
    //Setup View
    [self setupView];
    
    //Setup Data
    self.appSections = [[NSMutableArray alloc] init];
    self.storeManager = [[StoreManager alloc] init];
    [self downloadData: @-1 refresh:false];
    
    //Setup Alerts Manager
    self.alertsManager = [[AlertsManager alloc] init];
}

- (void) viewWillDisappear:(BOOL)animated{
    [self.searchController dismissViewControllerAnimated:true completion:^{
        self.navigationItem.leftBarButtonItem = self.searchButtonItem;
        self.navigationItem.rightBarButtonItem = self.notificationsButtonItem;
        self.navigationItem.titleView = nil;
        self.searchController.searchBar.text = nil;
    }];
}

- (void) setupNavigationBar{
    //Set Navigation Items
    self.navigationItem.title = NSLocalizedString(@"store", nil);
    
    self.searchButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style: UIBarButtonItemStylePlain target:self action:@selector(searchButtonPressed:)];
    self.navigationItem.leftBarButtonItem = self.searchButtonItem;
    
    self.notificationsButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"notifications"] style: UIBarButtonItemStylePlain target:self action:@selector(notificationsButtonPressed:)];
    self.navigationItem.rightBarButtonItem = self.notificationsButtonItem;
}

- (void) setupView{
    self.view.backgroundColor = COLOR_SECONDARY;
    
    //Setup SearchController
    [self setupSearchController];
    
    //Setup TableView
    [self setupTableView];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupSearchController{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsController];
    self.searchController.searchResultsUpdater = self;
    self.searchController.delegate = self;
    self.searchController.obscuresBackgroundDuringPresentation = true;
    self.searchController.hidesNavigationBarDuringPresentation = false;
    self.definesPresentationContext = true;
    self.searchController.searchBar.tintColor = [UIColor whiteColor];
    self.searchController.searchBar.placeholder = NSLocalizedString(@"search", nil);
    
    //Setup Search Results Controller
    [self setupSearchResultsController];
}

- (void) setupSearchResultsController{
    self.searchResultsController.tableView.dataSource = self;
    self.searchResultsController.tableView.delegate = self;
    self.searchResultsController.tableView.separatorColor = [UIColor darkGrayColor];
    self.searchResultsController.tableView.separatorInset = UIEdgeInsetsZero;
    self.searchResultsController.tableView.showsVerticalScrollIndicator = false;
    self.searchResultsController.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.searchResultsController.tableView  registerClass:[UITableViewCell class] forCellReuseIdentifier: searchCellIdentifier];
}

- (void) setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = COLOR_SECONDARY;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.tableView.separatorColor = [UIColor darkGrayColor];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.tableView registerClass:[StoreFeaturedCell class] forCellReuseIdentifier:featuredCellIdentifier];
    [self.tableView registerClass:[StoreDefaultCell class] forCellReuseIdentifier:defaultCellIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:self.tableView];
    
    //Setup RefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor lightGrayColor];
    self.refreshControl.layer.zPosition = -1;
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    //Setup Downloading ActivityView
    self.downloadingActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.tableView.backgroundView = self.downloadingActivityView;
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"tableView":self.tableView};
    //Width & Horizontal Constraints
    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:viewsDict]];
}

- (void) downloadData:(NSNumber *) priority refresh:(BOOL)isRefresh{
    //Change isLoading Bool
    self.isLoading = true;
    
    //Start Downloading ActivityView
    if (!self.isInitialDownload == true && isRefresh == false){
        [self.downloadingActivityView startAnimating];
    }
    
    //Change Initial Download Bool
    self.isInitialDownload = false;
    
    [self.storeManager downloadAppSections:priority completion:^(NSArray *sections, NSError *error) {
        if (isRefresh == true){
            [self.appSections removeAllObjects];
            self.isAtEndOfData = false;
        }
        [self.appSections addObjectsFromArray:sections];
        
        self.isLoading = false;
        //Stop Downloading ActivityView
        if (self.downloadingActivityView.isAnimating){
            [self.downloadingActivityView stopAnimating];
        }
        //Stop RefreshControl
        if (self.refreshControl.isRefreshing){
            [self.refreshControl endRefreshing];
        }
        
        if(sections.count == 0){
            self.isAtEndOfData = true;
        }
        
        [self.tableView reloadData];
    }];
}

- (void) refreshData{
    [self downloadData:@-1 refresh: true];
}

//TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.appSections.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        return self.view.frame.size.height*0.4;
    }
    else{
        return self.view.frame.size.height*0.33;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        StoreFeaturedCell *cell = [tableView dequeueReusableCellWithIdentifier: featuredCellIdentifier];
        cell.storeFeaturedCellDelegate = self;
        [cell configure:[self.appSections objectAtIndex: indexPath.row]];
        return cell;
    }
    else{
        StoreDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier: defaultCellIdentifier];
        cell.storeDefaultCellDelegate = self;
        [cell configure:[self.appSections objectAtIndex: indexPath.row]];
        return cell;
    }
}

//CollectionView Delegate
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == self.appSections.count-1 && self.isInitialDownload == false && self.isLoading == false && self.isAtEndOfData == false){
        [self downloadData:[NSNumber numberWithInteger:indexPath.row] refresh:false];
    }
}

- (void)didPressStoreDefaultCell:(UITableViewCell *)cell app:(OCApp *)app{
    AppDetailController *appDetailVC = [[AppDetailController alloc] initWithAppId:app.objectId name:app.name];
    [self.navigationController pushViewController:appDetailVC animated:true];
}

- (void)didPressStoreFeaturedCell:(UITableViewCell *)cell app:(OCApp *)app{
    AppDetailController *appDetailVC = [[AppDetailController alloc] initWithAppId:app.objectId name:app.name];
    [self.navigationController pushViewController:appDetailVC animated:true];
}

- (void)didPressSeeAllButton:(UITableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    OCAppSection *section = self.appSections[indexPath.row];
    StoreCategoryController *storeCategoryVC = [[StoreCategoryController alloc] initWithSearchConstraints:section.searchConstraints appSectionTitle:section.name];
    [self.navigationController pushViewController:storeCategoryVC animated:true];
}

//SearchController Delegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    //TODO: Finish implementing search
}

- (void)willDismissSearchController:(UISearchController *)searchController{
    self.navigationItem.leftBarButtonItem = self.searchButtonItem;
    self.navigationItem.rightBarButtonItem = self.notificationsButtonItem;
    self.navigationItem.titleView = nil;
    self.searchController.searchBar.text = nil;
}

//BarButtonItem Delegate
- (void) searchButtonPressed:(id) sender{
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItems = nil;
    self.navigationItem.titleView = self.searchController.searchBar;
    [self.searchController.searchBar becomeFirstResponder];
}

- (void) notificationsButtonPressed:(id) sender{
    NotificationsController *notificationsVC = [[NotificationsController alloc] init];
    [self.navigationController pushViewController:notificationsVC animated:true];
}


@end
