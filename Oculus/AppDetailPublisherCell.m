//
//  AppDetailPublisherCell.m
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "AppDetailPublisherCell.h"
#import "Constants.h"

@implementation AppDetailPublisherCell

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
    
    //Setup Ratings ImageView
    [self setupRatingsImageView];
    
    //Setup Title Label
    [self setupTitleLabel];
    
    //Setup SubTitle Label
    [self setupSubTitleLabel];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupRatingsImageView{
    self.ratingsImageView = [[UIImageView alloc] init];
    self.ratingsImageView.backgroundColor = [UIColor darkGrayColor];
    self.ratingsImageView.clipsToBounds = true;
    self.ratingsImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.ratingsImageView];
}

- (void) setupTitleLabel{
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
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
    NSDictionary *viewsDict = @{@"ratingsImageView":self.ratingsImageView, @"titleLabel": self.titleLabel, @"subTitleLabel": self.subTitleLabel};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[ratingsImageView(40)]-[titleLabel]-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[subTitleLabel]-|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[ratingsImageView(40)]-[subTitleLabel]-|" options:0 metrics:nil views:viewsDict]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.ratingsImageView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

- (void) configure: (OCApp *)app{
    self.ratingsImageView.image =  [UIImage imageNamed:app.esrbRating];
    self.titleLabel.text = NSLocalizedString(app.esrbRating, nil);
    NSMutableArray *esrbRatingDetails = [[app.esrbRatingDetails allKeys] mutableCopy];
    for (int i = 0; i < esrbRatingDetails.count; i++) {
        NSString *rawString = esrbRatingDetails[i];
        [esrbRatingDetails replaceObjectAtIndex:i withObject:NSLocalizedString(rawString, nil)];
    }
    NSString *esrbRatingDetailsString = [esrbRatingDetails componentsJoinedByString:@", "];
    self.subTitleLabel.text = NSLocalizedString(esrbRatingDetailsString, nil);
}

@end
