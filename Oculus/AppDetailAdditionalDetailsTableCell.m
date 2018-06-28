//
//  AppDetailAdditionalDetailsTableCell.m
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "AppDetailAdditionalDetailsTableCell.h"
#import "Constants.h"
#import "DateManager.h"

@interface AppDetailAdditionalDetailsTableCell() <TTTAttributedLabelDelegate>

@end

@implementation AppDetailAdditionalDetailsTableCell

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
    
    //Setup Title Label
    [self setupTitleLabel];
    
    //Setup Constraints
    [self setupConstraints];
}

- (void) setupTitleLabel{
    self.titleLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.delegate = self;
    self.titleLabel.linkAttributes = @{NSForegroundColorAttributeName: COLOR_TERTIARY,
                                       NSFontAttributeName: [UIFont boldSystemFontOfSize:14]};
    self.titleLabel.activeLinkAttributes = @{NSForegroundColorAttributeName: COLOR_TERTIARY,
                                             NSFontAttributeName: [UIFont boldSystemFontOfSize:14]};
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self addSubview:self.titleLabel];
}

- (void) setupConstraints{
    NSDictionary *viewsDict = @{@"titleLabel": self.titleLabel};
    //Width & Horizontal Constraints
    [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[titleLabel]-|" options:0 metrics:nil views:viewsDict]];
    //Height & Vertical Constraints
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:8]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-8]];
}

- (void) configure: (OCApp *)app detailTitle: (NSString *)detailTitle{
    //TODO: Refactor ComponentsJoinedByString with the StoreFormatter class
    if(app != nil){
        NSMutableAttributedString *attributedString;
        NSString *text;
        NSString *detailValue;
        if ([detailTitle isEqualToString:@"gameModes"]){
            NSMutableArray *gameModes = [[app.gameModes allKeys] mutableCopy];
            for (int i = 0; i < gameModes.count; i++) {
                NSString *rawString = gameModes[i];
                [gameModes replaceObjectAtIndex:i withObject:NSLocalizedString(rawString, nil)];
            }
            NSString *gameModesString = [gameModes componentsJoinedByString:@", "];
            detailTitle = NSLocalizedString(detailTitle, nil);
            detailValue = NSLocalizedString(gameModesString, nil);
            text = [NSString stringWithFormat:@"%@:  %@", NSLocalizedString(detailTitle, nil), detailValue];
            attributedString =[[NSMutableAttributedString alloc] initWithString:text];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, text.length)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, detailTitle.length+1)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(detailTitle.length+3, detailValue.length)];
        }
        else if ([detailTitle isEqualToString:@"category"]){
            detailTitle = NSLocalizedString(detailTitle, nil);
            detailValue = NSLocalizedString(app.category, nil);
            text = [NSString stringWithFormat:@"%@:  %@", NSLocalizedString(detailTitle, nil), detailValue];
            attributedString =[[NSMutableAttributedString alloc] initWithString:text];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, text.length)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, detailTitle.length+1)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(detailTitle.length+3, detailValue.length)];
        }
        else if ([detailTitle isEqualToString:@"genres"]){
            NSMutableArray *genres = [[app.genres allKeys] mutableCopy];
            for (int i = 0; i < genres.count; i++) {
                NSString *rawString = genres[i];
                [genres replaceObjectAtIndex:i withObject:NSLocalizedString(rawString, nil)];
            }
            NSString *genresString = [genres componentsJoinedByString:@", "];
            detailTitle = NSLocalizedString(detailTitle, nil);
            text = [NSString stringWithFormat:@"%@:  %@", NSLocalizedString(detailTitle, nil), genresString];
            attributedString =[[NSMutableAttributedString alloc] initWithString:text];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, text.length)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, detailTitle.length+1)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(detailTitle.length+3, genresString.length)];
        }
        else if ([detailTitle isEqualToString:@"released"]){
            DateManager *dateManager = [[DateManager alloc] init];
            NSString *releaseDateString = [dateManager shortDateString:app.releaseDate];
            detailTitle = NSLocalizedString(detailTitle, nil);
            detailValue = NSLocalizedString(releaseDateString, nil);
            text = [NSString stringWithFormat:@"%@:  %@", NSLocalizedString(detailTitle, nil), detailValue];
            attributedString =[[NSMutableAttributedString alloc] initWithString:text];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, text.length)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, detailTitle.length+1)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(detailTitle.length+3, detailValue.length)];
        }
        else if ([detailTitle isEqualToString:@"languages"]){
            NSMutableArray *languages = [[app.languages allKeys] mutableCopy];
            for (int i = 0; i < languages.count; i++) {
                NSString *rawString = languages[i];
                [languages replaceObjectAtIndex:i withObject:NSLocalizedString(rawString, nil)];
            }
            NSString *languagesString = [languages componentsJoinedByString:@", "];
            detailTitle = NSLocalizedString(detailTitle, nil);
            text = [NSString stringWithFormat:@"%@:  %@", NSLocalizedString(detailTitle, nil), languagesString];
            attributedString =[[NSMutableAttributedString alloc] initWithString:text];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, text.length)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, detailTitle.length+1)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(detailTitle.length+3, languagesString.length)];
        }
        else if ([detailTitle isEqualToString:@"termsOfService"]){
            detailTitle = NSLocalizedString(detailTitle, nil);
            detailValue = NSLocalizedString(app.termsURL, nil);
            text = [NSString stringWithFormat:@"%@:  %@", NSLocalizedString(detailTitle, nil), NSLocalizedString(detailValue, nil)];
            attributedString =[[NSMutableAttributedString alloc] initWithString:text];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, detailTitle.length+1)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:COLOR_TERTIARY range:NSMakeRange(detailTitle.length+3, detailValue.length)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, detailTitle.length+1)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(detailTitle.length+3, detailValue.length)];
            NSRange termsLinkRange = [self.titleLabel.text rangeOfString:detailValue];
            [self.titleLabel addLinkToURL:[NSURL URLWithString:detailValue] withRange:termsLinkRange];
        }
        else if ([detailTitle isEqualToString:@"privacyPolicy"]){
            detailTitle = NSLocalizedString(detailTitle, nil);
            detailValue = NSLocalizedString(app.privacyPolicyURL, nil);
            text = [NSString stringWithFormat:@"%@:  %@", NSLocalizedString(detailTitle, nil), detailValue];
            attributedString =[[NSMutableAttributedString alloc] initWithString:text];
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, detailTitle.length+1)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:COLOR_TERTIARY range:NSMakeRange(detailTitle.length+3, detailValue.length)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(0, detailTitle.length+1)];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:NSMakeRange(detailTitle.length+3, detailValue.length)];
            NSRange privacyPolicyLinkRange = [self.titleLabel.text rangeOfString:NSLocalizedString(detailValue, nil)];
            [self.titleLabel addLinkToURL:[NSURL URLWithString:detailValue] withRange:privacyPolicyLinkRange];
        }
        self.titleLabel.attributedText = attributedString;
    }
}

//TTTAttributedLabel Delegate
- (void) attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url{
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

@end
