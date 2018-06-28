//
//  AppDetailSectionHeader.m
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "AppDetailSectionHeader.h"
#import "Constants.h"
#import "StoreFormatter.h"

@implementation AppDetailSectionHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.backgroundColor = COLOR_SECONDARY;
    
    //Setup Buy Button
    [self setupBuyButton];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupBuyButton{
    self.buyButton = [[UIButton alloc] init];
    self.buyButton.backgroundColor = COLOR_TERTIARY;
    self.buyButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.buyButton.layer.cornerRadius = 5;
    self.buyButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.buyButton];
}

- (void) setupConstraints{
    //Width & Horizontal Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.buyButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.buyButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.9 constant:0]];
    //Height & Vertical Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.buyButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.buyButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40]];
}

- (void) configure:(OCApp *)app{
    if(app != nil){
        StoreFormatter *storeFormatter = [[StoreFormatter alloc] init];
        [self.buyButton setAttributedTitle: [storeFormatter stringPriceFromApp: app] forState:UIControlStateNormal];
    }
}

@end
