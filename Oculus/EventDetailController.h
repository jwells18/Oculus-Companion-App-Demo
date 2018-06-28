//
//  EventDetailController.h
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCEvent.h"

@interface EventDetailController : UIViewController

- (instancetype)initWithEvent:(OCEvent *)event eventId:(NSString *)eventId;

@end
