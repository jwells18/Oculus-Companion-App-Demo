//
//  SettingsTableHeader.m
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "SettingsTableHeader.h"
#import "Constants.h"
#import <SDWebImage/UIView+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
@import Firebase;

@implementation SettingsTableHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.backgroundColor = COLOR_SECONDARY;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    
    //Setup User Button
    [self setupUserButton];
    
    //Setup Main Label
    [self setupMainLabel];
    
    //Setup Main SubLabel
    [self setupMainSubLabel];
    
    //Setup Headset Button
    [self setupHeadsetButton];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupUserButton{
    self.userButton = [[UIButton alloc] init];
    self.userButton.backgroundColor = COLOR_QUATERNARY;
    self.userButton.clipsToBounds = true;
    self.userButton.layer.cornerRadius = 40/2;
    self.userButton.layer.borderWidth = 0.5;
    self.userButton.layer.borderColor = [[UIColor redColor] CGColor];
    self.userButton.contentMode = UIViewContentModeScaleAspectFill;
    self.userButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.userButton];
}

- (void) setupMainLabel{
    self.mainLabel = [[UILabel alloc] init];
    self.mainLabel.textColor = [UIColor whiteColor];
    self.mainLabel.font = [UIFont boldSystemFontOfSize:14];
    self.mainLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.mainLabel];
}

- (void) setupMainSubLabel{
    self.mainSubLabel = [[UILabel alloc] init];
    self.mainSubLabel.textColor = [UIColor whiteColor];
    self.mainSubLabel.font = [UIFont systemFontOfSize:12];
    self.mainSubLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.mainSubLabel];
}

- (void) setupHeadsetButton{
    self.headsetButton = [[SettingsHeadsetButton alloc] init];
    self.headsetButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.headsetButton];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"userButton":self.userButton, @"mainLabel": self.mainLabel, @"mainSubLabel": self.mainSubLabel, @"headsetButton": self.headsetButton};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[userButton(40)]-16-[mainLabel]" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headsetButton]|" options:0 metrics:nil views:viewsDict]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.mainSubLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.mainLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    //Height & Vertical Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[userButton(40)]-[headsetButton(50)]|" options:0 metrics:nil views:viewsDict]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.mainLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.userButton attribute:NSLayoutAttributeTop multiplier:1 constant:3]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.mainLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:18]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.mainSubLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.userButton attribute:NSLayoutAttributeBottom multiplier:1 constant:-3]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.mainSubLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:16]];
}

- (void) configure:(OCUser *) user{
    //TODO: Change to OCUser in the future
    FIRUser *currentUser = [[FIRAuth auth] currentUser];
    [self sd_setShowActivityIndicatorView:true];
    [self sd_setIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self sd_setImageWithURL:currentUser.photoURL forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"accountPlaceholder"]];
    [self.userButton sd_setShowActivityIndicatorView:true];
    [self.userButton sd_setIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.userButton sd_setImageWithURL:currentUser.photoURL forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"accountPlaceholder"]];
    self.mainLabel.text = currentUser.displayName;
    self.mainSubLabel.text = currentUser.email;
}

@end
