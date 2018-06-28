//
//  OCTextField.h
//  Oculus
//
//  Created by Justin Wells on 6/22/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCTextField : UIView

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIView *textFieldBottomLine;
- (void) configure:(NSString *)title placeholder:(NSString *)placeholder;

@end
