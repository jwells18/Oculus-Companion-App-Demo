//
//  EventsController.m
//  Oculus
//
//  Created by Justin Wells on 6/19/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "EventsController.h"
#import "Constants.h"
#import "NotificationsController.h"
#import "HMSegmentedControl.h"
#import "EventDetailController.h"
#import "EventsCollectionCell.h"
#import "AlertsManager.h"
#import "EventManager.h"
#import "DateManager.h"

static NSString *cellIdentifier = @"cell";

@interface EventsController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, EventsCollectionCellDelegate>

@property (strong, nonatomic) HMSegmentedControl *segmentedControl;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *upcomingEvents;
@property (strong, nonatomic) NSMutableArray *myEvents;
@property (strong, nonatomic) EventManager *eventManager;
@property (strong, nonatomic) AlertsManager *alertsManager;
@property BOOL isInitialDownload;
@property BOOL isLoading;
@property BOOL isAtEndOfData;
@end

@implementation EventsController


- (instancetype)init {
    self = [super init];
    
    //Setup TabBar Items
    [self.tabBarItem setTitle:NSLocalizedString(@"events", nil)];
    [self.tabBarItem setImage:[UIImage imageNamed:@"events"]];
    [self.tabBarItem setSelectedImage:[UIImage imageNamed:@"eventsSelected"]];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initialize Data Array
    self.upcomingEvents = [[NSMutableArray alloc] init];
    self.myEvents = [[NSMutableArray alloc] init];
    
    //Setup NavigationBar
    [self setupNavigationBar];
    
    //Setup View
    [self setupView];
    
    //Setup AlertsManager
    self.alertsManager = [[AlertsManager alloc] init];
    
    //Download Data
    self.isInitialDownload = true;
    self.eventManager = [[EventManager alloc] init];
    //Download Upcoming Events
    //For demo purposes: setting a static date
    DateManager *dateManager = [[DateManager alloc] init];
    NSDate *staleDate = [dateManager createDateFromString:@"2018/06/24 00:00"];
    [self downloadUpcomingEvents:staleDate refresh:false];

    //TODO: Download MyEvents (Core Data)
}

- (void) setupNavigationBar{
    //Set Navigation Items
    self.navigationItem.title = NSLocalizedString(@"events", nil);
    
    UIBarButtonItem *notificationsButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"notifications"] style: UIBarButtonItemStylePlain target:self action:@selector(notificationsButtonPressed:)];
    self.navigationItem.rightBarButtonItem = notificationsButtonItem;
}

- (void) setupView{
    self.view.backgroundColor = COLOR_SECONDARY;
    
    //Setup SegmentedControl
    [self setupSegmentedControl];
    
    //Setup CollectionView
    [self setupCollectionView];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupSegmentedControl{
    //Setup SegmentedControl
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[NSLocalizedString(@"upcomingEvents", nil), NSLocalizedString(@"myEvents", nil)]];
    self.segmentedControl.frame = CGRectZero;
    self.segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
    self.segmentedControl.selectionIndicatorHeight = 2;
    self.segmentedControl.backgroundColor = COLOR_SECONDARY;
    [self.segmentedControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        if(selected){
            NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:14]}];
            return attString;
        }
        else{
            NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor darkGrayColor], NSFontAttributeName : [UIFont systemFontOfSize:14]}];
            return attString;
        }
    }];
    [self.segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:self.segmentedControl];
}

- (void) setupCollectionView{
    //Setup CollectionView Layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //Setup CollectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[EventsCollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
    self.collectionView.backgroundColor = COLOR_SECONDARY;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = true;
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:self.collectionView];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"segmentedControl": self.segmentedControl, @"collectionView":self.collectionView};
    //Width & Horizontal Constraints
    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[segmentedControl]|" options:0 metrics:nil views:viewsDict]];
    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self.view addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[segmentedControl(44)][collectionView]|" options:0 metrics:nil views:viewsDict]];
}

- (void) downloadUpcomingEvents:(NSDate *)startDate refresh:(BOOL) isRefresh{
    //Change isLoading Bool
    self.isLoading = true;
    
    [self.eventManager downloadEvents:startDate completion:^(NSArray *events, NSError *error) {
        if (isRefresh == true){
            [self.upcomingEvents removeAllObjects];
            self.isAtEndOfData = false;
        }
        [self.upcomingEvents addObjectsFromArray:events];
        
        //Change Initial Download Bool
        self.isInitialDownload = false;
        self.isLoading = false;
        
        if(events.count == 0){
            self.isAtEndOfData = true;
        }
        
        //Reload Data
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        EventsCollectionCell *cell = (EventsCollectionCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        [cell reloadTableData];
    }];
}

//CollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EventsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.eventsCollectionCellDelegate = self;
    if (indexPath.item == 0){
        [cell configure: self.upcomingEvents isInitialDownload:self.isInitialDownload];
    }
    else if (indexPath.item == 1){
        [cell configure: self.myEvents isInitialDownload:self.isInitialDownload];
    }
    
    return cell;
}

//CollectionView Delegate
- (void)didPressEventsCell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    NSIndexPath *sectionIndexPath = [self.collectionView indexPathForCell:cell];
    if (sectionIndexPath.item == 0){
        OCEvent *event = self.upcomingEvents[indexPath.row];
        [self showEventDetailController: event];
    }
    else if (sectionIndexPath.item == 1){
        OCEvent *event = self.myEvents[indexPath.row];
        [self showEventDetailController: event];
    }
}

- (void)willDisplayEventsCell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == self.upcomingEvents.count-1 && self.isInitialDownload == false && self.isLoading == false && self.isAtEndOfData == false){
        OCEvent *event = self.upcomingEvents[indexPath.row];
        [self downloadUpcomingEvents:event.startDate refresh:false];
    }
}

- (void)refreshEventsData:(UICollectionViewCell *)cell{
    NSIndexPath *sectionIndexPath = [self.collectionView indexPathForCell:cell];
    if (sectionIndexPath.item == 0){
        //For demo purposes: setting a static date
        DateManager *dateManager = [[DateManager alloc] init];
        NSDate *staleDate = [dateManager createDateFromString:@"2018/06/24 00:00"];
        [self downloadUpcomingEvents:staleDate refresh:true];
    }
    else{
        //Reload Data
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        EventsCollectionCell *cell = (EventsCollectionCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        [cell reloadTableData];
    }
}

- (void)didPressReadMoreButton:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    NSIndexPath *sectionIndexPath = [self.collectionView indexPathForCell:cell];
    if (sectionIndexPath.item == 0){
        OCEvent *event = self.upcomingEvents[indexPath.row];
        [self showEventDetailController: event];
    }
    else if (sectionIndexPath.item == 1){
        OCEvent *event = self.myEvents[indexPath.row];
        [self showEventDetailController: event];
    }
}

- (void) showEventDetailController:(OCEvent *)event{
    EventDetailController *eventDetailVC = [[EventDetailController alloc] initWithEvent:event eventId:event.objectId];
    [self.navigationController pushViewController:eventDetailVC animated:true];
}

- (void)didPressInterestedButton:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath{
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

//ScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView == self.collectionView){
        //Change SegmentedControl index to match CollectionView index
        CGFloat pageWidth = scrollView.frame.size.width;
        NSInteger page = scrollView.contentOffset.x / pageWidth;
        [self.segmentedControl setSelectedSegmentIndex:page animated:true];
    }
}

//HMSegmentedControl Delegates
- (void)segmentedControlValueChanged:(HMSegmentedControl *)segmentedControl{
    //Set CollectionView index to SegmentedControl index
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:segmentedControl.selectedSegmentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:true];
}

@end
