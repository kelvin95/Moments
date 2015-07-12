//
//  CalendarView.h
//  Countdown
//
//  Created by Kelvin Wong on 1/25/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalendarProtocol <NSObject>

- (void)calendarDidSelectDate:(NSDate *)date;

@end

@interface CalendarView : UIView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSDate *selectedDate;
@property (strong, nonatomic) NSDate *referenceDate;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) UIColor *darkColor;

@property (strong, nonatomic) id delegate;

@end
