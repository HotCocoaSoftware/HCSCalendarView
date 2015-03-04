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
        self.backgroundColor = [UIColor backgroundColor];
        // Initialization code
    }
    return self;
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
