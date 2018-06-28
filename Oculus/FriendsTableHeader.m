//
//  FriendsTableHeader.m
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "FriendsTableHeader.h"
#import "Constants.h"

@implementation FriendsTableHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.backgroundColor = COLOR_SECONDARY;
    
    //Setup Add Button
    [self setupAddButton];
    
    //Setup TextLabel
    [self setupTextLabel];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupAddButton{
    self.addButton = [[UIButton alloc] init];
    self.addButton.backgroundColor = [UIColor darkGrayColor];
    [self.addButton setImage: [UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    self.addButton.clipsToBounds = true;
    self.addButton.layer.cornerRadius = 50/2;
    self.addButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.addButton];
}

- (void) setupTextLabel{
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.text = NSLocalizedString(@"addFriends", nil);
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.font = [UIFont boldSystemFontOfSize:14];
    self.textLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.textLabel];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"addButton":self.addButton, @"textLabel": self.textLabel};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[addButton(50)]-12-[textLabel]" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.addButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.addButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

@end
