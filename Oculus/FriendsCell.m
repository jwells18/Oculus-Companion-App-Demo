//
//  FriendsCell.m
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "FriendsCell.h"
#import "Constants.h"
#import <SDWebImage/UIButton+WebCache.h>

@implementation FriendsCell

@synthesize friendsCellDelegate;

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
    
    //Setup Title Label
    [self setupTitleLabel];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupImageButton{
    self.imageButton = [[UIButton alloc] init];
    self.imageButton.backgroundColor = [UIColor darkGrayColor];
    self.imageButton.contentMode = UIViewContentModeScaleAspectFill;
    self.imageButton.clipsToBounds = true;
    self.imageButton.layer.cornerRadius = 50/2;
    self.imageButton.layer.borderColor = [UIColor redColor].CGColor;
    self.imageButton.layer.borderWidth = 0.5;
    [self.imageButton addTarget:self action:@selector(imageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.imageButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.imageButton];
}

- (void) setupTitleLabel{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.titleLabel];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"imageButton":self.imageButton, @"titleLabel": self.titleLabel};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[imageButton(50)]-20-[titleLabel]-|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.imageButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.imageButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

- (void) configure: (OCUser *)user{
    //TODO: Update to OCUser data once friends database is established
    [self.imageButton setImage: [UIImage imageNamed:@"sampleUserPicture1" ] forState:UIControlStateNormal];
    self.titleLabel.text = @"william23";
}

//Button Delegate
- (void) imageButtonPressed:(id) sender{
    if ([friendsCellDelegate respondsToSelector:@selector(didPressImageButton:)]){
        [friendsCellDelegate didPressImageButton:sender];
    }
}

@end
