//
//  SignInView.m
//  Oculus
//
//  Created by Justin Wells on 6/22/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "SignInView.h"
#import "Constants.h"

@implementation SignInView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.backgroundColor = COLOR_SECONDARY;
    self.alwaysBounceVertical = true;
    self.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    //Setup Title Label
    [self setupTitleLabel];
    
    //Setup Email TextField
    [self setupEmailField];
    
    //Setup Password TextField
    [self setupPasswordField];
    
    //Setup Forgot Password Button
    [self setupForgotPasswordButton];
    
    //Setup Reset Password Button
    [self setupResetPasswordButton];
    
    //Setup TapToResign
    [self setupTapToResignRecognizer];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupTapToResignRecognizer{
    //Gesture Recognizer to Resign Keyboard
    self.tapToResignKeyboardRecognizer = [[UITapGestureRecognizer alloc] init];
    self.tapToResignKeyboardRecognizer.numberOfTapsRequired = 1;
    self.tapToResignKeyboardRecognizer.numberOfTouchesRequired = 1;
    self.tapToResignKeyboardRecognizer.cancelsTouchesInView = false;
    [self addGestureRecognizer: self.tapToResignKeyboardRecognizer];
}

- (void) setupTitleLabel{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = NSLocalizedString(@"signInTitle", nil);
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:24];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.titleLabel];
}

- (void) setupEmailField{
    self.emailField = [[OCTextField alloc] init];
    [self.emailField configure:NSLocalizedString(@"email", nil) placeholder:NSLocalizedString(@"emailPlaceholder", nil)];
    self.emailField.textField.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailField.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.emailField.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.emailField];
}

- (void) setupPasswordField{
    self.passwordField = [[OCTextField alloc] init];
    [self.passwordField configure:NSLocalizedString(@"password", nil) placeholder:nil];
    self.passwordField.textField.secureTextEntry = true;
    self.passwordField.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.passwordField];
}

- (void) setupForgotPasswordButton{
    self.forgotPasswordButton = [[UIButton alloc] init];
    [self.forgotPasswordButton setTitle:NSLocalizedString(@"forgotPassword", nil) forState:UIControlStateNormal];
    self.forgotPasswordButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.forgotPasswordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.forgotPasswordButton];
}

- (void) setupResetPasswordButton{
    self.resetPasswordButton = [[UIButton alloc] init];
    [self.resetPasswordButton setTitle:NSLocalizedString(@"resetPassword", nil) forState:UIControlStateNormal];
    [self.resetPasswordButton setTitleColor:COLOR_TERTIARY forState:UIControlStateNormal];
    self.resetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.resetPasswordButton];
}

- (void) setupConstraints{
    //NSDictionary *viewsDict = @{@"titleLabel":self.titleLabel, @"emailField": self.emailField, @"passwordField": self.passwordField, @"forgotPasswordButton": self.forgotPasswordButton, @"resetPasswordButton": self.resetPasswordButton};
    //Width & Horizontal Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.9 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.emailField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.9 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.emailField attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.passwordField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.9 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.passwordField attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.forgotPasswordButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.forgotPasswordButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.4 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.resetPasswordButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.forgotPasswordButton attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.resetPasswordButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.4 constant:0]];
    //Height & Vertical Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:80]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.emailField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:80]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.emailField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.passwordField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.emailField attribute:NSLayoutAttributeBottom multiplier:1 constant:40]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.passwordField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.forgotPasswordButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.passwordField attribute:NSLayoutAttributeBottom multiplier:1 constant:40]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.forgotPasswordButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:20]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.resetPasswordButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.forgotPasswordButton attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.resetPasswordButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.forgotPasswordButton attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
}


@end
