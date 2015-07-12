//
//  NumberCountView.h
//  Countdown
//
//  Created by Kelvin Wong on 1/24/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberCountView : UIView

@property (nonatomic) int days;


@property (strong, nonatomic) UILabel *numberLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;

@end
