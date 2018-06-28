//
//  OCTableSectionHeader.h
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCTableSectionHeader : UIView

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *separatorLine;
- (void) configure:(NSString *)title;

@end
