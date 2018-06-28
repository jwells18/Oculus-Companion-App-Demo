//
//  SignInView.h
//  Oculus
//
//  Created by Justin Wells on 6/22/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCTextField.h"

@interface SignInView : UIScrollView

@property (strong, nonatomic) UITapGestureRecognizer *tapToResignKeyboardRecognizer;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) OCTextField *emailField;
@property (strong, nonatomic) OCTextField *passwordField;
@property (strong, nonatomic) UIButton *forgotPasswordButton;
@property (strong, nonatomic) UIButton *resetPasswordButton;

@end
