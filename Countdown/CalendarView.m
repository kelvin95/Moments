//
//  CalendarView.m
//  Countdown
//
//  Created by Kelvin Wong on 1/25/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import "CalendarView.h"
#import "CalendarDayCell.h"
#import "CalendarViewHeader.h"

@interface CalendarView()

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSCalendar *calendar;
@property (nonatomic) int daysOffset;

@end

@implementation CalendarView

@synthesize collectionView = _collectionView;
@synthesize referenceDate = _referenceDate;
@synthesize calendar = _calendar;
@synthesize daysOffset = _daysOffset;

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0.0f;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(30, self.bounds.origin.y, self.bounds.size.width-60, self.bounds.size.width) collectionViewLayout:layout];
        [_collectionView registerClass:[CalendarDayCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[CalendarViewHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
    }
    return _collectionView;
}

- (NSDate *)referenceDate
{
    if (!_referenceDate) {
        NSDateComponents *components = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.selectedDate];
        [components setDay:1];
        [components setHour:0];
        [components setMinute:0];
        [components setSecond:0];
        _referenceDate = [self.calendar dateFromComponents:components];
    }
    return _referenceDate;
}

- (NSCalendar *)calendar
{
    if (!_calendar) {
        _calendar = [NSCalendar currentCalendar];
    }
    return _calendar;
}

- (int)daysOffset
{
    if (!_daysOffset) {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:self.referenceDate];
        _daysOffset = components.weekday - 2;
    }
    return _daysOffset;
}

# pragma mark - Collection View Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSRange days = [self.calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self.referenceDate];
    return days.length + self.daysOffset + 1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if ([indexPath row] > self.daysOffset) {
        NSDateComponents *components = [NSDateComponents new];
        components.day = [indexPath row] - self.daysOffset - 1;
        NSDate *date = [self.calendar dateByAddingComponents:components toDate:self.referenceDate options:NSCalendarWrapComponents];
        cell.darkColor = self.darkColor;
        if ([self compareDate:date withDate:self.selectedDate]) {
            [cell setSelected:YES];
            //[cell.dateLabel setTextColor:cell.darkColor];
            [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionBottom];
        }
        [cell setDate:date];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        CalendarViewHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        NSLog(@"color = %@", self.color);
        headerView.color = self.color;
        reusableview = headerView;
    }
    return reusableview;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionView.frame.size.width/7, self.collectionView.frame.size.width/7);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.width/7);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"hello");
    self.selectedDate = [(CalendarDayCell *)[collectionView cellForItemAtIndexPath:indexPath]date];
    [self.delegate calendarDidSelectDate:self.selectedDate];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
    }
    return self;
}

- (BOOL)compareDate:(NSDate *)firstDate withDate:(NSDate *)secondDate
{
    NSDateComponents *c1 = [self.calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:firstDate];
    NSDateComponents *c2 = [self.calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:secondDate];
    if ((c1.day == c2.day) && (c1.month == c2.month) && (c1.year == c2.year)) {
        return YES;
    } else {
        return NO;
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
