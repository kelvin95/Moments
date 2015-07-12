//
//  MainViewController.m
//  Countdown
//
//  Created by Kelvin Wong on 1/25/2014.
//  Copyright (c) 2014 Kelvin Wong. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "CounterView.h"
#include <math.h>
#import "Constants.h"
#import "PagesCell.h"

@interface MainViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UILabel *pullToAddLabel;

@end

@implementation MainViewController

@synthesize tableView = _tableView;
@synthesize appDelegate = _appDelegate;
@synthesize pageControl = _pageControl;
@synthesize pullToAddLabel = _pullToAddLabel;

- (UITableView *)tableView
{
    if (!_tableView) {
        /*
       _tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.height, self.view.bounds.size.width+20)];
        _tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        [_tableView setCenter:self.view.center];
         */
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        _tableView.transform = CGAffineTransformMakeRotation(M_PI_2);
        [_tableView setFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width+GUTTER_WIDTH, self.view.bounds.size.height+2)];
        [_tableView registerClass:[PagesCell class] forCellReuseIdentifier:@"cell"];
        [_tableView setBackgroundColor:[UIColor blackColor]];
        _tableView.pagingEnabled = YES;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.delaysContentTouches = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView removeConstraints:_tableView.constraints];
    }
    return _tableView;
}

- (AppDelegate *)appDelegate
{
    if (!_appDelegate) {
        _appDelegate = [[UIApplication sharedApplication]delegate];
    }
    return _appDelegate;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 20)];
        _pageControl.numberOfPages = [self.arrayOfCounters count];
        _pageControl.currentPage = 0;
        [_pageControl setUserInteractionEnabled:NO];
        
    }
    return  _pageControl;
}

- (UILabel *)pullToAddLabel
{
    if (!_pullToAddLabel) {
        _pullToAddLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [_pullToAddLabel setFont:[UIFont fontWithName:@"League Gothic" size:25]];
        [_pullToAddLabel setBackgroundColor:[UIColor blackColor]];
        [_pullToAddLabel setTextColor:[UIColor whiteColor]];
        [_pullToAddLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _pullToAddLabel;
}

@synthesize arrayOfCounters = _arrayOfCounters;
@synthesize makeNewObject = _makeNewObject;

- (BOOL)makeNewObject
{
    if (!_makeNewObject) {
        _makeNewObject = NO;
    }
    return _makeNewObject;
}

- (NSMutableArray *)arrayOfCounters
{
    if (!_arrayOfCounters) {
        _arrayOfCounters = [[NSMutableArray alloc]init];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:@"Counter" inManagedObjectContext:[self.appDelegate managedObjectContext]];
        [fetchRequest setEntity:entity];
        NSArray *fetchedObjects = [[self.appDelegate managedObjectContext] executeFetchRequest:fetchRequest error:nil];
        for (NSManagedObject *info in [fetchedObjects reverseObjectEnumerator]) {
            [_arrayOfCounters addObject:info];
        }
    }
    return _arrayOfCounters;
}

# pragma mark - TableView Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PagesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.counter = [self.arrayOfCounters objectAtIndex:[indexPath row]];
    cell.page_delegate = self;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayOfCounters count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.bounds.size.width+GUTTER_WIDTH;
}

#define NEEDED_HEIGHT 85

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.pullToAddLabel setFrame:CGRectZero];
    [self.pullToAddLabel setFrame:CGRectMake(0, -30, self.tableView.bounds.size.width, 30)];
    //_pullDownInProgress = scrollView.contentOffset.y <= 0.0f;
    self.makeNewObject = (scrollView.contentOffset.y <= 0.0f);
    if (self.makeNewObject) {
       // [self.tableView addSubview:self.pullToAddLabel];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.makeNewObject && (scrollView.contentOffset.y <= 0.0f)) {
        NSLog(@"MAKE NEW OBJECT? = %f %f", scrollView.contentOffset.y, self.tableView.contentSize.height);

        [self.pullToAddLabel setFrame:CGRectMake(0, -30, self.tableView.bounds.size.width, 30)];
        self.pullToAddLabel.text = (-scrollView.contentOffset.y >= NEEDED_HEIGHT) ? @"RELEASE TO ADD" : @"PULL TO ADD";
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // check whether the user pulled down far enough
    if (self.makeNewObject && (-scrollView.contentOffset.y >= NEEDED_HEIGHT)) {
        NSLog(@"HELLO");
        [self.pullToAddLabel setFrame:CGRectZero];
        [self addNewCounter];
        [self.pageControl setNumberOfPages:self.pageControl.numberOfPages+1];

    }
    self.makeNewObject = false;
    //[self.pullToAddLabel setFrame:CGRectZero];
    //[self.pullToAddLabel removeFromSuperview];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = ([self.arrayOfCounters count] - [[[self.tableView indexPathsForVisibleRows ]objectAtIndex:0]row] - 1);
    [self.pageControl setCurrentPage:page];
    NSLog(@"VISIBLE ROWS = %@", [[self.tableView indexPathsForVisibleRows ]objectAtIndex:0]);

}

