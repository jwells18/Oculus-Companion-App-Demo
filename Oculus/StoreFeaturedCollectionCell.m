//
//  StoreFeaturedCollectionCell.m
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "StoreFeaturedCollectionCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIView+WebCache.h>
#import "StoreFormatter.h"

@implementation StoreFeaturedCollectionCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //Setup View
        [self setupView];
    }
    return self;
}

- (void) setupView{
    //Setup ImageView
    [self setupImageView];
    
    //Setup Price Button
    [self setupPriceButton];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupImageView{
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = true;
    self.imageView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.imageView];
}

- (void) setupPriceButton{
    self.priceButton = [[UIButton alloc] init];
    self.priceButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    self.priceButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.priceButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20);
    self.priceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.priceButton.userInteractionEnabled = false;
    self.priceButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.priceButton];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"imageView":self.imageView, @"priceButton": self.priceButton};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[imageView]-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.priceButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.priceButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    //Height & Vertical Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|" options:0 metrics:nil views:viewsDict]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.priceButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeHeight multiplier:0.18 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.priceButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
}

- (void) configure:(OCApp *)app{
    if(app.image != nil){
        [self.imageView sd_setShowActivityIndicatorView:true];
        [self.imageView sd_setIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:app.image]];
    }
    else{
        self.imageView.image = [UIImage imageNamed:@"oculusPlaceholder"];
    }
    StoreFormatter *storeFormatter = [[StoreFormatter alloc] init];
    [self.priceButton setAttributedTitle:[storeFormatter stringPriceFromApp:app] forState:UIControlStateNormal];
}

@end
