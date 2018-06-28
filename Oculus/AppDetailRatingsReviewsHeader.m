//
//  AppDetailRatingsReviewsHeader.m
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "AppDetailRatingsReviewsHeader.h"
#import "Constants.h"
@implementation AppDetailRatingsReviewsHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.backgroundColor = COLOR_SECONDARY;
    
    //Setup Title Label
    [self setupTitleLabel];
    
    //Setup SeeAll Label
    [self setupSeeAllButton];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupTitleLabel{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = NSLocalizedString(@"ratingsAndReviews", nil);
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.titleLabel];
}

- (void) setupSeeAllButton{
    self.seeAllButton = [[UIButton alloc] init];
    [self.seeAllButton setTitle:NSLocalizedString(@"seeAll", nil) forState: UIControlStateNormal];
    self.seeAllButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    //TODO: Add Delegate for See All Button touches
    //[self.seeAllButton addTarget:self action:@selector(seeAllButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.seeAllButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.seeAllButton];
}

- (void) setupConstraints{
    //Width & Horizontal Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:8]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.seeAllButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-8]];
    //Height & Vertical Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.seeAllButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.seeAllButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

@end
