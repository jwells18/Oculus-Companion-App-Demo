//
//  AppDetailRatingsReviewsTableCell.h
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "OCApp.h"

@interface AppDetailRatingsReviewsTableCell : UITableViewCell

@property (strong, nonatomic) UIButton *imageButton;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) HCSStarRatingView *ratingsView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (strong, nonatomic) UIButton *moreButton;
- (void) configure:(OCApp *)app;

@end
