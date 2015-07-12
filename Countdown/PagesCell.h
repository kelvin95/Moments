//
//  PagesCell.h
//  Countdown
//
//  Created by Kelvin Wong on 1/25/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Counter.h"
#import "SettingsView.h"
#import "EditableLabel.h"
#import "HeaderView.h"


@protocol PagesProtocol <NSObject>
@optional
- (void)deletePageWithCounter:(Counter *)counter;
- (void)settingsPageShown:(BOOL)shown;

@end

@interface PagesCell : UITableViewCell <SettingsProtocol, EditableLabeProtocol, UIAlertViewDelegate, PagesProtocol>

@property (strong, nonatomic) Counter *counter;
@property (strong, nonatomic) id page_delegate;
@property (strong, nonatomic) HeaderView *headerView;



@end
