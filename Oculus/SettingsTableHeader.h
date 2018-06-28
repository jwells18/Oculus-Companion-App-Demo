//
//  SettingsTableHeader.h
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCUser.h"
#import "SettingsHeadsetButton.h"

@interface SettingsTableHeader : UIButton

@property (strong, nonatomic) UIButton *userButton;
@property (strong, nonatomic) UILabel *mainLabel;
@property (strong, nonatomic) UILabel *mainSubLabel;
@property (strong, nonatomic) SettingsHeadsetButton *headsetButton;
- (void) configure:(OCUser *)user;

@end
