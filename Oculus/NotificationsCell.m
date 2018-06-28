//
//  NotificationsCell.m
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "NotificationsCell.h"
#import "Constants.h"
#import "DateManager.h"
#import <SDWebImage/UIView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>


@implementation NotificationsCell

@synthesize notificationsCellDelegate;

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
    
    //Setup SubTitle Label
    [self setupSubTitleLabel];
    
    //Setup Date Label
    [self setupDateLabel];
    
    //Setup More Button
    [self setupMoreButton];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupImageButton{
    self.imageButton = [[UIButton alloc] init];
    self.imageButton.backgroundColor = [UIColor darkGrayColor];
    self.imageButton.clipsToBounds = true;
    self.imageButton.layer.cornerRadius = 40/2;
    [self.imageButton addTarget:self action:@selector(imageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.imageButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.imageButton];
}

- (void) setupTitleLabel{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor grayColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.titleLabel];
}

- (void) setupSubTitleLabel{
    self.subTitleLabel = [[UILabel alloc] init];
    self.subTitleLabel.textColor = [UIColor grayColor];
    self.subTitleLabel.font = [UIFont systemFontOfSize:12];
    self.subTitleLabel.numberOfLines = 2;
    self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.subTitleLabel];
}

- (void) setupDateLabel{
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.textColor = [UIColor darkGrayColor];
    self.dateLabel.font = [UIFont systemFontOfSize:12];
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.dateLabel];
}

- (void) setupMoreButton{
    self.moreButton = [[UIButton alloc] init];
    [self.moreButton setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    self.moreButton.clipsToBounds = true;
    [self.moreButton addTarget:self action:@selector(moreButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.moreButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.moreButton];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"imageButton":self.imageButton, @"titleLabel": self.titleLabel, @"subTitleLabel": self.subTitleLabel, @"dateLabel": self.dateLabel, @"moreButton": self.moreButton};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[imageButton(40)]-16-[subTitleLabel]-[moreButton(20)]-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.subTitleLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.subTitleLabel attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.dateLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.subTitleLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.dateLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.subTitleLabel attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    //Height & Vertical Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.imageButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.imageButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.subTitleLabel attribute:NSLayoutAttributeTop multiplier:1 constant:-4]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.dateLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.subTitleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:4]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.moreButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.moreButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:20]];
}

- (void) configure: (OCNotification *)notification{
    if (notification != nil){
        if(notification.userImage != nil){
            [self.imageButton sd_setShowActivityIndicatorView:true];
            [self.imageButton sd_setIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            [self.imageButton sd_setImageWithURL:[NSURL URLWithString:notification.userImage] forState:UIControlStateNormal];
        }
        else{
            [self.imageButton setImage:[UIImage imageNamed:@"oculusStadiumSmall"] forState:UIControlStateNormal];
        }
        self.titleLabel.text = notification.title;
        self.subTitleLabel.text = notification.message;
        DateManager *dateManager = [[DateManager alloc] init];
        self.dateLabel.text= [dateManager shortDateAndTimeString:notification.createdAt];
    }
}

//Button Delegates
- (void) imageButtonPressed:(UIButton *) sender{
    if ([notificationsCellDelegate respondsToSelector:@selector(didPressImageButton:)]){
        [notificationsCellDelegate didPressImageButton:sender];
    }
}

- (void) moreButtonPressed:(UIButton *) sender{
    if ([notificationsCellDelegate respondsToSelector:@selector(didPressMoreButton:)]){
        [notificationsCellDelegate didPressMoreButton:sender];
    }
}

@end
