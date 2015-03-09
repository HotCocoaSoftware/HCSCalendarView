//
//  HCSDSLCalendarDayView.m
//  HCSCalendarView
//
//  Created by Sahil Kapoor on 04/03/15.
//  Copyright (c) 2015 Hot Cocoa Software. All rights reserved.
//


#import "HCSCalendarDayView.h"
#import "DSLCalendarDayView.h"

#define SECONDS_IN_DAY (24 * 60 * 60)
#define VEGO_BRIGHT_GRAY [UIColor colorWithWhite:0.8 alpha:1.000]
#define CALENDAR_TITLE_COLOR [UIColor colorWithRed:152.f/255.f green:152.f/255.f blue:152.f/255.f alpha:1.f]
#define CALENDAR_UNAVAILABLE_DATE_COLOR [UIColor colorWithRed:58.f/255.f green:58.f/255.f blue:58.f/255.f alpha:1.000]
#define CALENDAR_SELECTED_DATE_COLOR [UIColor colorWithRed:70.f/255.f green:141.f/255.f blue:187.f/255.f alpha:1.000]
#define CALENDAR_NUMBERS_COLOR [UIColor colorWithRed:203.f/255.f green:203.f/255.f blue:203.f/255.f alpha:1.000]
#define HIGHLIGHT_BLUE [UIColor colorWithRed:22.f/255.f green:146.f/255.f blue:197.f/255.f alpha:1.000]

static const CGFloat kLengths[2] = {1, 1};
static CGFloat const kRadius = 18.f;

@implementation HCSCalendarDayView

#pragma mark UIView methods

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [self drawBackground];
    [self drawDayNumber];
}

#pragma mark Drawing

- (void)drawBackground {
    
    [[UIColor clearColor] setFill];
    UIRectFill(self.bounds);
    
    switch (self.selectionState) {
            
        case DSLCalendarDayViewNotSelected:
            
            break;
        case DSLCalendarDayViewWithinSelection: {
            
            if (self.positionInWeek == DSLCalendarDayViewStartOfWeek) {
                [self drawStartOfWeekDay];
            } else if (self.positionInWeek == DSLCalendarDayViewEndOfWeek) {
                [self drawEndOfWeekDay];
            } else {
                [self drawMidWeekDay];
            }
        }
            
            break;
        case DSLCalendarDayViewWholeSelection:
            [self drawWholeSelectionDay];
            
            break;
        case DSLCalendarDayViewStartOfSelection:
            [self drawStartOfSelectionDay];
            
            break;
        case DSLCalendarDayViewEndOfSelection:
            [self drawEndOfSelectionDay];
            
            break;
        case DSLCalendarDayViewCurrentWholeSelection:
            [self drawCurrentWholeSelectionDay];
            
            break;
        case DSLCalendarDayViewCurrentStartOfSelection:
            [self drawCurrentStartOfSelectionDay];
            
            break;
        case DSLCalendarDayViewCurrentEndOfSelection:
            [self currentEndOfSelectionDay];
            
            break;
    }
}

- (void)drawStartOfWeekDay {
    
    [[HIGHLIGHT_BLUE colorWithAlphaComponent:0.8f] setStroke];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineDash(context, 0, kLengths, 2);
    CGContextAddArc(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds), kRadius, 3 * M_PI / 2, 5 * M_PI / 2, YES);
    CGContextMoveToPoint(context, CGRectGetMidX(self.bounds) + 1, CGRectGetMidY(self.bounds) - kRadius);
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds) - kRadius);
    CGContextMoveToPoint(context, CGRectGetMidX(self.bounds) + 1, CGRectGetMidY(self.bounds) + kRadius);
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds) + kRadius);
    
    CGContextStrokePath(context);
}

- (void)drawEndOfWeekDay {
    
    [[HIGHLIGHT_BLUE colorWithAlphaComponent:0.8f] setStroke];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineDash(context, 0, kLengths, 2);
    CGContextAddArc(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds), kRadius, 3 * M_PI / 2, 5 * M_PI / 2, NO);
    CGContextMoveToPoint(context, 1, CGRectGetMidY(self.bounds) - kRadius);
    CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) - kRadius);
    CGContextMoveToPoint(context, 1, CGRectGetMidY(self.bounds) + kRadius);
    CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) + kRadius);
    
    CGContextStrokePath(context);
}

- (void)drawMidWeekDay {
    
    [[HIGHLIGHT_BLUE colorWithAlphaComponent:0.8f] setStroke];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineDash(context, 0, kLengths, 2);
    CGContextMoveToPoint(context, 0, CGRectGetMidY(self.bounds) - kRadius);
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds) - kRadius);
    CGContextMoveToPoint(context, 0, CGRectGetMidY(self.bounds) + kRadius);
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds) + kRadius);
    
    CGContextStrokePath(context);
}

- (void)drawWholeSelectionDay {
    
    [HIGHLIGHT_BLUE setStroke];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds), kRadius, 0, 2 * M_PI, YES);
    CGContextStrokePath(context);
}

- (void)drawStartOfSelectionDay {

    [HIGHLIGHT_BLUE setStroke];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds), kRadius, 0, 2 * M_PI, YES);
    
    CGContextStrokePath(context);
    
    if (self.positionInWeek != DSLCalendarDayViewEndOfWeek) {
        
        [[HIGHLIGHT_BLUE colorWithAlphaComponent:0.8f] setStroke];
        
        CGContextSetLineDash(context, 0, kLengths, 2);
        CGContextMoveToPoint(context, CGRectGetMidX(self.bounds) + 1, CGRectGetMidY(self.bounds) - kRadius);
        CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds) - kRadius);
        CGContextMoveToPoint(context, CGRectGetMidX(self.bounds) + 1, CGRectGetMidY(self.bounds) + kRadius);
        CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds) + kRadius);
        
        CGContextStrokePath(context);
    }
}

