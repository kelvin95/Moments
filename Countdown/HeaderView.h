//
//  HeaderView.h
//  Countdown
//
//  Created by Kelvin Wong on 1/24/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditableLabel.h"

@interface HeaderView : UIView

@property (strong, nonatomic) NSString *eventName;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) EditableLabel *eventNameLabel;


@end
