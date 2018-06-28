//
//  SettingsController.m
//  Oculus
//
//  Created by Justin Wells on 6/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "SettingsController.h"
#import "Constants.h"
#import "NotificationsController.h"
#import "SettingsManager.h"
#import "SettingsTableHeader.h"
#import "SettingsTableFooter.h"
#import "SettingsCell.h"
#import "OCTableSectionHeader.h"
#import "AlertsManager.h"
#import "WelcomeToOculusController.h"

static NSString *cellIdentifier = @"cell";

@interface SettingsController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) SettingsManager *settingsManager;
@property (strong, nonatomic) NSArray *settingsSections;
@property (strong, nonatomic) NSArray *settingsSectionTitles;
@property (strong, nonatomic) NSArray *settingsSectionImages;
@property (strong, nonatomic) AlertsManager *alertsManager;

@end

@implementation SettingsController

- (instancetype)init {
    self = [super init];
    
    //Setup TabBar Items
    [self.tabBarItem setTitle:NSLocalizedString(@"settings", nil)];
    [self.tabBarItem setImage:[UIImage imageNamed:@"settings"]];
    [self.tabBarItem setSelectedImage:[UIImage imageNamed:@"settingsSelected"]];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Setup NavigationBar
    [self setupNavigationBar];
    
    //Setup Data
    [self setupData];
    
    //Setup View
    [self setupView];
    
    //Setup AlertsManager
    self.alertsManager = [[AlertsManager alloc] init];
}

- (void) setupNavigationBar{
    //Set Navigation Items
    self.navigationItem.title = NSLocalizedString(@"settings", nil);
    
    UIBarButtonItem *notificationsButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"notifications"] style: UIBarButtonItemStylePlain target:self action:@selector(notificationsButtonPressed:)];
    self.navigationItem.rightBarButtonItem = notificationsButtonItem;
}

- (void) setupView{
    self.view.backgroundColor = COLOR_SECONDARY;
    
    //Setup TableView
    [self setupTableView];
    
    //Setup TableView Header
    [self setupTableViewHeader];
    
    //Setup TableView Footer
    [self setupTableViewFooter];
    
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
    [self.tableView registerClass:[SettingsCell class] forCellReuseIdentifier:cellIdentifier];
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:self.tableView];
}

- (void) setupTableViewHeader{
    SettingsTableHeader *tableHeader = [[SettingsTableHeader alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 175)];
    [tableHeader configure:nil];
    [tableHeader.headsetButton addTarget:self action:@selector(headsetButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = tableHeader;
}

- (void) setupTableViewFooter{
    SettingsTableFooter *tableFooter = [[SettingsTableFooter alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
    [tableFooter.logoutButton addTarget:self action:@selector(logoutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = tableFooter;
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"tableView":self.tableView};
    //Width & Horizontal Constraints
    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:viewsDict]];
}

- (void) setupData{
    //Set Store Categories
    self.settingsManager = [[SettingsManager alloc] init];
    self.settingsSections = [self.settingsManager getSettingsSections];
    self.settingsSectionTitles = [self.settingsManager getSettingsSectionTitles];
    self.settingsSectionImages = [self.settingsManager getSettingsSectionImages];
}

//TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.settingsSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.settingsSectionTitles[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OCTableSectionHeader *sectionHeader = [[OCTableSectionHeader alloc] init];
    [sectionHeader configure:self.settingsSections[section]];
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
    SettingsCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    NSArray *sectionTitles = self.settingsSectionTitles[indexPath.section];
    NSArray *sectionImages = self.settingsSectionImages[indexPath.section];
    [cell configure:sectionImages[indexPath.row] title:sectionTitles[indexPath.row]];
    return cell;
}

//CollectionView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //Show Alert that this feature is not available
    [self presentViewController:[self.alertsManager createFeatureUnavailableAlert] animated:true completion:nil];
}

//BarButtonItem Delegate
- (void) notificationsButtonPressed:(id) sender{
    NotificationsController *notificationsVC = [[NotificationsController alloc] init];
    [self.navigationController pushViewController:notificationsVC animated:true];
}

//Button Delegate
- (void) headsetButtonPressed:(id) sender{
    WelcomeToOculusController *welcomeVC = [[WelcomeToOculusController alloc] init];
    [self presentViewController:welcomeVC animated:true completion:nil];
}

- (void) logoutButtonPressed:(id) sender{
    //Show Logout Alert
    [self presentViewController:[self.alertsManager createLogoutAlert] animated:true completion:nil];
}


@end
