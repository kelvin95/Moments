//
//  MainViewController.h
//  Countdown
//
//  Created by Kelvin Wong on 1/25/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagesCell.h"

@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, PagesProtocol>

@property (strong, nonatomic) NSMutableArray *arrayOfCounters;
@property (nonatomic) BOOL makeNewObject;

@end
