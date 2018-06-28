//
//  SettingsHeadsetButton.m
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "SettingsHeadsetButton.h"
#import "Constants.h"

@implementation SettingsHeadsetButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.backgroundColor = COLOR_QUATERNARY;
    
    //Setup Icon ImageView
    [self setupIconImageView];
    
    //Setup TextLabel
    [self setupTextLabel];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupIconImageView{
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.image = [UIImage imageNamed:@"platform"];
    self.iconImageView.clipsToBounds = true;
    self.iconImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview: self.iconImageView];
}

- (void) setupTextLabel{
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.text = NSLocalizedString(@"pairNewHeadset", nil);
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.font = [UIFont boldSystemFontOfSize:14];
    self.textLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.textLabel];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"iconImageView":self.iconImageView, @"textLabel": self.textLabel};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[iconImageView(25)]-16-[textLabel]-|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:25]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

@end
