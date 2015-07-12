//
//  CalendarDayCell.h
//  Countdown
//
//  Created by Kelvin Wong on 1/25/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarDayCell : UICollectionViewCell

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) UIColor *darkColor;
@property (strong, nonatomic) UILabel *dateLabel;

@end
