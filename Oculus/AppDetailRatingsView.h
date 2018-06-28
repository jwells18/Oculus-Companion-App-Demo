//
//  AppDetailRatingsView.h
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "OCApp.h"

@interface AppDetailRatingsView : UIView

@property (strong, nonatomic) UILabel *ratingsScoreLabel;
@property (strong, nonatomic) HCSStarRatingView *ratingsView;
@property (strong, nonatomic) UILabel *ratingsCountLabel;
@property (strong, nonatomic) UIImageView *comfortImageView;
@property (strong, nonatomic) UILabel *comfortLabel;
- (void) configure:(OCApp *)app;

@end
