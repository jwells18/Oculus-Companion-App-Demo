//
//  FacebookButton.m
//  Oculus
//
//  Created by Justin Wells on 6/22/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "FacebookButton.h"
#import "Constants.h"

@implementation FacebookButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.backgroundColor = COLOR_TERTIARY;
    self.layer.cornerRadius = 5;
    
    //Setup Icon ImageView
    [self setupIconImageView];
    
    //Setup TextLabel
    [self setupTextLabel];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupIconImageView{
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.image = [UIImage imageNamed:@"facebook"];
    self.iconImageView.clipsToBounds = true;
    self.iconImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview: self.iconImageView];
}

- (void) setupTextLabel{
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.text = NSLocalizedString(@"continueWithFacebook", nil);
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.font = [UIFont boldSystemFontOfSize:14];
    self.textLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.textLabel];
}

- (void) setupConstraints{
    UIView *spacerViewLeft = [[UIView alloc] init];
    spacerViewLeft.userInteractionEnabled = false;
    spacerViewLeft.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:spacerViewLeft];
    
    UIView *spacerViewRight = [[UIView alloc] init];
    spacerViewRight.userInteractionEnabled = false;
    spacerViewRight.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:spacerViewRight];
    
    NSDictionary *viewsDict = @{@"iconImageView":self.iconImageView, @"textLabel": self.textLabel, @"spacerViewLeft": spacerViewLeft, @"spacerViewRight": spacerViewRight};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[spacerViewLeft(==spacerViewRight)][iconImageView(18)]-16-[textLabel][spacerViewRight(==spacerViewLeft)]|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:18]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:spacerViewLeft attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:spacerViewRight attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

@end
