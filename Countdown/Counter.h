//
//  Counter.h
//  Countdown
//
//  Created by Kelvin Wong on 1/24/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Counter : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * event;
@property (nonatomic, retain) NSNumber * color;

- (int)days;

@end
