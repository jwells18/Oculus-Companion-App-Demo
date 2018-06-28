//
//  AppDetailPublisherCell.h
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCApp.h"

@interface AppDetailPublisherCell : UITableViewCell

@property (strong, nonatomic) UIImageView *ratingsImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
- (void) configure:(OCApp *)app;

@end
