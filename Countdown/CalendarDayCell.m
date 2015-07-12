//
//  CalendarDayCell.m
//  Countdown
//
//  Created by Kelvin Wong on 1/25/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import "CalendarDayCell.h"

@interface CalendarDayCell()

@property (strong, nonatomic) UIImageView *backgroundCircle;

@end

@implementation CalendarDayCell

@synthesize dateLabel = _dateLabel;
@synthesize backgroundCircle = _backgroundCircle;

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]initWithFrame:self.bounds];
        [_dateLabel setFont:[UIFont fontWithName:@"League Gothic" size:20]];
        [_dateLabel setTextColor:[UIColor whiteColor]];
        [_dateLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _dateLabel;
}

- (UIImageView *)backgroundCircle
{
    if (!_backgroundCircle) {
        _backgroundCircle = [[UIImageView alloc]initWithFrame:CGRectZero];
        [_backgroundCircle setContentMode:UIViewContentModeScaleAspectFill];
        [_backgroundCircle setImage:[UIImage imageNamed:@"circle.png"]];
        [_backgroundCircle setCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)];
        //[_backgroundCircle setCenter:self.center];
    }
    return _backgroundCircle;
}

@synthesize date = _date;

- (void)setDate:(NSDate *)date
{
    _date = date;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay) fromDate:_date];
    [self.dateLabel setText:[NSString stringWithFormat:@"%i", components.day]];
    [self setUserInteractionEnabled:YES];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.backgroundCircle];
        [self addSubview:self.dateLabel];
        [self setUserInteractionEnabled:NO];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    NSLog(@"hello");
    [super setSelected:selected];
    if (selected) {
        [self.dateLabel setTextColor:self.darkColor];
        [UIView animateWithDuration:0.1 animations:^(void){
            [self.backgroundCircle setFrame:CGRectMake(5, 5, self.bounds.size.width-10, self.bounds.size.height-10)];
            NSLog(@"background = %@", self.backgroundCircle);
        }];
    } else {
        [UIView animateWithDuration:0.1 animations:^(void){
            [self.backgroundCircle setFrame:CGRectMake(self.bounds.size.width/2, self.bounds.size.height/2, 0, 0)];
        }];
        [self.dateLabel setTextColor:[UIColor whiteColor]];
    }
}

/*
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);
    if (self.selected) {
        CGContextSetFillColorWithColor(context, [[UIColor redColor]CGColor]);
        CGContextFillEllipseInRect(context, CGRectMake(5, 5, self.bounds.size.width-10, self.bounds.size.height-10));
    }
    
}
*/

@end
