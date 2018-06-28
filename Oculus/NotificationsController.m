//
//  NotificationsController.m
//  Oculus
//
//  Created by Justin Wells on 6/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "NotificationsController.h"
#import "NotificationsCell.h"
#import "Constants.h"
#import "NotificationsManager.h"
#import "OCNotification.h"
#import "AlertsManager.h"
#import "EventDetailController.h"

static NSString *cellIdentifier = @"cell";

@interface NotificationsController () <UITableViewDataSource, UITableViewDelegate, NotificationsCellDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) UIActivityIndicatorView *downloadingActivityView;
@property BOOL isInitialDownload;
@property BOOL isLoading;
@property BOOL isAtEndOfData;
@property (strong, nonatomic) NSMutableArray *notifications;
@property (strong, nonatomic) NotificationsManager *notificationsManager;
@property (strong, nonatomic) AlertsManager *alertsManager;

@end

@implementation NotificationsController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Setup NavigationBar
    [self setupNavigationBar];
    
    //Setup View
    [self setupView];
    
    //Download Data
    self.isInitialDownload = true;
    self.notifications = [[NSMutableArray alloc] init];
    self.notificationsManager = [[NotificationsManager alloc] init];
    [self downloadNotifications:[NSDate date] refresh:false];
    
    //Setup Alerts Manager
    self.alertsManager = [[AlertsManager alloc] init];
}

- (void) setupNavigationBar{
    //Set Navigation Items
    self.navigationItem.title = NSLocalizedString(@"notifications", nil);
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void) setupView{
    //Setup TableView
    [self setupTableView];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = COLOR_SECONDARY;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.tableView.separatorColor = [UIColor darkGrayColor];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[NotificationsCell class] forCellReuseIdentifier:cellIdentifier];
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

- (void) downloadNotifications:(NSDate *)startDate refresh:(BOOL) isRefresh{
    //Change isLoading Bool
    self.isLoading = true;
    
    //Start Downloading ActivityView
    if (self.isInitialDownload == true){
        [self.downloadingActivityView startAnimating];
    }
    
    //Change Initial Download Bool
    self.isInitialDownload = false;
    
    //TODO: Update with currentUser ID instead of hard-coded value
    [self.notificationsManager downloadNotifications:startDate uid:@"zcaa1rM8t1R7BRc1KyPOn7y7Wud2" completion:^(NSArray *notifications, NSError *error) {
        if (isRefresh == true){
            [self.notifications removeAllObjects];
            self.isAtEndOfData = false;
        }
        [self.notifications addObjectsFromArray:notifications];
        
        
        self.isLoading = false;
        //Stop Downloading ActivityView
        if (self.downloadingActivityView.isAnimating){
            [self.downloadingActivityView stopAnimating];
        }
        //Stop RefreshControl
        if (self.refreshControl.isRefreshing){
            [self.refreshControl endRefreshing];
        }
        
        if(notifications.count == 0){
            self.isAtEndOfData = true;
        }
        
        [self.tableView reloadData];
    }];
}

- (void) refreshData{
    [self downloadNotifications:[NSDate date] refresh:true];
}

//TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.notifications.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotificationsCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    cell.notificationsCellDelegate = self;
    [cell configure:self.notifications[indexPath.row]];
    return cell;
}

//TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OCNotification *notification = self.notifications[indexPath.row];
    if(notification.eventId != nil){
        //Show Event Controller if notification has eventId
        EventDetailController *eventDetailVC = [[EventDetailController alloc] initWithEvent:nil eventId:notification.eventId];
        [self.navigationController pushViewController:eventDetailVC animated:true];
    }
    else{
        //Show Alert that this feature is not available
        [self presentViewController:[self.alertsManager createFeatureUnavailableAlert] animated:true completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == self.notifications.count-1 && self.isInitialDownload == false && self.isLoading == false && self.isAtEndOfData == false){
        OCNotification *notification = self.notifications[indexPath.row];
        [self downloadNotifications:notification.createdAt refresh:false];
    }
}

- (void)didPressMoreButton:(UIButton *)sender{
    //Show Alert that this feature is not available
    [self presentViewController:[self.alertsManager createNotificationsMoreAlert] animated:true completion:nil];
}

- (void)didPressImageButton:(UIButton *)sender{
    //Show Alert that this feature is not available
    [self presentViewController:[self.alertsManager createFeatureUnavailableAlert] animated:true completion:nil];
}

//Bar Button Delegate
- (void) backButtonPressed:(id) sender{
    [self.navigationController popViewControllerAnimated:true];
}

@end
