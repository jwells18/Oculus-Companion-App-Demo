//
//  AppDetailExperiencesCell.m
//  Oculus
//
//  Created by Justin Wells on 6/26/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "AppDetailExperiencesCell.h"
#import "Constants.h"
#import "AppDetailDefaultHeader.h"
#import "StoreCategoryCell.h"

static NSString *cellIdentifier = @"cell";

@interface AppDetailExperiencesCell() <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) OCApp *app;
@property (strong, nonatomic) NSArray *packApps;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) AppDetailDefaultHeader *tableHeader;

@end

@implementation AppDetailExperiencesCell

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
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = false;
    [self.tableView registerClass:[StoreCategoryCell class] forCellReuseIdentifier:cellIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.tableView];
}

- (void) setupTableViewHeader{
    self.tableHeader = [[AppDetailDefaultHeader alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 40)];
    [self.tableHeader configure: [NSString stringWithFormat:@"%lu %@", (unsigned long)self.packApps.count, NSLocalizedString(@"experience", nil)]];
    self.tableView.tableHeaderView = self.tableHeader;
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
    return self.packApps.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    OCApp *app = [self createApp: self.packApps[indexPath.row]];
    [cell configure:app];
    return cell;
}

- (void) configure:(OCApp *)app{
    self.app = app;
    self.packApps = [[NSArray alloc] initWithArray:app.packApps];
    [self.tableHeader configure: [NSString stringWithFormat:@"%lu %@", (unsigned long)self.packApps.count, NSLocalizedString(@"experience", nil)]];
    [self.tableView reloadData];
}

- (OCApp *) createApp:(NSDictionary *)rawPackAppData{
    OCApp *app = [[OCApp alloc] init];
    app.objectId = [rawPackAppData objectForKey:@"objectId"];
    app.name = [rawPackAppData objectForKey:@"name"];
    app.price = [rawPackAppData objectForKey:@"price"];
    app.salePrice = [rawPackAppData objectForKey:@"salePrice"];
    app.image = [rawPackAppData objectForKey:@"image"];
    app.isPack = [rawPackAppData objectForKey:@"isPack"];
    app.rating = [rawPackAppData objectForKey:@"rating"];
    app.ratingCount = [rawPackAppData objectForKey:@"ratingCount"];
    
    return app;
}

@end
