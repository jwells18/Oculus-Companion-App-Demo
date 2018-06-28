//
//  BottomNavigationBar.m
//  Oculus
//
//  Created by Justin Wells on 6/22/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "BottomNavigationBar.h"
#import "Constants.h"

@implementation BottomNavigationBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.backgroundColor = COLOR_SECONDARY;
    
    //Setup Left Button
    [self setupLeftButton];
    
    //Setup Right Button
    [self setupRightButton];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupLeftButton{
    self.leftButton = [[UIButton alloc] init];
    self.leftButton.backgroundColor = COLOR_QUATERNARY;
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.leftButton.layer.cornerRadius = 5;
    self.leftButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview: self.leftButton];
}

- (void) setupRightButton{
    self.rightButton = [[UIButton alloc] init];
    self.rightButton.backgroundColor = COLOR_QUATERNARY;
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.rightButton.layer.cornerRadius = 5;
    self.rightButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview: self.rightButton];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"leftButton": self.leftButton, @"rightButton": self.rightButton};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[leftButton(==rightButton)]-16-[rightButton(==leftButton)]-16-|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[leftButton(40)]" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rightButton(40)]" options:0 metrics:nil views:viewsDict]];
}

- (void) configure:(NSString *)leftTitle rightTitle:(NSString *)rightTitle{
    [self.leftButton setTitle:leftTitle forState:UIControlStateNormal];
    [self.rightButton setTitle:rightTitle forState:UIControlStateNormal];
}

@end
