//
//  DateManager.m
//  Oculus
//
//  Created by Justin Wells on 6/24/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "DateManager.h"

@interface DateManager()

@property (strong, nonatomic) NSDateFormatter *formatter;

@end

@implementation DateManager

- (instancetype)init {
    self = [super init];
    
    //Setup NSDateFormatter
    self.formatter = [[NSDateFormatter alloc] init];
    
    return self;
}

- (NSDate *) createDateFromString:(NSString *)dateString{
    self.formatter.dateFormat = @"yyyy/MM/dd HH:mm";
    NSDate *date = [self.formatter dateFromString:dateString];
    return date;
}

- (NSString *) dateNumberString:(NSDate *)date{
    self.formatter.dateFormat = @"d";
    return [self.formatter stringFromDate:date];
}

- (NSString *) monthString:(NSDate *)date{
    self.formatter.dateFormat = @"MMM";
    return [self.formatter stringFromDate:date];
}

- (NSString *) timeString:(NSDate *)date{
    self.formatter.dateFormat = @"h:mma";
    return [self.formatter stringFromDate:date];
}

- (NSString *) shortDateString:(NSDate *)date{
    self.formatter.dateFormat = @"MM/dd/yyyy";
    return [self.formatter stringFromDate:date];
}

- (NSString *) shortDateAndTimeString:(NSDate *)date{
    self.formatter.dateFormat = @"MMM dd, h:mma";
    return [self.formatter stringFromDate:date];
}

@end
