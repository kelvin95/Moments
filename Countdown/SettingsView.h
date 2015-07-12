//
//  SettingsView.h
//  Countdown
//
//  Created by Kelvin Wong on 1/25/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Counter.h"
#import "CalendarView.h"
#import "SettingsButton.h"

@protocol SettingsProtocol <NSObject>

- (void)settingsDidSelectDate:(NSDate *)date;

@end

@interface SettingsView : UIView <CalendarProtocol>

@property (strong, nonatomic) Counter *counter;
@property (strong, nonatomic) NSDate *referenceDate;
@property (strong, nonatomic) NSDate *selectedDate;
@property (weak, nonatomic) id delegate;
@property (strong, nonatomic) SettingsButton *backButton;



@end
