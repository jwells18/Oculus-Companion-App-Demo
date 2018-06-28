//
//  SettingsTableFooter.m
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "SettingsTableFooter.h"
#import "Constants.h"

@implementation SettingsTableFooter

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.backgroundColor = COLOR_SECONDARY;
    
    //Setup Log Out Button
    [self setupLogoutButton];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupLogoutButton{
    self.logoutButton = [[UIButton alloc] init];
    [self.logoutButton setTitle:NSLocalizedString(@"logout", nil) forState:UIControlStateNormal];
    self.logoutButton.backgroundColor = [UIColor darkGrayColor];
    self.logoutButton.clipsToBounds = true;
    self.logoutButton.layer.cornerRadius = 5;
    self.logoutButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.logoutButton];
}

- (void) setupConstraints{
    //Width & Horizontal Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.9 constant:0]];
    //Height & Vertical Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.logoutButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50]];
}

@end