- (void)drawEndOfSelectionDay {
    
    [HIGHLIGHT_BLUE setStroke];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddArc(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds), kRadius, 0, 2 * M_PI, YES);
    
    CGContextStrokePath(context);
    
    if (self.positionInWeek != DSLCalendarDayViewStartOfWeek) {
        
        [[HIGHLIGHT_BLUE colorWithAlphaComponent:0.8f] setStroke];
        
        CGContextSetLineDash(context, 0, kLengths, 2);
        
        CGFloat offset = self.positionInWeek == DSLCalendarDayViewEndOfWeek ? 1 : 0;
        CGContextMoveToPoint(context, offset, CGRectGetMidY(self.bounds) - kRadius);
        CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) - kRadius);
        CGContextMoveToPoint(context, offset, CGRectGetMidY(self.bounds) + kRadius);
        CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) + kRadius);
        
        CGContextStrokePath(context);
    }
}

- (void)drawCurrentWholeSelectionDay {
    
    [[HIGHLIGHT_BLUE colorWithAlphaComponent:0.8f] setStroke];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineDash(context, 0, kLengths, 2);
    CGContextAddArc(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds), kRadius, 0, 2 * M_PI, YES);
    
    CGContextStrokePath(context);
}

- (void)drawCurrentStartOfSelectionDay {
    
    [[HIGHLIGHT_BLUE colorWithAlphaComponent:0.8f] setStroke];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineDash(context, 0, kLengths, 2);
    CGContextAddArc(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds), kRadius, 0, 2 * M_PI, YES);
    
    CGContextStrokePath(context);
    
    if (self.positionInWeek != DSLCalendarDayViewEndOfWeek) {
        
        CGContextMoveToPoint(context, CGRectGetMidX(self.bounds) + 1, CGRectGetMidY(self.bounds) - kRadius);
        CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds) - kRadius);
        CGContextMoveToPoint(context, CGRectGetMidX(self.bounds) + 1, CGRectGetMidY(self.bounds) + kRadius);
        CGContextAddLineToPoint(context, CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds) + kRadius);
        
        CGContextStrokePath(context);
    }
}

- (void)currentEndOfSelectionDay {
    
    [[HIGHLIGHT_BLUE colorWithAlphaComponent:0.8f] setStroke];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineDash(context, 0, kLengths, 2);
    CGContextAddArc(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds), kRadius, 0, 2 * M_PI, YES);
    
    CGContextStrokePath(context);
    
    if (self.positionInWeek != DSLCalendarDayViewStartOfWeek) {
        
        CGContextSetLineDash(context, 0, kLengths, 2);
        
        CGFloat offset = self.positionInWeek == DSLCalendarDayViewEndOfWeek ? 1 : 0;
        CGContextMoveToPoint(context, offset, CGRectGetMidY(self.bounds) - kRadius);
        CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) - kRadius);
        CGContextMoveToPoint(context, offset, CGRectGetMidY(self.bounds) + kRadius);
        CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) + kRadius);
        
        CGContextStrokePath(context);
    }
}

- (void)drawDayNumber {
    
    UIColor *color;
    UIFont *textFont;
    
    if ([self isAvailable]) {
        
        switch (self.selectionState) {
                
            case DSLCalendarDayViewNotSelected: {
                
                color = CALENDAR_UNAVAILABLE_DATE_COLOR;
                textFont = [UIFont fontWithName:@"AvenirNext-Medium" size:16.f];
            }
                
                break;
            case DSLCalendarDayViewCurrentStartOfSelection:
            case DSLCalendarDayViewCurrentEndOfSelection:
            case DSLCalendarDayViewCurrentWholeSelection:
            case DSLCalendarDayViewWithinSelection: {
                
                color = CALENDAR_SELECTED_DATE_COLOR;
                textFont = [UIFont fontWithName:@"AvenirNext-Regular" size:15.f];
            }
                
                break;
            case DSLCalendarDayViewWholeSelection:
            case DSLCalendarDayViewStartOfSelection:
            case DSLCalendarDayViewEndOfSelection: {
                
                color = CALENDAR_SELECTED_DATE_COLOR;
                textFont = [UIFont fontWithName:@"AvenirNext-Bold" size:16.f];
            }
                
                break;
        }
    } else {
        
        color = VEGO_BRIGHT_GRAY;// CALENDAR_UNAVAILABLE_DATE_COLOR;
        textFont = [UIFont fontWithName:@"AvenirNext-DemiBold" size:16.f];
    }
    
    [color set];
    
    NSString *text = [NSString stringWithFormat:@"%d", self.day.day];
    CGSize textSize = [text sizeWithFont:textFont];
    
    CGRect textRect = CGRectMake(ceilf(CGRectGetMidX(self.bounds) - (textSize.width / 2.0)), ceilf(CGRectGetMidY(self.bounds) - (textSize.height / 2.0)), textSize.width, textSize.height);
    [text drawInRect:textRect withFont:textFont];
}

- (BOOL)isAvailable {
    
    return [self.dayAsDate timeIntervalSinceNow] > -SECONDS_IN_DAY;
}
@end
