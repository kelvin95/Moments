//
//  SettingsButton.m
//  Countdown
//
//  Created by Kelvin Wong on 1/25/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import "SettingsButton.h"

@implementation SettingsButton

@synthesize highlightView = _highlightView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.highlightView];
    }
    return self;
}

- (UIView *)highlightView
{
    if (!_highlightView) {
        _highlightView = [[UIView alloc]initWithFrame:self.bounds];
        [_highlightView setBackgroundColor:[UIColor blackColor]];
        [_highlightView setAlpha:0.3];
        [_highlightView setHidden:YES];
    }
    return _highlightView;
}

- (void)setHighlighted:(BOOL)highlight {
    if (highlight != self.highlighted) [self.highlightView setHidden:(highlight ? NO : YES)];
    [super setHighlighted:highlight];
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
