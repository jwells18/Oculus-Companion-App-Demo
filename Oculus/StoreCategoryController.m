//
//  StoreCategoryController.m
//  Oculus
//
//  Created by Justin Wells on 6/22/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "StoreCategoryController.h"
#import "Constants.h"
#import "StoreManager.h"
#import "AlertsManager.h"
#import "StoreCategoryCell.h"
#import "StoreCategoryHeader.h"
#import "AppDetailController.h"

static NSString *cellIdentifier = @"cell";

@interface StoreCategoryController ()<UITableViewDataSource, UITableViewDelegate, StoreCategoryHeaderDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) StoreManager *storeManager;
@property (strong, nonatomic) AlertsManager *alertsManager;
@property (strong, nonatomic) NSString *appSectionTitle;
@property (strong, nonatomic) NSDictionary *searchConstraints;
@property (strong, nonatomic) NSMutableArray *apps;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) UIActivityIndicatorView *downloadingActivityView;
@property BOOL isInitialDownload;
@property BOOL isLoading;
@property BOOL isAtEndOfData;

@end

@implementation StoreCategoryController

- (instancetype)initWithSearchConstraints:(NSDictionary *)searchConstraints appSectionTitle:(NSString *)title{
    self = [super init];
    if (self){
        self.searchConstraints = searchConstraints;
        self.appSectionTitle = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Setup NavigationBar
    [self setupNavigationBar];
    
    //Setup View
    [self setupView];
    
    //Setup Data
    self.apps = [[NSMutableArray alloc] init];
    self.storeManager = [[StoreManager alloc] init];
    [self downloadData: [NSDate date] refresh:false];
    
    //Setup AlertsManager
    self.alertsManager = [[AlertsManager alloc] init];
}

- (void) setupNavigationBar{
    //Set Navigation Items
    self.navigationItem.title = self.appSectionTitle;
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void) setupView{
    self.view.backgroundColor = COLOR_SECONDARY;
    
    //Setup TableView
    [self setupTableView];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = COLOR_SECONDARY;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.tableView.separatorColor = [UIColor darkGrayColor];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.tableView registerClass:[StoreCategoryCell class] forCellReuseIdentifier:cellIdentifier];
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

- (void) downloadData:(NSDate *)startDate refresh:(BOOL)isRefresh{
    //Change isLoading Bool
    self.isLoading = true;
    
    //Start Downloading ActivityView
    if (!self.isInitialDownload == true && isRefresh == false){
        [self.downloadingActivityView startAnimating];
    }
    
    //Change Initial Download Bool
    self.isInitialDownload = false;
    [self.storeManager searchStore:self.searchConstraints completion:^(NSArray *apps, NSError *error) {
        if (isRefresh == true){
            [self.apps removeAllObjects];
            self.isAtEndOfData = false;
        }
        [self.apps addObjectsFromArray:apps];
        
        self.isLoading = false;
        //Stop Downloading ActivityView
        if (self.downloadingActivityView.isAnimating){
            [self.downloadingActivityView stopAnimating];
        }
        //Stop RefreshControl
        if (self.refreshControl.isRefreshing){
            [self.refreshControl endRefreshing];
        }
        
        if(apps.count == 0){
            self.isAtEndOfData = true;
        }
        
        [self.tableView reloadData];
    }];
}

- (void) refreshData{
    [self downloadData:[NSDate date] refresh: true];
}

//TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.apps.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    StoreCategoryHeader *sectionHeader = [[StoreCategoryHeader alloc] init];
    sectionHeader.storeCategoryHeaderDelegate = self;
    //TODO: Update search constraints to be an array and not a dictionary
    [sectionHeader imposeSearchConstraints:nil];
    return sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *sectionFooter = [[UIView alloc] init];
    sectionFooter.backgroundColor = COLOR_SECONDARY;
    return sectionFooter;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    [cell configure:self.apps[indexPath.row]];
    return cell;
}

//CollectionView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OCApp *app = self.apps[indexPath.row];
    AppDetailController *appDetailVC = [[AppDetailController alloc] initWithAppId:app.objectId name:app.name];
    [self.navigationController pushViewController:appDetailVC animated:true];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == self.apps.count-1 && self.isInitialDownload == false && self.isLoading == false && self.isAtEndOfData == false){
        //TODO: Implement pagination when search by constraint is implemented
    }
}

- (void)didPressStoryCategoryHeaderCell:(UICollectionViewCell *)sender indexPath:(NSIndexPath *)indexPath{
    //Show Alert that this feature is not available
    [self presentViewController:[self.alertsManager createFeatureUnavailableAlert] animated:true completion:nil];
}

//Bar Button Delegate
- (void) backButtonPressed:(id) sender{
    [self.navigationController popViewControllerAnimated:true];
}


@end
