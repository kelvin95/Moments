//
//  CounterView.m
//  Countdown
//
//  Created by Kelvin Wong on 1/24/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import "CounterView.h"
#import "HeaderView.h"
#import "NumberCountView.h"
#import "Constants.h"


@interface CounterView()

@property (strong, nonatomic) HeaderView *headerView;
@property (strong, nonatomic) NumberCountView *countView;

@end

@implementation CounterView

@synthesize headerView = _headerView;
@synthesize countView = _countView;

- (HeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[HeaderView alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, 75)];
    }
    return _headerView;
}

- (NumberCountView *)countView
{
    if (!_countView) {
        _countView = [[NumberCountView alloc]initWithFrame:CGRectZero];
    }
    return _countView;
}

@synthesize counter = _counter;

- (void)setCounter:(Counter *)counter
{
    _counter = counter;
    [self setBackgroundColor:[BODY_COLOR_DICTIONARY objectForKey:_counter.color]];

    [self.headerView setEventName:self.counter.event];
    [self.headerView setColor:[HEADER_COLOR_DICTIONARY objectForKey:_counter.color]];
    
    [self.countView setDays:[self.counter days]];
    [self.countView.descriptionLabel setTextColor:[HEADER_COLOR_DICTIONARY objectForKey:_counter.color]];
    [self.countView sizeToFit];
    [self.countView setCenter:self.center];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headerView];
        [self addSubview:self.countView];
        NSLog(@"header frame = %@", NSStringFromCGRect(self.headerView.frame));

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
