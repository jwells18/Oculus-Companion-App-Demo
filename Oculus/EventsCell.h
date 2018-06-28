//
//  EventsCell.h
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCEvent.h"

@protocol EventsCellDelegate <NSObject>

- (void)relayDidPressReadMoreButton:(UIButton *)sender;
- (void)relayDidPressInterestedButton:(UIButton *)sender;

@end

@interface EventsCell : UITableViewCell

@property (nonatomic, weak) id<EventsCellDelegate> eventsCellDelegate;
@property (strong, nonatomic) UIImageView *eventImageView;
@property (strong, nonatomic) UILabel *dateDayLabel;
@property (strong, nonatomic) UILabel *dateMonthLabel;
@property (strong, nonatomic) UILabel *dateTimeLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (strong, nonatomic) UIButton *readMoreButton;
@property (strong, nonatomic) UILabel *interestedCountLabel;
@property (strong, nonatomic) UIButton *interestedButton;
- (void) configure:(OCEvent *)event;

@end
