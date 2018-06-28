//
//  OCTableSectionHeader.m
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "OCTableSectionHeader.h"
#import "Constants.h"

@implementation OCTableSectionHeader

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
    
    //Setup Separator Line
    [self setupSeparatorLine];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupTitleLabel{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.titleLabel];
}

- (void) setupSeparatorLine{
    self.separatorLine = [[UIView alloc] init];
    self.separatorLine.backgroundColor = [UIColor darkGrayColor];
    self.separatorLine.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.separatorLine];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"titleLabel": self.titleLabel, @"separatorLine": self.separatorLine};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[titleLabel]-16-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[separatorLine]|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[separatorLine(0.5)]|" options:0 metrics:nil views:viewsDict]];
}

- (void) configure:(NSString *)title{
    self.titleLabel.text = title;
}

@end
