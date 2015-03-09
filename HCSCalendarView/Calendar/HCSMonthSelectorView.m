//
//  HCSDSLMonthSelectorView.m
//  HCSCalendarView
//
//  Created by Sahil Kapoor on 04/03/15.
//  Copyright (c) 2015 Hot Cocoa Software. All rights reserved.
//

#import "HCSMonthSelectorView.h"

static CGFloat kButtonSide = 44.f;
static CGFloat kHeight = 64.f;
static CGFloat kMonthLabelWidth = 150.0f;
static NSUInteger kDaysInWeek = 7;

#define CALENDAR_TITLE_COLOR [UIColor colorWithRed:152.f/255.f green:152.f/255.f blue:152.f/255.f alpha:1.f]
#define CALENDAR_UNAVAILABLE_DATE_COLOR [UIColor colorWithRed:58.f/255.f green:58.f/255.f blue:58.f/255.f alpha:1.000]
#define CALENDAR_SELECTED_DATE_COLOR [UIColor colorWithRed:70.f/255.f green:141.f/255.f blue:187.f/255.f alpha:1.000]
#define CALENDAR_NUMBERS_COLOR [UIColor colorWithRed:203.f/255.f green:203.f/255.f blue:203.f/255.f alpha:1.000]

@implementation HCSMonthSelectorView

+ (id)view {
    
    HCSMonthSelectorView *view = [[HCSMonthSelectorView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), kHeight)];
    [self setupBackButtonForView:view];
    [self setupForwardButtonForView:view];
    [self setupTitleLabelForView:view];
    [self setupDayLabelsForView:view];
    
    return view;
}

+ (void)setupBackButtonForView:(HCSMonthSelectorView *)view {
    
    view.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    view.backButton.frame = CGRectMake(0, 0, kButtonSide, kButtonSide);
    [view.backButton setImage:[UIImage imageNamed:@"btn_cal_back_active"] forState:UIControlStateNormal];
    [view.backButton setImage:[UIImage imageNamed:@"btn_cal_back_active"] forState:UIControlStateHighlighted];
    [view.backButton setImage:[UIImage imageNamed:@"btn_cal_back_active"] forState:UIControlStateSelected];
    [view addSubview:view.backButton];
}

+ (void)setupForwardButtonForView:(HCSMonthSelectorView *)view {
    
    view.forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    view.forwardButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - kButtonSide, 0, kButtonSide, kButtonSide);
    [view.forwardButton setImage:[UIImage imageNamed:@"btn_cal_forward_active"] forState:UIControlStateNormal];
    [view.forwardButton setImage:[UIImage imageNamed:@"btn_cal_forward_active"] forState:UIControlStateHighlighted];
    [view.forwardButton setImage:[UIImage imageNamed:@"btn_cal_forward_active"] forState:UIControlStateSelected];
    [view addSubview:view.forwardButton];
}

+ (void)setupTitleLabelForView:(HCSMonthSelectorView *)view {
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - kMonthLabelWidth) / 2, 13.f, kMonthLabelWidth, 20.f)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:13.f];
    titleLabel.textColor = CALENDAR_TITLE_COLOR;
    [view addSubview:titleLabel];
    view.titleLabel = titleLabel;
}

+ (UILabel *)setupDayLabelForView:(HCSMonthSelectorView *)view
                   dateComponents:(NSDateComponents *)dateComponents
                       adjustDays:(NSUInteger)adjustDays
                            width:(CGFloat)width
                        formatter:(NSDateFormatter *)formatter {
    
    NSInteger weekday = dateComponents.weekday - [dateComponents.calendar firstWeekday];
    
    if (weekday < 0) {
        weekday += kDaysInWeek;
    }
    
    UILabel *dayLabel = [[UILabel alloc] initWithFrame:[self frameForWeekday:weekday width:width adjustment:adjustDays]];
    dayLabel.backgroundColor = [UIColor clearColor];
    dayLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:10.f];
    dayLabel.textAlignment = NSTextAlignmentCenter;
    dayLabel.textColor = CALENDAR_TITLE_COLOR;
    
    // Set the day name label texts to localised day names
    dayLabel.text = [[formatter stringFromDate:dateComponents.date] uppercaseString];
    [view addSubview:dayLabel];
    
    return dayLabel;
}

+ (void)setupDayLabelsForView:(HCSMonthSelectorView *)view {
    
    // Get a dictionary of localised day names
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitCalendar | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:[NSDate date]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE";
    
    NSMutableArray *dayLabels = [NSMutableArray arrayWithCapacity:kDaysInWeek];
    
    CGFloat width = roundf(view.frame.size.width / kDaysInWeek);
    NSUInteger adjustDays = width * kDaysInWeek - view.frame.size.width;
    
    for (NSInteger index = 0; index < kDaysInWeek; index++) {
        
        UILabel *dayLabel = [self setupDayLabelForView:view
                                        dateComponents:dateComponents
                                            adjustDays:adjustDays
                                                 width:width
                                             formatter:formatter];
        [dayLabels addObject:dayLabel];
        
        dateComponents.day = dateComponents.day + 1;
        dateComponents = [dateComponents.calendar components:NSCalendarUnitCalendar | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:dateComponents.date];
    }
    
    view.dayLabels = dayLabels;
}

#pragma mark - Helpers

// first #daysThreshold days have width set a bit higher than the rest (since we can't divide width evenly - number of days is odd)
+ (CGRect)frameForWeekday:(NSInteger)weekday width:(CGFloat)width adjustment:(NSUInteger)adjust {
    
    NSUInteger daysThreshold = kDaysInWeek - adjust;
    
    if (weekday <= daysThreshold) {
        return CGRectMake(weekday * width, kHeight - 20.f, width, 20.f);
    } else {
        return CGRectMake(daysThreshold * width + (weekday - daysThreshold) * (width - 1), kHeight - 20.f, width - 1, 20.f);
    }
}

@end
