//
//  ShiftMonthsView.m
//  Countdown
//
//  Created by Kelvin Wong on 1/25/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import "ShiftMonthsView.h"
#import "Constants.h"

@interface ShiftMonthsView()

@property (strong, nonatomic) UILabel *monthLabel;

@end

@implementation ShiftMonthsView

@synthesize monthLabel = _monthLabel;

- (UILabel *)monthLabel
{
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, self.bounds.size.width-160, self.bounds.size.height)];
        [_monthLabel setTextAlignment:NSTextAlignmentCenter];
        [_monthLabel setFont:[UIFont fontWithName:@"League Gothic" size:30]];
        [_monthLabel setTextColor:[UIColor whiteColor]];
    }
    return _monthLabel;
}

@synthesize referenceDate = _referenceDate;
@synthesize shiftLeftButton = _shiftLeftButton;
@synthesize shiftRightButton = _shiftRightButton;

- (UIButton *)shiftRightButton
{
    if (!_shiftRightButton) {
        _shiftRightButton = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width-80, 0, self.bounds.size.height, self.bounds.size.height)];
        [_shiftRightButton setImage:[UIImage imageNamed:@"right_arrow.png"] forState:UIControlStateNormal];
    }
    return _shiftRightButton;
}


- (UIButton *)shiftLeftButton
{
    if (!_shiftLeftButton) {
        _shiftLeftButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, self.bounds.size.height, self.bounds.size.height)];
    }
    [_shiftLeftButton setImage:[UIImage imageNamed:@"left_arrow.png"] forState:UIControlStateNormal];

    return _shiftLeftButton;
}


- (void)setReferenceDate:(NSDate *)referenceDate
{
    _referenceDate = referenceDate;
    NSDateComponents *components = [[NSCalendar currentCalendar]components:(NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:referenceDate];
    [UIView animateWithDuration:0.5 animations:^(void) {
        [self.monthLabel setText:[NSString stringWithFormat:@"%@ %i", [MONTHS objectForKey:[NSNumber numberWithInt:components.month]], components.year]];
    }];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor redColor]];

        [self addSubview:self.shiftRightButton];
        [self addSubview:self.shiftLeftButton];
        [self addSubview:self.monthLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
