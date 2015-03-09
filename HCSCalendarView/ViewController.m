//
//  ViewController.m
//  HCSCalendarView
//
//  Created by Sahil Kapoor on 04/03/15.
//  Copyright (c) 2015 Hot Cocoa Software. All rights reserved.
//

#import "ViewController.h"
#import "HCSDateSelectorView.h"

static const CGFloat kComponentHeight = 52;

@interface ViewController () <HCSDateSelectorViewDelegate>

@property (nonatomic, strong) HCSDateSelectorView *dateSelectorView;
@property (nonatomic, strong) UIView *dateControlsContainerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addSubview:self.dateControlsContainerView];
}

- (UIView *)dateControlsContainerView {
    if (!_dateControlsContainerView) {
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        _dateControlsContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, screenHeight)];
        _dateControlsContainerView.backgroundColor = [UIColor clearColor];
        [_dateControlsContainerView addSubview:self.dateSelectorView];
    }
    
    return _dateControlsContainerView;
}

- (HCSDateSelectorView *)dateSelectorView {
    if (!_dateSelectorView) {
        CGFloat height = self.view.bounds.size.height - (kComponentHeight);
        _dateSelectorView = [[HCSDateSelectorView alloc] initWithFrame:CGRectMake(0, kComponentHeight, _dateControlsContainerView.bounds.size.width, height)];
        _dateSelectorView.delegate = self;
        
        [_dateControlsContainerView addSubview:_dateSelectorView];
    }
    
    return _dateSelectorView;
}

#pragma mark - HCSDateSelectorViewDelegate

- (void)dateSelectorViewDidCancel:(HCSDateSelectorView *)dateSelectorView {

}

- (void)dateSelectorView:(HCSDateSelectorView *)dateSelectorView didSelectRange:(DSLCalendarRange *)range {
    NSLog(@"%@", range.debugDescription);
}

@end
