//
//  AppDetailRequirementsCell.m
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "AppDetailRequirementsCell.h"
#import "Constants.h"
#import "AppDetailDefaultHeader.h"
#import "AppDetailRequirementsFooter.h"

static NSString *cellIdentifier = @"cell";

@interface AppDetailRequirementsCell () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) OCApp *app;
@property (strong, nonatomic) NSArray *appRequirements;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation AppDetailRequirementsCell

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
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = COLOR_SECONDARY;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = false;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.tableView];
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
    return self.appRequirements.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AppDetailDefaultHeader *sectionHeader = [[AppDetailDefaultHeader alloc] init];
    [sectionHeader configure: NSLocalizedString(@"requires", nil)];
    return sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(self.app.images != nil){
        return 200;
    }
    else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(self.app.images != nil){
        AppDetailRequirementsFooter *sectionFooter = [[AppDetailRequirementsFooter alloc] init];
        [sectionFooter configure:self.app];
        return sectionFooter;
    }
    else{
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    cell.backgroundColor = COLOR_SECONDARY;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(self.app != nil){
        cell.imageView.image = [UIImage imageNamed:self.appRequirements[indexPath.row]];
        cell.textLabel.text = NSLocalizedString(self.appRequirements[indexPath.row], nil);
    }
    else{
        cell.imageView.image = [UIImage new];
        cell.textLabel.text = @"";
    }
    return cell;
}

- (void) configure:(OCApp *)app{
    self.app = app;
    self.appRequirements = [app.requirements allKeys];
    [self.tableView reloadData];
}

@end
