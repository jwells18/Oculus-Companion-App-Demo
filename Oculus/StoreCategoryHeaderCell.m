//
//  StoreCategoryHeaderCell.m
//  Oculus
//
//  Created by Justin Wells on 6/22/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "StoreCategoryHeaderCell.h"

@implementation StoreCategoryHeaderCell

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //Setup View
        [self setupView];
    }
    return self;
}

- (void) setupView{
    //Setup Icon ImageView
    [self setupIconImageView];
    
    //Setup Title Label
    [self setupTitleLabel];
    
    //Setup SubTitle Label
    [self setupSubTitleLabel];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupIconImageView{
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.clipsToBounds = true;
    self.iconImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.iconImageView];
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
    self.subTitleLabel.font = [UIFont systemFontOfSize:12];
    self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.subTitleLabel];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"iconImageView":self.iconImageView, @"titleLabel": self.titleLabel, @"subTitleLabel": self.subTitleLabel};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[titleLabel]-[iconImageView(12)]-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[subTitleLabel]-|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[titleLabel][subTitleLabel]" options:0 metrics:nil views:viewsDict]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:12]];
}

- (void) configure:(NSString *)title subTitle:(NSString *)subTitle{
    self.iconImageView.image = [UIImage imageNamed:@"expand"];
    self.titleLabel.text = title;
    self.subTitleLabel.text = subTitle;
}

@end
