//
//  HeaderView.m
//  Countdown
//
//  Created by Kelvin Wong on 1/24/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import "HeaderView.h"
#import "EditableLabel.h"

@interface HeaderView()

@end

@implementation HeaderView

@synthesize eventNameLabel = _eventNameLabel;

- (EditableLabel *)eventNameLabel
{
    if (!_eventNameLabel) {
        _eventNameLabel = [[EditableLabel alloc]initWithFrame:self.bounds];
        [_eventNameLabel setFont:[UIFont fontWithName:@"League Gothic" size:40]];
        [_eventNameLabel setTextAlignment:NSTextAlignmentCenter];
        [_eventNameLabel setTextColor:[UIColor whiteColor]];

    }
    return _eventNameLabel;
}

@synthesize eventName = _eventName;
@synthesize color = _color;

- (void)setEventName:(NSString *)eventName
{
    _eventName = eventName;
    [self.eventNameLabel setText:_eventName];
    [self.eventNameLabel setCenter:self.center];
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    [self setBackgroundColor:_color];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.eventNameLabel];
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
