//
//  PagesCell.m
//  Countdown
//
//  Created by Kelvin Wong on 1/25/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import "PagesCell.h"
#import "CounterView.h"
#import "HeaderView.h"
#include <math.h>
#import "Constants.h"
#import "SettingsView.h"

@interface PagesCell()

@property (strong, nonatomic) CounterView *counterView;
@property (strong, nonatomic) SettingsView *settingsView;
@property (strong, nonatomic) UIButton *settingsButton;
@property (strong, nonatomic) UIButton *deleteButton;
@property (strong, nonatomic) UIDynamicAnimator *animator;

@end


@implementation PagesCell

@synthesize counterView = _counterView;
@synthesize headerView = _headerView;
@synthesize settingsButton = _settingsButton;
@synthesize deleteButton = _deleteButton;
@synthesize animator = _animator;

- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self];
    }
    return _animator;
}

- (CounterView *)counterView
{
    if (!_counterView) {        
        _counterView = [[CounterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _counterView;
}

- (HeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 75)];
        _headerView.eventNameLabel.other_delegate = self;
    }
    return _headerView;
}

- (UIButton *)settingsButton
{
    if (!_settingsButton) {
        _settingsButton = [[UIButton alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT - 65, 50, 50)];
        [_settingsButton addTarget:self action:@selector(settingsButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_settingsButton setBackgroundImage:[UIImage imageNamed:@"edit.png"] forState:UIControlStateNormal];
        [_settingsButton setAlpha:0.5];
    }
    return _settingsButton;
}

- (UIButton *)deleteButton
{
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-65, SCREEN_HEIGHT-65, 50, 50)];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton setAlpha:0.5];
    }
    return _deleteButton;
}

@synthesize counter = _counter;

- (void)setCounter:(Counter *)counter
{
    _counter = counter;
    self.counterView.counter = _counter;
    self.headerView.eventName = counter.event;
    self.headerView.color = [HEADER_COLOR_DICTIONARY objectForKey:counter.color];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.transform = CGAffineTransformMakeRotation(-M_PI_2);
        self.backgroundColor = [UIColor blackColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.counterView];
        [self addSubview:self.headerView];
        [self addSubview:self.settingsButton];
        [self addSubview:self.deleteButton];
        
    }
    return self;
}

- (void)deleteButtonPressed
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete?" message:@"Do you really want to delete?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Yes"];
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self.page_delegate deletePageWithCounter:self.counter]; 
    }
}

- (void)onBackPressed
{
    [self.animator removeAllBehaviors];
    [UIView animateWithDuration:0.35 animations:^(void) {
        [self.settingsView setFrame:CGRectMake(self.bounds.origin.x, -self.bounds.size.height, self.settingsView.bounds.size.width, self.settingsView.bounds.size.height)];
    }completion:^(BOOL finished) {
        [self.page_delegate settingsPageShown:NO];
        [self.settingsView removeFromSuperview];
    }];
    
}

- (void)settingsButtonPressed
{
    NSLog(@"Hello");
    self.settingsView = [[SettingsView alloc]initWithFrame:CGRectMake(self.bounds.origin.x, -self.bounds.size.height+self.headerView.bounds.size.height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.settingsView.delegate = self;
    self.settingsView.counter = self.counter;
    [self.settingsView.backButton addTarget:self action:@selector(onBackPressed) forControlEvents:UIControlEventTouchUpInside];

    [self insertSubview:self.settingsView belowSubview:self.headerView];
    [self bringSubviewToFront:self.headerView];
    [self.page_delegate settingsPageShown:YES];
    UIGravityBehavior *_gravity = [[UIGravityBehavior alloc] initWithItems:@[self.settingsView]];
    _gravity.magnitude = 10;
    [self.animator addBehavior:_gravity];
    
    UIDynamicItemBehavior *elasticityBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.settingsView]];
    elasticityBehavior.elasticity = 0.3f;
    [self.animator addBehavior:elasticityBehavior];
    
    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.settingsView]];
    [collisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(SCREEN_HEIGHT+2, 0, 0, 0)];
    [self.animator addBehavior:collisionBehavior];
    
    /*
    [UIView animateWithDuration:0.3 animations:^(void) {
        [self.settingsView setFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }completion:^(BOOL finish){}];*/
}

- (void)settingsPageShown:(BOOL)shown
{
    [self.page_delegate settingsPageShown:shown];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)textDidChangedTo:(NSString *)text
{
    self.counter.event = text;
}


- (void)settingsDidSelectDate:(NSDate *)date
{
    self.counter.date = date;
    self.counterView.counter = self.counter;
}
@end
