//
//  AppDetailDefaultHeader.h
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDetailDefaultHeader : UIView

@property (strong, nonatomic) UILabel *titleLabel;
- (void) configure:(NSString *)title;

@end
