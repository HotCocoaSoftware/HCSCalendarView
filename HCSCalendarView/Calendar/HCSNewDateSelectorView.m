//
//  HCSDSLDateSelectorView.m
//  HCSCalendarView
//
//  Created by Sahil Kapoor on 04/03/15.
//  Copyright (c) 2015 Hot Cocoa Software. All rights reserved.
//

#import "HCSNewDateSelectorView.h"
#import "HCSNewCalendarView.h"

#define CALENDAR_TITLE_COLOR [UIColor colorWithRed:152.f/255.f green:152.f/255.f blue:152.f/255.f alpha:1.f]
#define CALENDAR_UNAVAILABLE_DATE_COLOR [UIColor colorWithRed:58.f/255.f green:58.f/255.f blue:58.f/255.f alpha:1.000]
#define CALENDAR_SELECTED_DATE_COLOR [UIColor colorWithRed:70.f/255.f green:141.f/255.f blue:187.f/255.f alpha:1.000]
#define CALENDAR_NUMBERS_COLOR [UIColor colorWithRed:203.f/255.f green:203.f/255.f blue:203.f/255.f alpha:1.000]
#define HIGHLIGHT_BLUE [UIColor colorWithRed:22.f/255.f green:146.f/255.f blue:197.f/255.f alpha:1.000]
#define VEGO_GREY [UIColor colorWithWhite:0.302 alpha:1.000]

@interface HCSNewDateSelectorView () <DSLCalendarViewDelegate>

@property (nonatomic, strong) HCSNewCalendarView *calendarView;

@end

@implementation HCSNewDateSelectorView

- (id)initWithImage:(UIImage *)image {
    
    NSAssert(NO, @"Use - (id)initWithFrame:(CGRect)frame");
    
    return nil;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    
    NSAssert(NO, @"Use - (id)initWithFrame:(CGRect)frame");
    
    return nil;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.image = [UIImage imageNamed:@"bg_dropdown"];
        self.userInteractionEnabled = YES;
        
        [self setupCalendarView];
        [self setupButtons];
    }
    
    return self;
}

- (void)setupCalendarView {
    
    _calendarView = [[HCSNewCalendarView alloc] initWithFrame:self.bounds];
    _calendarView.delegate = self;
    [self addSubview:_calendarView];
}

- (void)setupButtons {
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - [self buttonHeight] -5,  CGRectGetWidth(self.bounds), [self buttonHeight]);
    cancelButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:13.f];
    [cancelButton setTitle:@"Done" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton setBackgroundColor:[UIColor blueColor]];
    cancelButton.titleLabel.font = [UIFont ixiRegularFontOfSize:kLargeFontSizeGlobal];
    [cancelButton addTarget:self action:@selector(cancelButtonTapped:)forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButton];
}

#pragma mark - Selected range

- (DSLCalendarRange *)selectedRange {
    return self.calendarView.selectedRange;
}

- (void)setStartDate:(NSDateComponents *)startDate endDate:(NSDateComponents *)endDate {
    [self.calendarView setSelectedRange:[[DSLCalendarRange alloc] initWithStartDay:startDate endDay:endDate]];
}

#pragma mark - Actions

- (void)cancelButtonTapped:(id)sender {
    [self.delegate dateSelectorViewDidCancel:self];
}

- (void)searchAvailabilityButtonTapped:(id)sender {
    [self.delegate dateSelectorViewDidSearchAvailability:self];
}

#pragma mark - Calendar delegate

- (void)calendarView:(DSLCalendarView *)calendarView didSelectRange:(DSLCalendarRange *)range {
    [self.delegate dateSelectorView:self didSelectRange:range];
}

#pragma mark - Button Height

- (CGFloat)buttonHeight {
    return 44;
}

@end
