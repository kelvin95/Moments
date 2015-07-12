//
//  NumberCountView.m
//  Countdown
//
//  Created by Kelvin Wong on 1/24/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import "NumberCountView.h"

@interface NumberCountView()


@end

@implementation NumberCountView

@synthesize numberLabel = _numberLabel;
@synthesize descriptionLabel = _descriptionLabel;

- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [_numberLabel setFont:[UIFont fontWithName:@"League Gothic" size:200]];
        [_numberLabel setTextColor:[UIColor whiteColor]];
        [_numberLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _numberLabel;
}

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [_descriptionLabel setFont:[UIFont fontWithName:@"League Gothic" size:40]];
        [_descriptionLabel setTextColor:[UIColor whiteColor]];
        [_descriptionLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _descriptionLabel;
}

@synthesize days = _days;

- (void)setDays:(int)days
{
    _days = days;
    [self.numberLabel setText:[NSString stringWithFormat:@"%i", ABS(_days)]];
    [self.numberLabel sizeToFit];
    
    if (_days == 1) {
        [self.descriptionLabel setText:@"DAY UNTIL"];
    } else if (_days == -1) {
        [self.descriptionLabel setText:@"DAY SINCE"];
    } else if (_days > 0) {
        [self.descriptionLabel setText:@"DAYS UNTIL"];
    } else if (_days < 0) {
        [self.descriptionLabel setText:@"DAYS SINCE"];
    } else {
        [self.descriptionLabel setText:@"IT'S TODAY!"];
    }
    [self.descriptionLabel sizeToFit];

    CGFloat maxWidth = MAX(self.numberLabel.frame.size.width, self.descriptionLabel.frame.size.width);
    [self.numberLabel setFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, maxWidth, self.numberLabel.frame.size.height)];
    [self.descriptionLabel setFrame:CGRectMake(self.bounds.origin.x, self.numberLabel.frame.size.height-30, maxWidth, self.descriptionLabel.frame.size.height)];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.numberLabel];
        [self addSubview:self.descriptionLabel];
    }
    return self;
}

- (void)sizeToFit
{
    [super sizeToFit];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, MAX(self.numberLabel.frame.size.width, self.descriptionLabel.frame.size.width), self.numberLabel.frame.size.height+self.descriptionLabel.frame.size.height)];
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
