//
//  HCSDSLDateSelectorView.h
//  HCSCalendarView
//
//  Created by Sahil Kapoor on 04/03/15.
//  Copyright (c) 2015 Hot Cocoa Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSLCalendarMonthSelectorView.h"
#import "DSLCalendarRange.h"

@class HCSNewDateSelectorView , DSLCalendarRange;

@protocol HCSNewDateSelectorViewDelegate <NSObject>

- (void)dateSelectorViewDidCancel:(HCSNewDateSelectorView *)dateSelectorView;
- (void)dateSelectorViewDidSearchAvailability:(HCSNewDateSelectorView *)dateSelectorView;
- (void)dateSelectorView:(HCSNewDateSelectorView *)dateSelectorView didSelectRange:(DSLCalendarRange *)range;

@end

@interface HCSNewDateSelectorView : UIImageView

@property (nonatomic, weak) id<HCSNewDateSelectorViewDelegate> delegate;
@property (nonatomic, strong, readonly) DSLCalendarRange *selectedRange;

- (void)setStartDate:(NSDateComponents *)startDate endDate:(NSDateComponents *)endDate;

@end
