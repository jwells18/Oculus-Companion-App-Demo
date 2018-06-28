//
//  AppDetailDescriptionCell.m
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "AppDetailDescriptionCell.h"
#import "Constants.h"

@interface AppDetailDescriptionCell()

@property (strong, nonatomic) NSLayoutConstraint *ratingsViewTopConstraint;
@property (strong, nonatomic) NSLayoutConstraint *ratingsViewHeightConstraint;

@end

@implementation AppDetailDescriptionCell

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
    
    //Setup AppDetail RatingsView
    [self setupAppDetailRatingsView];
    
    //Setup Description Label
    [self setupDescriptionLabel];
    
    //Setup Expand Button
    [self setupExpandButton];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupAppDetailRatingsView{
    self.ratingsView = [[AppDetailRatingsView alloc] init];
    self.ratingsView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.ratingsView];
}

- (void) setupDescriptionLabel{
    self.descriptionLabel = [[UILabel alloc] init];
    self.descriptionLabel.textColor = [UIColor whiteColor];
    self.descriptionLabel.font = [UIFont systemFontOfSize:14];
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.descriptionLabel];
}

- (void) setupExpandButton{
    self.expandButton = [[UIButton alloc] init];
    self.expandButton.backgroundColor = COLOR_SECONDARY;
    [self.expandButton setImage:[UIImage imageNamed:@"expand"] forState:UIControlStateNormal];
    self.expandButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.expandButton];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"ratingsView": self.ratingsView, @"descriptionLabel": self.descriptionLabel, @"expandButton": self.expandButton};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[ratingsView]-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[descriptionLabel]-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[expandButton]-|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    self.ratingsViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.ratingsView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
    [self addConstraint:self.ratingsViewHeightConstraint];
    self.ratingsViewTopConstraint = [NSLayoutConstraint constraintWithItem:self.ratingsView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [self addConstraint: self.ratingsViewTopConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.ratingsView attribute:NSLayoutAttributeBottom multiplier:1 constant:20]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.expandButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.descriptionLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.expandButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.expandButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40]];
}

- (void) configure:(OCApp *)app{
    if(app != nil){
        self.descriptionLabel.text = app.details;
        if([app.isPack isEqual:@0]){
            [self.ratingsView configure: app];
            //Show Ratings View
            self.ratingsViewTopConstraint.constant = 8;
            self.ratingsViewHeightConstraint.constant = 60;
            [self layoutIfNeeded];
        }
    }
}


@end
