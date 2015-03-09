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

@class HCSDateSelectorView , DSLCalendarRange;

@protocol HCSDateSelectorViewDelegate <NSObject>

- (void)dateSelectorViewDidCancel:(HCSDateSelectorView *)dateSelectorView;
- (void)dateSelectorView:(HCSDateSelectorView *)dateSelectorView didSelectRange:(DSLCalendarRange *)range;

@end

@interface HCSDateSelectorView : UIImageView

@property (nonatomic, weak) id<HCSDateSelectorViewDelegate> delegate;
@property (nonatomic, strong, readonly) DSLCalendarRange *selectedRange;

- (void)setStartDate:(NSDateComponents *)startDate endDate:(NSDateComponents *)endDate;

@end
