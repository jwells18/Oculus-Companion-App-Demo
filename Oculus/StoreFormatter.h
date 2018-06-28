//
//  StoreFormatter.h
//  Oculus
//
//  Created by Justin Wells on 6/27/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCApp.h"

@interface StoreFormatter : NSObject

- (NSAttributedString *)stringPriceFromApp:(OCApp *)app;

@end
