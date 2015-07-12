//
//  Constants.h
//  Countdown
//
//  Created by Kelvin Wong on 1/24/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#ifndef Countdown_Constants_h
#define Countdown_Constants_h

#define BLUE_COLOR @0
#define PURPLE_COLOR @1
#define GREEN_COLOR @2
#define YELLOW_COLOR @3
#define RED_COLOR @4


#define HEADER_BLUE_COLOR [UIColor colorWithRed:49/255. green:60/255. blue:163/255. alpha:1]
#define HEADER_PURPLE_COLOR [UIColor colorWithRed:85/255. green:0/255. blue:161/255. alpha:1]
#define HEADER_GREEN_COLOR [UIColor colorWithRed:79/255. green:151/255. blue:0/255. alpha:1]
#define HEADER_YELLOW_COLOR [UIColor colorWithRed:255/255. green:127/255. blue:0/255. alpha:1]
#define HEADER_RED_COLOR [UIColor colorWithRed:240/255. green:0/255. blue:86/255. alpha:1]
#define HEADER_COLOR_DICTIONARY @{BLUE_COLOR:HEADER_BLUE_COLOR, PURPLE_COLOR:HEADER_PURPLE_COLOR, GREEN_COLOR:HEADER_GREEN_COLOR, YELLOW_COLOR:HEADER_YELLOW_COLOR, RED_COLOR:HEADER_RED_COLOR}

#define BODY_BLUE_COLOR [UIColor colorWithRed:74/255. green:144/255. blue:226/255. alpha:1]
#define BODY_PURPLE_COLOR [UIColor colorWithRed:144/255. green:19/255. blue:254/255. alpha:1]
#define BODY_GREEN_COLOR [UIColor colorWithRed:126/255. green:211/255. blue:33/255. alpha:1]
#define BODY_YELLOW_COLOR [UIColor colorWithRed:248/255. green:231/255. blue:28/255. alpha:1]
#define BODY_RED_COLOR [UIColor colorWithRed:255/255. green:186/255. blue:210/255. alpha:1]
#define BODY_COLOR_DICTIONARY @{BLUE_COLOR:BODY_BLUE_COLOR, PURPLE_COLOR:BODY_PURPLE_COLOR, GREEN_COLOR:BODY_GREEN_COLOR, YELLOW_COLOR:BODY_YELLOW_COLOR, RED_COLOR:BODY_RED_COLOR}


#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define MONTHS @{@1:@"JANUARY", @2:@"FEBRUARY", @3:@"MARCH", @4:@"APRIL", @5:@"MAY", @6:@"JUNE", @7:@"JULY", @8:@"AUGUST", @9:@"SEPTEMBER", @10:@"OCTOBER", @11:@"NOVEMBER", @12:@"DECEMBER"}

#define GUTTER_WIDTH 15

#endif

