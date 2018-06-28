//
//  BottomNavigationBar.h
//  Oculus
//
//  Created by Justin Wells on 6/22/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomNavigationBar : UIView

@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;
- (void) configure:(NSString *)leftTitle rightTitle:(NSString *)rightTitle;

@end
