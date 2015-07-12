//
//  EditableLabel.m
//  Countdown
//
//  Created by Kelvin Wong on 1/25/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import "EditableLabel.h"

@implementation EditableLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDelegate:self];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setKeyboardType:UIKeyboardTypeAlphabet];
        [self setReturnKeyType:UIReturnKeyDone];
        [self setAutocorrectionType:UITextAutocorrectionTypeNo];
        [self setSpellCheckingType:UITextSpellCheckingTypeNo];
        [self setAutocapitalizationType:UITextAutocapitalizationTypeAllCharacters];    }
    return self;
}

- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    return CGRectZero;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.other_delegate textDidChangedTo:(NSString *)textField.text];
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = textField.text;
    text = [text stringByReplacingCharactersInRange:range withString:[string uppercaseString]];
    CGSize textSize = [text sizeWithAttributes:@{NSFontAttributeName:textField.font}];
    
    if (textSize.width+8 >= textField.frame.size.width) return NO;
    
    NSRange lowercaseCharRange;
    lowercaseCharRange = [string rangeOfCharacterFromSet:[NSCharacterSet lowercaseLetterCharacterSet]];
    
    if (lowercaseCharRange.location != NSNotFound) {
 
        textField.text = [textField.text stringByReplacingCharactersInRange:range withString:[string uppercaseString]];
        return NO;
    }
    
    return YES;
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
