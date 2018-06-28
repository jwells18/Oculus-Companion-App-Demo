//
//  AppDetailAdditionalDetailsTableCell.h
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCApp.h"
#import "TTTAttributedLabel.h"

@interface AppDetailAdditionalDetailsTableCell : UITableViewCell

@property (strong, nonatomic) TTTAttributedLabel *titleLabel;
- (void) configure: (OCApp *)app detailTitle: (NSString *)detailTitle;

@end