- (void)addNewCounter
{
    Counter *newCounter = [NSEntityDescription insertNewObjectForEntityForName:@"Counter" inManagedObjectContext:[self.appDelegate managedObjectContext]];
    newCounter.date = [NSDate date];
    newCounter.event = @"NEW MOMENT";
    newCounter.color = @(arc4random() % 5);
    [self.arrayOfCounters insertObject:newCounter atIndex:0];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationBottom];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];

}


/*
 if (_pullDownInProgress && self.scrollView.contentOffset.y <= 0.0f) {
 // maintain the location of the placeholder
 _placeholderCell.frame = CGRectMake(0, - self.scrollView.contentOffset.y - SHC_ROW_HEIGHT,
 self.frame.size.width, SHC_ROW_HEIGHT);
 _placeholderCell.label.text = -self.scrollView.contentOffset.y > SHC_ROW_HEIGHT ?
 @"Release to Add Item" : @"Pull to Add Item";
 _placeholderCell.alpha = MIN(1.0f, - self.scrollView.contentOffset.y / SHC_ROW_HEIGHT);
 } else {
 _pullDownInProgress = false;
 }
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f", self.tableView.contentSize.height-scrollView.contentOffset.y);

    if (self.tableView.contentSize.height-scrollView.contentOffset.y < 250) {
        self.makeNewObject = YES;

    } else {
        self.makeNewObject = NO;
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.makeNewObject) {
        NSLog(@"SCROLL");
        Counter *newCounter = [NSEntityDescription insertNewObjectForEntityForName:@"Counter" inManagedObjectContext:[self.appDelegate managedObjectContext]];
        newCounter.date = [NSDate date];
        newCounter.event = @"NEW MOMENT";
        newCounter.color = @(arc4random() % 5);
        [self.arrayOfCounters addObject:newCounter];
        [self.tableView reloadData];
        [self.pageControl setNumberOfPages:self.pageControl.numberOfPages+1];

    }
}

- (void)scrollViewWillEndDecelerating:(UIScrollView *)scrollView
{
    if (self.makeNewObject) {
        CGPoint bottomOffset = CGPointMake(0, scrollView.contentSize.height - scrollView.bounds.size.height);
        [scrollView setContentOffset:bottomOffset animated:YES];
        self.makeNewObject = NO;

    }
}
*/

- (void)deletePageWithCounter:(Counter *)counter
{
    PagesCell *removeCell;
    for (PagesCell *cell in self.tableView.visibleCells) {
        if (cell.counter == counter) {
            removeCell = cell;
        }
    }
    [self.arrayOfCounters removeObject:counter];
    [self.tableView deleteRowsAtIndexPaths:@[[self.tableView indexPathForCell:removeCell]] withRowAnimation:UITableViewRowAnimationTop];
    [[self.appDelegate managedObjectContext]deleteObject:counter];
    [self.pageControl setNumberOfPages:self.pageControl.numberOfPages-1];
    
    if ([self.arrayOfCounters count] == 0) {
        Counter *newCounter = [NSEntityDescription insertNewObjectForEntityForName:@"Counter" inManagedObjectContext:[self.appDelegate managedObjectContext]];
        newCounter.date = [NSDate date];
        newCounter.event = @"NEW MOMENT";
        newCounter.color = @(arc4random() % 5);
        [self.arrayOfCounters addObject:newCounter];
        [self.pageControl setNumberOfPages:self.pageControl.numberOfPages+1];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationTop];

    }
}

- (void)settingsPageShown:(BOOL)shown
{
    if (shown) {
        [self.tableView setScrollEnabled:NO];
        [UIView animateWithDuration:0.5 animations:^{
            [self.pageControl setAlpha:0];
        }];
    } else {
        [self.tableView setScrollEnabled:YES];
        [UIView animateWithDuration:0.2 animations:^{
            [self.pageControl setAlpha:1];
        }];    }
}

- (id)init
{
    self = [super init];
    if (self) {
        if (![self.arrayOfCounters count]) {
            Counter *newCounter = [NSEntityDescription insertNewObjectForEntityForName:@"Counter" inManagedObjectContext:[self.appDelegate managedObjectContext]];
            newCounter.date = [NSDate date];
            newCounter.event = @"NEW MOMENT";
            newCounter.color = @(arc4random() % 5);
            [self.arrayOfCounters addObject:newCounter];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.pullToAddLabel];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[self.arrayOfCounters count]-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    [self.view addSubview:self.pageControl];
    
	// Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
