//
//  CalendarViewHeader.m
//  Countdown
//
//  Created by Kelvin Wong on 1/25/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import "CalendarViewHeader.h"

@implementation CalendarViewHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    CGFloat width = self.frame.size.width/7;
    NSArray *days = @[@"S", @"M", @"T", @"W", @"R", @"F", @"S"];
    for (int i=0; i<7; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(width*i, 0, width, width)];
        [label setFont:[UIFont fontWithName:@"League Gothic" size:20]];
        [label setTextColor:_color];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setText:[days objectAtIndex:i]];
        [self addSubview:label];
    }
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
