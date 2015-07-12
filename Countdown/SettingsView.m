//
//  SettingsView.m
//  Countdown
//
//  Created by Kelvin Wong on 1/25/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import "SettingsView.h"
#import "HeaderView.h"
#import "CalendarView.h"
#import "Constants.h"
#import "ShiftMonthsView.h"
#import "SettingsButton.h"
#import "PagesCell.h"

@interface SettingsView()

@property (strong, nonatomic) HeaderView *headerView;
@property (strong, nonatomic) ShiftMonthsView *shiftMonthView;
@property (strong, nonatomic) CalendarView *calenderView;

@end

@implementation SettingsView

@synthesize headerView = _headerView;
@synthesize shiftMonthView = _shiftMonthView;
@synthesize calenderView = _calenderView;
@synthesize selectedDate = _selectedDate;
@synthesize referenceDate = _referenceDate;
@synthesize backButton = _backButton;

- (SettingsButton *)backButton
{
    if (!_backButton) {
       // _backButton = [[UIButton alloc]initWithFrame:CGRectMake(60, self.calenderView.bounds.size.height+self.headerView.bounds.size.height+self.shi, self.bounds.size.width-120, self.bounds.size.height-250-self.calenderView.bounds.size.height)];
        if (SCREEN_HEIGHT == 480) {
            _backButton = [[SettingsButton alloc]initWithFrame:CGRectMake(60, self.headerView.frame.size.height+self.shiftMonthView.frame.size.height+self.calenderView.frame.size.height-15, self.bounds.size.width-120, self.bounds.size.height-self.headerView.frame.size.height-self.shiftMonthView.frame.size.height-self.calenderView.frame.size.height+5)];
        } else {
            _backButton = [[SettingsButton alloc]initWithFrame:CGRectMake(60, self.headerView.frame.size.height+self.shiftMonthView.frame.size.height+self.calenderView.frame.size.height, self.bounds.size.width-120, 80)];
        }
        [_backButton setBackgroundColor:[UIColor greenColor]];
        [_backButton.titleLabel setFont:[UIFont fontWithName:@"League Gothic" size:30]];
        [_backButton setTitle:@"DONE" forState:UIControlStateNormal];
    }
    return _backButton;
}



- (NSDate *)selectedDate
{
    if (!_selectedDate) {
        _selectedDate = self.counter.date;
    }
    return _selectedDate;
}

- (NSDate *)referenceDate
{
    if (!_referenceDate) {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.selectedDate];
        [components setDay:1];
        [components setHour:0];
        [components setMinute:0];
        [components setSecond:0];
        _referenceDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    }
    return _referenceDate;
}

- (void)setReferenceDate:(NSDate *)referenceDate
{
    _referenceDate = referenceDate;
    [self.shiftMonthView setReferenceDate:_referenceDate];
    [self.calenderView setReferenceDate:_referenceDate];
    
}

- (HeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[HeaderView alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, 75)];
    }
    return _headerView;
}

- (ShiftMonthsView *)shiftMonthView
{
    if (!_shiftMonthView) {
        _shiftMonthView = [[ShiftMonthsView alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.headerView.frame.size.height, SCREEN_WIDTH, 50)];
        [_shiftMonthView setBackgroundColor:[BODY_COLOR_DICTIONARY objectForKey:_counter.color]];
        _shiftMonthView.referenceDate = self.referenceDate;
        [_shiftMonthView.shiftLeftButton addTarget:self action:@selector(onShiftLeftPressed) forControlEvents:UIControlEventTouchUpInside];
        [_shiftMonthView.shiftRightButton addTarget:self action:@selector(onShiftRightPressed) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _shiftMonthView;
}

- (CalendarView *)calenderView
{
    if (!_calenderView) {
        _calenderView = [[CalendarView alloc]initWithFrame:CGRectMake(0,self.headerView.frame.size.height+self.shiftMonthView.frame.size.height, self.bounds.size.width, self.frame.size.width)];
        [_calenderView setDelegate:self];
    }
    return _calenderView;
}

- (void)setCounter:(Counter *)counter
{
    _counter = counter;
    [self addSubview:self.shiftMonthView];
    [self.calenderView setSelectedDate:_counter.date];
    [self setBackgroundColor:[HEADER_COLOR_DICTIONARY objectForKey:_counter.color]];
    [self.calenderView setColor:[BODY_COLOR_DICTIONARY objectForKey:_counter.color]];
    [self.calenderView setDarkColor:[HEADER_COLOR_DICTIONARY objectForKey:_counter.color]];
    [self addSubview:self.calenderView];
    
    [self.headerView setColor:[HEADER_COLOR_DICTIONARY objectForKey:_counter.color]];
    [self.headerView setEventName:_counter.event];
    [self addSubview:self.backButton];


}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headerView];
    }
    return self;
}

