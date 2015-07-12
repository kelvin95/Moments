//
//  Counter.m
//  Countdown
//
//  Created by Kelvin Wong on 1/24/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import "Counter.h"


@implementation Counter

@dynamic date;
@dynamic event;
@dynamic color;

- (int)days
{
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSInteger startDay = [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit: NSEraCalendarUnit forDate:[NSDate date]];
    NSInteger endDay = [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit: NSEraCalendarUnit forDate:self.date];
    return endDay-startDay;
    

}

@end
