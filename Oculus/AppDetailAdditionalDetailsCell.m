//
//  AppDetailAdditionalDetailsCell.m
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "AppDetailAdditionalDetailsCell.h"
#import "Constants.h"
#import "AppDetailAdditionalDetailsTableCell.h"
#import "AppDetailDefaultHeader.h"

static NSString *cellIdentifier = @"cell";

@interface AppDetailAdditionalDetailsCell () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) OCApp *app;
@property (strong, nonatomic) NSArray *detailTitles;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSLayoutConstraint *tableViewHeightConstraint;

@end

@implementation AppDetailAdditionalDetailsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Setup View
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.backgroundColor = COLOR_SECONDARY;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.clipsToBounds = true;
    
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
    self.tableView.estimatedRowHeight = 25;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = false;
    [self.tableView registerClass:[AppDetailAdditionalDetailsTableCell class] forCellReuseIdentifier:cellIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.tableView];
}

- (void) setupTableViewHeader{
    AppDetailDefaultHeader *tableHeader = [[AppDetailDefaultHeader alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 40)];
    [tableHeader configure: [NSLocalizedString(@"additionalDetails", nil) uppercaseString]];
    self.tableView.tableHeaderView = tableHeader;
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"tableView":self.tableView};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:viewsDict]];
}

//TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailTitles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDetailAdditionalDetailsTableCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    [cell configure:self.app detailTitle:self.detailTitles[indexPath.row]];
    return cell;
}

- (void) configure:(OCApp *)app detailTitles:(NSArray *)detailTitles{
    self.app = app;
    self.detailTitles = detailTitles;
    [self.tableView reloadData];
}

@end
