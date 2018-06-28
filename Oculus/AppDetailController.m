//
//  AppDetailController.m
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "AppDetailController.h"
#import "OCApp.h"
#import "Constants.h"
#import "AppDetailMediaHeader.h"
#import "AppDetailSectionHeader.h"
#import "AppDetailDescriptionCell.h"
#import "AppDetailExperiencesCell.h"
#import "AppDetailSpecsCell.h"
#import "AppDetailRequirementsCell.h"
#import "AppDetailRatingsReviewsCell.h"
#import "AppDetailPublisherCell.h"
#import "AppDetailAdditionalDetailsCell.h"
#import "StoreManager.h"

static NSString *descriptionCellIdentifier = @"descriptionCell";
static NSString *experiencesCellIdentifier = @"experiencesCell";
static NSString *specsCellIdentifier = @"specsCell";
static NSString *requirementsCellIdentifier = @"requirementsCell";
static NSString *ratingsReviewsCellIdentifier = @"ratingsReviewsCell";
static NSString *publisherCellIdentifier = @"publisherCell";
static NSString *additionalDetailsCellIdentifier = @"additionalDetailsCell";
static NSString *defaultCellIdentifier = @"defaultCell";

@interface AppDetailController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString *appId;
@property (strong, nonatomic) NSString *appName;
@property (strong, nonatomic) OCApp *app;
@property (strong, nonatomic) StoreManager *storeManager;
@property (strong, nonatomic) UIActivityIndicatorView *downloadingActivityView;
@property BOOL isInitialDownload;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) AppDetailMediaHeader *tableHeader;

@end

@implementation AppDetailController

- (instancetype)initWithAppId:(NSString *) appId name:(NSString *)appName{
    self = [super init];
    if (self){
        self.appId = appId;
        self.appName = appName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Setup NavigationBar
    [self setupNavigationBar];
    
    //Setup View
    [self setupView];
    
    //Download Data
    self.storeManager = [[StoreManager alloc] init];
    [self downloadData];
}

- (void) viewWillAppear:(BOOL)animated{
    if(self.tableHeader != nil){
        //Play video if mediaPlayer has already been initialized
        [self.tableHeader.mediaPlayerView.avPlayer play];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    //Pause Video
    [self.tableHeader.mediaPlayerView.avPlayer pause];
}

- (void) setupNavigationBar{
    //Set Navigation Items
    self.navigationItem.title = self.appName;
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void) setupView{
    //Setup TableView
    [self setupTableView];
    
    //Setup Media TableViewHeader
    [self setupMediaTableHeader];
    
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
    self.tableView.estimatedRowHeight = 50;
    //TODO: Make all cells size dynamically. The cells with tableViews are not sizing properly so they are hard-coded for now.
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:defaultCellIdentifier];
    [self.tableView registerClass:[AppDetailDescriptionCell class] forCellReuseIdentifier:descriptionCellIdentifier];
    [self.tableView registerClass:[AppDetailExperiencesCell class] forCellReuseIdentifier:experiencesCellIdentifier];
    [self.tableView registerClass:[AppDetailSpecsCell class] forCellReuseIdentifier:specsCellIdentifier];
    [self.tableView registerClass:[AppDetailRequirementsCell class] forCellReuseIdentifier:requirementsCellIdentifier];
    [self.tableView registerClass:[AppDetailRatingsReviewsCell class] forCellReuseIdentifier:ratingsReviewsCellIdentifier];
    [self.tableView registerClass:[AppDetailPublisherCell class] forCellReuseIdentifier:publisherCellIdentifier];
    [self.tableView registerClass:[AppDetailAdditionalDetailsCell class] forCellReuseIdentifier:additionalDetailsCellIdentifier];
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:self.tableView];
    
    //Setup Downloading ActivityView
    self.downloadingActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.tableView.backgroundView = self.downloadingActivityView;
}

- (void) setupMediaTableHeader{
    self.tableHeader = [[AppDetailMediaHeader alloc] initWithFrame:CGRectZero];
    self.tableView.tableHeaderView = self.tableHeader;
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"tableView":self.tableView};
    //Width & Horizontal Constraints
    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:viewsDict]];
}

