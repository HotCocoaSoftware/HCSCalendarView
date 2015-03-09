//
//  HCSDSLCalendarView.m
//  HCSCalendarView
//
//  Created by Sahil Kapoor on 04/03/15.
//  Copyright (c) 2015 Hot Cocoa Software. All rights reserved.
//

#import "HCSNewCalendarView.h"
#import "HCSCalendarDayView.h"
#import "HCSMonthSelectorView.h"

@implementation HCSNewCalendarView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

+ (Class)dayViewClass {
    return [HCSCalendarDayView class];
}

+ (Class)monthSelectorViewClass {
    return [HCSMonthSelectorView class];
}

- (DSLCalendarDayView *)dayViewForTouches:(NSSet *)touches {
    
    HCSCalendarDayView *dayView = (HCSCalendarDayView *)[super dayViewForTouches:touches];
    
    return [dayView isAvailable] ? dayView : nil;
}

@end
