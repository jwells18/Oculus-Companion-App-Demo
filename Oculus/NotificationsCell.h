//
//  NotificationsCell.h
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCNotification.h"

@protocol NotificationsCellDelegate <NSObject>

- (void)didPressImageButton:(UIButton *)sender;
- (void)didPressMoreButton:(UIButton *)sender;

@end


@interface NotificationsCell : UITableViewCell

@property (nonatomic, weak) id<NotificationsCellDelegate> notificationsCellDelegate;
@property (strong, nonatomic) UIButton *imageButton;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UIButton *moreButton;
- (void) configure:(OCNotification *)notification;

@end
