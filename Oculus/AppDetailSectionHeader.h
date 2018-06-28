//
//  AppDetailSectionHeader.h
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCApp.h"

@interface AppDetailSectionHeader : UIView

@property (strong, nonatomic) UIButton *buyButton;
- (void) configure:(OCApp *)app;

@end
