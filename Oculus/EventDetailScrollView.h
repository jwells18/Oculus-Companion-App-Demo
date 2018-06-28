//
//  EventDetailScrollView.h
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCEvent.h"

@interface EventDetailScrollView : UIScrollView

@property (strong, nonatomic) UIImageView *eventImageView;
@property (strong, nonatomic) UILabel *dateDayLabel;
@property (strong, nonatomic) UILabel *dateMonthLabel;
@property (strong, nonatomic) UILabel *dateTimeLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (strong, nonatomic) UILabel *interestedCountLabel;
@property (strong, nonatomic) UIButton *interestedButton;
- (void) configure:(OCEvent *)event;

@end
