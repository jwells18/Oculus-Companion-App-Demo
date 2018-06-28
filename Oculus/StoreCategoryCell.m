//
//  StoreCategoryCell.m
//  Oculus
//
//  Created by Justin Wells on 6/22/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "StoreCategoryCell.h"
#import "Constants.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIView+WebCache.h>
#import "StoreFormatter.h"

@interface StoreCategoryCell()

@property (strong, nonatomic) NSLayoutConstraint *ratingsViewTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *ratingsViewHeightConstraint;

@end

@implementation StoreCategoryCell

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
    self.clipsToBounds = true;
    
    //Setup Main ImageView
    [self setupMainImageView];
    
    //Setup Title Label
    [self setupTitleLabel];
    
    //Setup Ratings View
    [self setupRatingsView];
    
    //Setup Ratings Count Label
    [self setupRatingsCountLabel];
    
    //Setup SubTitle Label
    [self setupSubTitleLabel];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupMainImageView{
    self.mainImageView = [[UIImageView alloc] init];
    self.mainImageView.clipsToBounds = true;
    self.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.mainImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.mainImageView];
}

- (void) setupTitleLabel{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.titleLabel];
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
    self.ratingsCountLabel.font = [UIFont systemFontOfSize:12];
    self.ratingsCountLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.ratingsCountLabel];
}

- (void) setupSubTitleLabel{
    self.subTitleLabel = [[UILabel alloc] init];
    self.subTitleLabel.textColor = [UIColor whiteColor];
    self.subTitleLabel.font = [UIFont systemFontOfSize:14];
    self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.subTitleLabel];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"mainImageView":self.mainImageView, @"titleLabel": self.titleLabel, @"ratingsView": self.ratingsView, @"ratingsCountLabel": self.ratingsCountLabel, @"subTitleLabel": self.subTitleLabel};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[mainImageView(120)]-[titleLabel]-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.ratingsView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.ratingsView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:70]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.ratingsCountLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.ratingsView attribute:NSLayoutAttributeRight multiplier:1 constant:8]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.ratingsCountLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeWidth multiplier:1 constant:-104]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    //Height & Vertical Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[mainImageView]-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.mainImageView attribute:NSLayoutAttributeTop multiplier:1 constant:2]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:18]];
    self.ratingsViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.ratingsView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self addConstraint: self.ratingsViewTopConstraint];
    self.ratingsViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.ratingsView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
    [self addConstraint: self.ratingsViewHeightConstraint];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.ratingsView attribute:NSLayoutAttributeBottom multiplier:1 constant:12]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:18]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.ratingsCountLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.ratingsView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.ratingsCountLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.ratingsView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
}

- (void) configure:(OCApp *)app{
    if(app != nil){
        if(app.image != nil && app.image.length > 0){
            [self.mainImageView sd_setShowActivityIndicatorView:true];
            [self.mainImageView sd_setIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:app.image]];
        }
        else{
            self.mainImageView.image = [UIImage imageNamed:@"oculusPlaceholder"];
        }
        self.titleLabel.text = app.name;
        if([app.isPack isEqual:@0]){
            self.ratingsView.value = [app.rating doubleValue];
            self.ratingsCountLabel.text = app.ratingCount.stringValue;
            //Show Ratings View
            self.ratingsViewTopConstraint.constant = 12;
            self.ratingsViewHeightConstraint.constant = 16;
            [self layoutIfNeeded];
        }
        StoreFormatter *storeFormatter = [[StoreFormatter alloc] init];
        self.subTitleLabel.attributedText = [storeFormatter stringPriceFromApp: app];
    }
}

@end
