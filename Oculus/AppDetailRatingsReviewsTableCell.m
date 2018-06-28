//
//  AppDetailRatingsReviewsTableCell.m
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "AppDetailRatingsReviewsTableCell.h"
#import "Constants.h"

@implementation AppDetailRatingsReviewsTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Setup View
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.backgroundColor = COLOR_SECONDARY;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //Setup Image Button
    [self setupImageButton];
    
    //Setup Name Label
    [self setupNameLabel];
    
    //Setup Ratings View
    [self setupRatingsView];
    
    //Setup Title Label
    [self setupTitleLabel];
    
    //Setup SubTitle Label
    [self setupSubTitleLabel];
    
    //Setup More Button
    [self setupMoreButton];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupImageButton{
    self.imageButton = [[UIButton alloc] init];
    self.imageButton.backgroundColor = [UIColor darkGrayColor];
    self.imageButton.contentMode = UIViewContentModeScaleAspectFill;
    self.imageButton.clipsToBounds = true;
    self.imageButton.layer.cornerRadius = 40/2;
    self.imageButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.imageButton];
}

- (void) setupNameLabel{
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.nameLabel];
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

- (void) setupTitleLabel{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.titleLabel];
}

- (void) setupSubTitleLabel{
    self.subTitleLabel = [[UILabel alloc] init];
    self.subTitleLabel.textColor = [UIColor whiteColor];
    self.subTitleLabel.font = [UIFont systemFontOfSize:14];
    self.subTitleLabel.numberOfLines = 0;
    self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.subTitleLabel];
}

- (void) setupMoreButton{
    self.moreButton = [[UIButton alloc] init];
    [self.moreButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    self.moreButton.clipsToBounds = true;
    self.moreButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.moreButton];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"imageButton":self.imageButton, @"nameLabel": self.nameLabel, @"ratingsView": self.ratingsView, @"titleLabel": self.titleLabel, @"subTitleLabel": self.subTitleLabel, @"moreButton": self.moreButton};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[imageButton(40)]-[nameLabel]-[moreButton(25)]-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-56-[titleLabel]-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.ratingsView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.ratingsView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:70]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    //Height & Vertical Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.imageButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:8]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.imageButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:40]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageButton attribute:NSLayoutAttributeTop multiplier:1 constant:2]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:16]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.ratingsView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.ratingsView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:16]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageButton attribute:NSLayoutAttributeBottom multiplier:1 constant:2]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:4]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-8]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.moreButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.imageButton attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.moreButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:25]];
}

- (void) configure: (OCApp *)app{
    [self.imageButton setImage:[UIImage imageNamed:@"sampleUserPicture1"] forState:UIControlStateNormal];
    self.nameLabel.text = @"lazyboss101 05/26/2017";
    self.titleLabel.text = @"Super fun and challenging";
    self.subTitleLabel.text = @"I didn't try the online yet but man tis game is so fun, the graphics is good and work smoothly, unlike the other demo games we are paying for, this game totally worth the money, it feels almost a complete game with may hours of playing.\nI wish they will add the new gear vr controller so we can fly to all directions while looking around it will be amazing. Please do it\n\nAnd add me for challenge: lazyboss101";
    self.ratingsView.value = 4.4;
}

@end
