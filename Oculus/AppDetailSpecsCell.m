//
//  AppDetailSpecsCell.m
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "AppDetailSpecsCell.h"
#import "Constants.h"

static NSString *cellIdentifier = @"cell";

@interface AppDetailSpecsCell () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) OCApp *app;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation AppDetailSpecsCell

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
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    cell.backgroundColor = COLOR_SECONDARY;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0){
        if(self.app != nil){
            cell.imageView.image = [UIImage imageNamed:self.app.esrbRating];
            cell.textLabel.text = NSLocalizedString(self.app.esrbRating, nil);
        }
    }
    else if (indexPath.row == 1){
        cell.imageView.image = [UIImage imageNamed:@"version"];
        if(self.app != nil){
            cell.textLabel.text = NSLocalizedString(self.app.refundPolicy, nil);
        }
    }
    else if (indexPath.row == 2){
        cell.imageView.image = [UIImage imageNamed:@"platform"];
        if(self.app != nil){
            NSMutableArray *platforms = [[self.app.platforms allKeys] mutableCopy];
            for (int i = 0; i < platforms.count; i++) {
                NSString *rawString = platforms[i];
                [platforms replaceObjectAtIndex:i withObject:NSLocalizedString(rawString, nil)];
            }
            NSString *platformString = [platforms componentsJoinedByString:@", "];
            cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"platform", nil), platformString];
        }
    }
    else if (indexPath.row == 3){
        cell.imageView.image = [UIImage imageNamed:@"internetConnection"];
        if(self.app != nil){
            if([self.app.isInternetRequired isEqual: @1]){
                cell.textLabel.text = NSLocalizedString(@"internetIsRequired", nil);
            }
            else{
                cell.textLabel.text = NSLocalizedString(@"internetIsNotRequired", nil);
            }
        }
    }
    else if (indexPath.row == 4){
        cell.imageView.image = [UIImage imageNamed:@"storage"];
        if(self.app != nil){
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@", self.app.storageSize, NSLocalizedString(@"storageDefaultSize", nl)];
        }
    }
    else{
        cell.imageView.image = [UIImage new];
        cell.textLabel.text = @"";
    }
    return cell;
}

- (void) configure:(OCApp *)app{
    self.app = app;
    [self.tableView reloadData];
}


@end
