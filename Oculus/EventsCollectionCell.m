//
//  EventsCollectionCell.m
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "EventsCollectionCell.h"
#import "Constants.h"
#import "EventsCell.h"

static NSString *cellIdentifier = @"cell";

@interface EventsCollectionCell () <UITableViewDataSource, UITableViewDelegate, EventsCellDelegate>

@property (strong, nonatomic) NSArray *events;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) UIActivityIndicatorView *downloadingActivityView;

@end

@implementation EventsCollectionCell

@synthesize eventsCollectionCellDelegate;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.backgroundColor = COLOR_SECONDARY;
    
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
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 436;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[EventsCell class] forCellReuseIdentifier:cellIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.tableView];
    
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
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:viewsDict]];
}

- (void) configure:(NSArray *)events isInitialDownload:(BOOL)isInitialDownload{
    self.events = events;
    
    //Stop Downloading ActivityView
    if (isInitialDownload == true){
        [self.downloadingActivityView startAnimating];
    }
    else{
        [self.downloadingActivityView stopAnimating];
    }
    
    [self reloadTableData];
}

- (void) reloadTableData{
    //Stop RefreshControl
    if (self.refreshControl.isRefreshing){
        [self.refreshControl endRefreshing];
    }
    
    [self.tableView reloadData];
}

- (void) refreshData{
    if ([eventsCollectionCellDelegate respondsToSelector:@selector(refreshEventsData:)]){
        [eventsCollectionCellDelegate refreshEventsData:self];
    }
}

//TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.events.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EventsCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    cell.eventsCellDelegate = self;
    [cell configure: self.events[indexPath.row]];
    return cell;
}

//TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([eventsCollectionCellDelegate respondsToSelector:@selector(didPressEventsCell:indexPath:)]){
        [eventsCollectionCellDelegate didPressEventsCell:self indexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == self.events.count-1){
        if ([eventsCollectionCellDelegate respondsToSelector:@selector(willDisplayEventsCell:indexPath:)]){
            [eventsCollectionCellDelegate willDisplayEventsCell:self indexPath:indexPath];
        }
    }
}

- (void) relayDidPressReadMoreButton:(UIButton *)sender{
    if ([eventsCollectionCellDelegate respondsToSelector:@selector(didPressReadMoreButton:indexPath:)]){
        NSIndexPath *indexPath = [self determineIndexPathForButton:sender];
        [eventsCollectionCellDelegate didPressReadMoreButton:self indexPath:indexPath];
    }
}

- (void) relayDidPressInterestedButton:(UIButton *)sender{
    if ([eventsCollectionCellDelegate respondsToSelector:@selector(didPressInterestedButton:indexPath:)]){
        NSIndexPath *indexPath = [self determineIndexPathForButton:sender];
        [eventsCollectionCellDelegate didPressInterestedButton:self indexPath:indexPath];
    }
}

- (NSIndexPath *) determineIndexPathForButton:(UIButton *)sender{
    //Determine IndexPath
    CGPoint touchPoint = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath* indexPath = [self.tableView indexPathForRowAtPoint:touchPoint];
    return indexPath;
}


@end
