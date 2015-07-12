//
//  EditableLabel.h
//  Countdown
//
//  Created by Kelvin Wong on 1/25/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditableLabeProtocol <NSObject>

- (void)textDidChangedTo:(NSString *)text;

@end

@interface EditableLabel : UITextField <UITextFieldDelegate>

@property (weak, nonatomic) id other_delegate;

@end
