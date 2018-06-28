//
//  StoreCategoryCell.h
//  Oculus
//
//  Created by Justin Wells on 6/22/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "OCApp.h"

@interface StoreCategoryCell : UITableViewCell

@property (strong, nonatomic) UIImageView *mainImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) HCSStarRatingView *ratingsView;
@property (strong, nonatomic) UILabel *ratingsCountLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
- (void) configure:(OCApp *)app;

@end
