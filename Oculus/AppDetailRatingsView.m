//
//  AppDetailRatingsView.m
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "AppDetailRatingsView.h"

@implementation AppDetailRatingsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.clipsToBounds = true;
    
    //Setup Ratings Score Label
    [self setupRatingsScoreLabel];
    
    //Setup Ratings View
    [self setupRatingsView];
    
    //Setup Ratings Count Label
    [self setupRatingsCountLabel];
    
    //Setup Comfort ImageView
    [self setupComfortImageView];
    
    //Setup Comfort Label
    [self setupComfortLabel];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupRatingsScoreLabel{
    self.ratingsScoreLabel = [[UILabel alloc] init];
    self.ratingsScoreLabel.textColor = [UIColor whiteColor];
    self.ratingsScoreLabel.font = [UIFont boldSystemFontOfSize:36];
    self.ratingsScoreLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.ratingsScoreLabel];
}

- (void) setupRatingsView{
    self.ratingsView = [[HCSStarRatingView alloc] init];
    self.ratingsView.backgroundColor = [UIColor clearColor];
    self.ratingsView.maximumValue = 5;
    self.ratingsView.minimumValue = 0;
    self.ratingsView.allowsHalfStars = true;
    self.ratingsView.accurateHalfStars = true;
    self.ratingsView.tintColor = [UIColor whiteColor];
    self.ratingsView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.ratingsView];
}

- (void) setupRatingsCountLabel{
    self.ratingsCountLabel = [[UILabel alloc] init];
    self.ratingsCountLabel.textColor = [UIColor whiteColor];
    self.ratingsCountLabel.font = [UIFont systemFontOfSize:14];
    self.ratingsCountLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.ratingsCountLabel];
}

- (void) setupComfortImageView{
    self.comfortImageView = [[UIImageView alloc] init];
    self.comfortImageView.clipsToBounds = true;
    self.comfortImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.comfortImageView];
}

- (void) setupComfortLabel{
    self.comfortLabel = [[UILabel alloc] init];
    self.comfortLabel.textColor = [UIColor whiteColor];
    self.comfortLabel.font = [UIFont systemFontOfSize:14];
    self.comfortLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.comfortLabel];
}

- (void) setupConstraints{
    UIView *spacerView = [[UIView alloc] init];
    spacerView.userInteractionEnabled = false;
    spacerView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:spacerView];
    
    NSDictionary *viewsDict = @{@"ratingsScoreLabel": self.ratingsScoreLabel, @"ratingsView": self.ratingsView, @"ratingsCountLabel": self.ratingsCountLabel, @"comfortImageView": self.comfortImageView, @"comfortLabel": self.comfortLabel, @"spacerView": spacerView};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[ratingsScoreLabel(60)]-[ratingsView(70)][spacerView][comfortImageView(30)]-4-[comfortLabel]|" options:0 metrics:nil views:viewsDict]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.ratingsCountLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.ratingsView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.ratingsCountLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.ratingsView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    //Height & Vertical Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.ratingsScoreLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.ratingsView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:16]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.ratingsView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.ratingsScoreLabel attribute:NSLayoutAttributeTop multiplier:1 constant:2]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.ratingsCountLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.ratingsView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.comfortImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.comfortImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.comfortLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

- (void) configure:(OCApp *)app{
    //Ensure Ratings always have one decimal place
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:1];
    [formatter setMinimumFractionDigits:1];
    [formatter setRoundingMode: NSNumberFormatterRoundUp];
     
    self.ratingsScoreLabel.text = [formatter stringFromNumber:app.rating];
    self.ratingsView.value = [app.rating doubleValue];
    self.ratingsCountLabel.text = app.ratingCount.stringValue;
    self.comfortImageView.image = [UIImage imageNamed:app.intensity];
    self.comfortLabel.text = NSLocalizedString(app.intensity, nil);
}

@end
