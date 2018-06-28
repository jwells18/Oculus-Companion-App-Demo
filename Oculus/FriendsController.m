//
//  FriendsController.m
//  Oculus
//
//  Created by Justin Wells on 6/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "FriendsController.h"
#import "Constants.h"
#import "NotificationsController.h"
#import "FriendsTableHeader.h"
#import "FriendsCell.h"
#import "OCTableSectionHeader.h"
#import "AlertsManager.h"

static NSString *cellIdentifier = @"cell";

@interface FriendsController () <UITableViewDataSource, UITableViewDelegate, FriendsCellDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) AlertsManager *alertsManager;

@end

@implementation FriendsController

- (instancetype)init {
    self = [super init];
    
    //Setup TabBar Items
    [self.tabBarItem setTitle:NSLocalizedString(@"friends", nil)];
    [self.tabBarItem setImage:[UIImage imageNamed:@"friends"]];
    [self.tabBarItem setSelectedImage:[UIImage imageNamed:@"friendsSelected"]];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Setup NavigationBar
    [self setupNavigationBar];
    
    //Setup View
    [self setupView];
    
    //Setup Alerts Manager
    self.alertsManager = [[AlertsManager alloc] init];
}

- (void) setupNavigationBar{
    //Set Navigation Items
    self.navigationItem.title = NSLocalizedString(@"friends", nil);
    
    UIBarButtonItem *notificationsButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"notifications"] style: UIBarButtonItemStylePlain target:self action:@selector(notificationsButtonPressed:)];
    self.navigationItem.rightBarButtonItem = notificationsButtonItem;
}

- (void) setupView{
    self.view.backgroundColor = COLOR_SECONDARY;
    
    //Setup TableView
    [self setupTableView];
    
    //Setup TableView Header
    [self setupTableViewHeader];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = COLOR_SECONDARY;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[FriendsCell class] forCellReuseIdentifier:cellIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:self.tableView];
    
    //Setup RefreshControl
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor lightGrayColor];
    self.refreshControl.layer.zPosition = -1;
    [self.refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void) setupTableViewHeader{
    FriendsTableHeader *tableHeader = [[FriendsTableHeader alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 60)];
    [tableHeader addTarget:self action:@selector(tableHeaderPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = tableHeader;
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"tableView":self.tableView};
    //Width & Horizontal Constraints
    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:viewsDict]];
}

- (void) refreshData{
    [self.refreshControl endRefreshing];
}

//TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OCTableSectionHeader *sectionHeader = [[OCTableSectionHeader alloc] init];
    [sectionHeader configure:[NSString stringWithFormat:@"%@ (%@)", NSLocalizedString(@"totalFriends", nil), @"1"]];
    return sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendsCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    cell.friendsCellDelegate = self;
    [cell configure:nil];
    return cell;
}

//TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //Show Alert that this feature is not available
    [self presentViewController:[self.alertsManager createFeatureUnavailableAlert] animated:true completion:nil];
}

- (void) tableHeaderPressed:(id) sender{
    //Show Alert that this feature is not available
    [self presentViewController:[self.alertsManager createFeatureUnavailableAlert] animated:true completion:nil];
}

- (void)didPressImageButton:(UIButton *)sender{
    //Show Alert that this feature is not available
    [self presentViewController:[self.alertsManager createFeatureUnavailableAlert] animated:true completion:nil];
}

//BarButtonItem Delegate
- (void) searchButtonPressed:(id) sender{
    
}

- (void) notificationsButtonPressed:(id) sender{
    NotificationsController *notificationsVC = [[NotificationsController alloc] init];
    [self.navigationController pushViewController:notificationsVC animated:true];
}



@end
