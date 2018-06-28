//
//  FriendsCell.h
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCUser.h"

@protocol FriendsCellDelegate <NSObject>

- (void)didPressImageButton:(UIButton *)sender;

@end

@interface FriendsCell : UITableViewCell

@property (nonatomic, weak) id<FriendsCellDelegate> friendsCellDelegate;
@property (strong, nonatomic) UIButton *imageButton;
@property (strong, nonatomic) UILabel *titleLabel;
- (void) configure:(OCUser *)user;

@end
