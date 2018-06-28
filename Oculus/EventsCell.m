//
//  EventsCell.m
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "EventsCell.h"
#import "Constants.h"
#import "DateManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIView+WebCache.h>

@implementation EventsCell

@synthesize eventsCellDelegate;

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
    
    //Setup Event ImageView
    [self setupEventImageView];
    
    //Setup DateDay Label
    [self setupDateDayLabel];
    
    //Setup DateMonth Label
    [self setupDateMonthLabel];
    
    //Setup DateTime Label
    [self setupDateTimeLabel];
    
    //Setup Title Label
    [self setupTitleLabel];
    
    //Setup SubTitle Label
    [self setupSubTitleLabel];
    
    //Setup ReadMore Button
    [self setupReadMoreButton];
    
    //Setup InterestedCount Label
    [self setupInterestedCountLabel];
    
    //Setup Interested Button
    [self setupInterestedButton];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupEventImageView{
    self.eventImageView = [[UIImageView alloc] init];
    self.eventImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.eventImageView.clipsToBounds = true;
    self.eventImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.eventImageView];
}

- (void) setupDateDayLabel{
    self.dateDayLabel = [[UILabel alloc] init];
    self.dateDayLabel.textColor = [UIColor whiteColor];
    self.dateDayLabel.font = [UIFont boldSystemFontOfSize:36];
    self.dateDayLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.dateDayLabel];
}

- (void) setupDateMonthLabel{
    self.dateMonthLabel = [[UILabel alloc] init];
    self.dateMonthLabel.textColor = [UIColor whiteColor];
    self.dateMonthLabel.font = [UIFont systemFontOfSize:12];
    self.dateMonthLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.dateMonthLabel];
}

- (void) setupDateTimeLabel{
    self.dateTimeLabel = [[UILabel alloc] init];
    self.dateTimeLabel.textColor = [UIColor whiteColor];
    self.dateTimeLabel.font = [UIFont systemFontOfSize:12];
    self.dateTimeLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.dateTimeLabel];
}

- (void) setupTitleLabel{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.titleLabel];
}

- (void) setupSubTitleLabel{
    self.subTitleLabel = [[UILabel alloc] init];
    self.subTitleLabel.textColor = [UIColor whiteColor];
    self.subTitleLabel.font = [UIFont systemFontOfSize:14];
    self.subTitleLabel.numberOfLines = 2;
    self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.subTitleLabel];
}

- (void) setupReadMoreButton{
    self.readMoreButton = [[UIButton alloc] init];
    [self.readMoreButton setTitle:NSLocalizedString(@"readMore", nil) forState: UIControlStateNormal];
    self.readMoreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.readMoreButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.readMoreButton setTitleColor:COLOR_TERTIARY forState:UIControlStateNormal];
    [self.readMoreButton addTarget:self action:@selector(readMoreButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.readMoreButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.readMoreButton];
}

- (void) setupInterestedCountLabel{
    self.interestedCountLabel = [[UILabel alloc] init];
    self.interestedCountLabel.textColor = [UIColor whiteColor];
    self.interestedCountLabel.font = [UIFont systemFontOfSize:12];
    self.interestedCountLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.interestedCountLabel];
}

- (void) setupInterestedButton{
    self.interestedButton = [[UIButton alloc] init];
    self.interestedButton.backgroundColor = COLOR_TERTIARY;
    [self.interestedButton setTitle:NSLocalizedString(@"interested", nil) forState: UIControlStateNormal];
    self.interestedButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.interestedButton.layer.cornerRadius = 5;
    self.interestedButton.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
    [self.interestedButton addTarget:self action:@selector(interestedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.interestedButton.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.interestedButton];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"eventImageView": self.eventImageView, @"dateDayLabel": self.dateDayLabel, @"dateMonthLabel": self.dateMonthLabel, @"dateTimeLabel": self.dateTimeLabel, @"titleLabel": self.titleLabel, @"subTitleLabel": self.subTitleLabel, @"readMoreButton": self.readMoreButton, @"interestedCountLabel": self.interestedCountLabel, @"interestedButton": self.interestedButton};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[eventImageView]|" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[dateDayLabel(50)]-[dateMonthLabel]-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[titleLabel]-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[subTitleLabel]-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[readMoreButton]-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[interestedCountLabel]-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[interestedButton]" options:0 metrics:nil views:viewsDict]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.dateTimeLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.dateMonthLabel attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.dateTimeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.dateMonthLabel attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    //Height & Vertical Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[eventImageView(200)]-12-[dateDayLabel(40)]-12-[titleLabel(18)]-[subTitleLabel(36)][readMoreButton(18)]-12-[interestedCountLabel(16)]-12-[interestedButton(40)]-12-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.dateMonthLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:16]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.dateMonthLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.dateDayLabel attribute:NSLayoutAttributeTop multiplier:1 constant:2]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.dateTimeLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:16]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.dateTimeLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.dateDayLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:-2]];
}

- (void) configure: (OCEvent *)event{
    if(event != nil){
        //Setup Date Manager
        DateManager *dateManager = [[DateManager alloc] init];
        //Configure Cell
        if(event.image != nil && event.image.length > 0){
            [self.eventImageView sd_setShowActivityIndicatorView:true];
            [self.eventImageView sd_setIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            [self.eventImageView sd_setImageWithURL:[NSURL URLWithString:event.image]];
        }
        else{
            self.eventImageView.image = [UIImage imageNamed:@"oculusPlaceholder"];
        }
        self.dateDayLabel.text = [dateManager dateNumberString:event.startDate];
        self.dateMonthLabel.text = [[dateManager monthString:event.startDate] uppercaseString];
        self.dateTimeLabel.text  = [NSString stringWithFormat:@"%@ - %@", [dateManager timeString:event.startDate], event.venue];
        self.titleLabel.text = event.name;
        self.subTitleLabel.text = event.details;
        self.interestedCountLabel.text = [NSString stringWithFormat:@"%@ %@", event.interestedCount, NSLocalizedString(@"interestedCount", nil)];
    }
}

//Button Delegate
- (void) readMoreButtonPressed:(UIButton *) sender{
    if ([eventsCellDelegate respondsToSelector:@selector(relayDidPressReadMoreButton:)]){
        [eventsCellDelegate relayDidPressReadMoreButton:sender];
    }
}

- (void) interestedButtonPressed:(UIButton *) sender{
    if ([eventsCellDelegate respondsToSelector:@selector(relayDidPressInterestedButton:)]){
        [eventsCellDelegate relayDidPressInterestedButton:sender];
    }
}

@end
