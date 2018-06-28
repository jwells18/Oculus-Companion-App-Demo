//
//  AppDetailDescriptionCell.h
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDetailRatingsView.h"
#import "OCApp.h"

@interface AppDetailDescriptionCell : UITableViewCell

@property (strong, nonatomic) AppDetailRatingsView *ratingsView;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UIButton *expandButton;
- (void) configure:(OCApp *)app;

@end
