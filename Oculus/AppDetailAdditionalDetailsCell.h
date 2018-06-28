//
//  AppDetailAdditionalDetailsCell.h
//  Oculus
//
//  Created by Justin Wells on 6/21/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCApp.h"

@interface AppDetailAdditionalDetailsCell : UITableViewCell

- (void) configure:(OCApp *)app detailTitles:(NSArray *)detailTitles;

@end
