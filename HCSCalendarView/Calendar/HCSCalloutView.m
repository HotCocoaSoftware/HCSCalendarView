//
//  HCSDSLCalloutView.m
//  travel
//
//  Created by shashi kumar on 5/13/14.
//  Copyright (c) 2014 Le Travenues Pvt Ltd. All rights reserved.
//

#import "HCSCalloutView.h"

@implementation HCSCalloutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // Initialization code
    }
    return self;
}

+ (UIColor *)backgroundColor {
    static UIColor *g_ixiBackgroundColor;
    if(!g_ixiBackgroundColor) {
        g_ixiBackgroundColor = [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1];
    }
    
    return g_ixiBackgroundColor;
}

- (void)setupCalloutViewForDateComponent:(NSDateComponents *)date {
    [self configureForDay:date];
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