- (void)onShiftRightPressed
{
    NSDateComponents *c = [NSDateComponents new];
    c.month = 1;
    NSDate *newDate = [[NSCalendar currentCalendar]dateByAddingComponents:c toDate:self.referenceDate options:0];
    self.referenceDate = newDate;
    
    CalendarView *newCalendarView = [[CalendarView alloc]initWithFrame:CGRectMake(self.bounds.size.width, self.headerView.frame.size.height+self.shiftMonthView.frame.size.height, self.bounds.size.width, self.bounds.size.height)];
    [newCalendarView setColor:[BODY_COLOR_DICTIONARY objectForKey:_counter.color]];
    [newCalendarView setSelectedDate:self.selectedDate];
    [newCalendarView setReferenceDate:self.referenceDate];
    [newCalendarView setDelegate:self];

    [self addSubview:newCalendarView];
    [UIView animateWithDuration:0.1 animations:^(void){
        [newCalendarView setFrame:CGRectMake(0, self.headerView.frame.size.height+self.shiftMonthView.frame.size.height, self.bounds.size.width, self.frame.size.width-60)];
        [self.calenderView setFrame:CGRectMake(-self.bounds.size.width, self.headerView.bounds.size.height+self.shiftMonthView.bounds.size.height, self.calenderView.bounds.size.width, self.calenderView.bounds.size.height)];
    }completion:^(BOOL finished) {
        [self.calenderView removeFromSuperview];
        self.calenderView = newCalendarView;
    }];
}

- (void)onShiftLeftPressed
{
    NSDateComponents *c = [NSDateComponents new];
    c.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar]dateByAddingComponents:c toDate:self.referenceDate options:0];
    self.referenceDate = newDate;
    
    CalendarView *newCalendarView = [[CalendarView alloc]initWithFrame:CGRectMake(-self.bounds.size.width, self.headerView.frame.size.height+self.shiftMonthView.frame.size.height, self.bounds.size.width, self.bounds.size.height)];
    [newCalendarView setColor:[BODY_COLOR_DICTIONARY objectForKey:_counter.color]];
    [newCalendarView setSelectedDate:self.selectedDate];
    [newCalendarView setReferenceDate:self.referenceDate];
    [newCalendarView setDelegate:self];
    
    [self addSubview:newCalendarView];
    [UIView animateWithDuration:0.1 animations:^(void){
        [newCalendarView setFrame:CGRectMake(0, self.headerView.frame.size.height+self.shiftMonthView.frame.size.height, self.bounds.size.width, self.frame.size.width-60)];
        [self.calenderView setFrame:CGRectMake(self.bounds.size.width, self.headerView.bounds.size.height+self.shiftMonthView.bounds.size.height, self.calenderView.bounds.size.width, self.calenderView.bounds.size.height)];
    }completion:^(BOOL finished) {
        [self.calenderView removeFromSuperview];
        self.calenderView = newCalendarView;
    }];
}

- (void)calendarDidSelectDate:(NSDate *)date
{
    self.selectedDate = date;
    self.counter.date = self.selectedDate;
    [self.delegate settingsDidSelectDate:self.counter.date];

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
