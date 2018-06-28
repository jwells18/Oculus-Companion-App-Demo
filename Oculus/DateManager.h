//
//  DateManager.h
//  Oculus
//
//  Created by Justin Wells on 6/24/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateManager : NSObject

- (NSDate *) createDateFromString:(NSString *)dateString;
- (NSString *) dateNumberString:(NSDate *)date;
- (NSString *) monthString:(NSDate *)date;
- (NSString *) timeString:(NSDate *)date;
- (NSString *) shortDateString:(NSDate *)date;
- (NSString *) shortDateAndTimeString:(NSDate *)date;

@end