- (void) downloadData{
    //Start Downloading ActivityView
    if (!self.isInitialDownload == true){
        [self.downloadingActivityView startAnimating];
    }

    //Change Initial Download Bool
    self.isInitialDownload = false;
    
    [self.storeManager downloadApp:self.appId completion:^(OCApp *app, NSError *error) {
        self.app = app;
        
        //Stop Downloading ActivityView
        if (self.isInitialDownload == false){
            [self.downloadingActivityView stopAnimating];
        }
        
        if(self.app != nil){
            //Set Table Header Frame
            self.tableHeader.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 200);
            [self.tableHeader configure:self.app];
        }
        
        [self.tableView reloadData];
    }];
}

//TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.isInitialDownload == true){
        return 0;
    }
    else{
        if (self.app != nil){
            if([self.app.isPack isEqual: @1]){
                if([self.app.packApps isEqual:[NSNull null]]){
                    return 1;
                }
                else{
                    return 2;
                }
            }
            else{
                return 9;
            }
        }
        else{
           return 0;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(self.isInitialDownload == true){
        return 0;
    }
    else{
        if (self.app != nil){
            return 50;
        }
        else{
            return 0;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AppDetailSectionHeader *tableSectionHeader = [[AppDetailSectionHeader alloc] init];
    [tableSectionHeader configure:self.app];
    return tableSectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 1:
            if (self.app != nil){
                if ([self.app.isPack isEqual:@1]){
                    return 100*self.app.packApps.count+40;
                }
                else{
                    return 230;
                }
            }
            else{
                return 230;
            }
        case 2:
            return 290;
        case 3:
            return 575;
        case 5:
            return 335;
        default:
            return UITableViewAutomaticDimension;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AppDetailDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier: descriptionCellIdentifier];
        [cell configure:self.app];
        return cell;
    }
    else if (indexPath.row == 1){
        if (self.app != nil){
            if ([self.app.isPack isEqual:@1]){
                AppDetailExperiencesCell *cell = [tableView dequeueReusableCellWithIdentifier: experiencesCellIdentifier];
                [cell configure:self.app];
                return cell;
            }
            else{
                AppDetailSpecsCell *cell = [tableView dequeueReusableCellWithIdentifier: specsCellIdentifier];
                [cell configure:self.app];
                return cell;
            }
        }
        else{
            AppDetailSpecsCell *cell = [tableView dequeueReusableCellWithIdentifier: specsCellIdentifier];
            [cell configure:self.app];
            return cell;
        }
    }
    else if (indexPath.row == 2){
        AppDetailRequirementsCell *cell = [tableView dequeueReusableCellWithIdentifier: requirementsCellIdentifier];
        [cell configure:self.app];
        return cell;
    }
    else if (indexPath.row == 3){
        AppDetailRatingsReviewsCell *cell = [tableView dequeueReusableCellWithIdentifier: ratingsReviewsCellIdentifier];
        [cell configure:self.app];
        return cell;
    }
    else if (indexPath.row == 4){
        AppDetailPublisherCell *cell = [tableView dequeueReusableCellWithIdentifier: publisherCellIdentifier];
        [cell configure:self.app];
        return cell;
    }
    else if (indexPath.row == 5){
        AppDetailAdditionalDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier: additionalDetailsCellIdentifier];
        [cell configure:self.app detailTitles:[self.storeManager getAdditionalDetailsTitles]];
        return cell;
    }
    else if (indexPath.row >= 6 && indexPath.row <= 8){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: defaultCellIdentifier];
        cell.backgroundColor = COLOR_SECONDARY;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        if(indexPath.row == 6){
            cell.textLabel.text = NSLocalizedString(@"versionNotes", nil);
        }
        else if(indexPath.row == 7){
            cell.textLabel.text = NSLocalizedString(@"developer", nil);
        }
        else if(indexPath.row == 8){
            cell.textLabel.text = NSLocalizedString(@"permissions", nil);
        }
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: defaultCellIdentifier];
        return cell;
    }
}

//Bar Button Delegate
- (void) backButtonPressed:(id) sender{
    [self.navigationController popViewControllerAnimated:true];
}

@end
