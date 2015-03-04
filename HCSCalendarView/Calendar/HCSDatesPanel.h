//
//  HCSDSLDatesPanel.h
//  HCSCalendarView
//
//  Created by Sahil Kapoor on 04/03/15.
//  Copyright (c) 2015 Hot Cocoa Software. All rights reserved.
//


#import <UIKit/UIKit.h>

@class HCSDatesPanel;

@protocol HCSDatesPanelDelegate <NSObject>

- (void)dropdownButtonDidToggleForDatesPanel:(HCSDatesPanel *)panel;

@end

@interface HCSDatesPanel : UIView

@property (nonatomic, weak) id<HCSDatesPanelDelegate> delegate;

- (void)setDropdownImageWithDateSelectorOpen:(BOOL)isSelectorOpen;
- (void)refreshWithStartDateComponents:(NSDateComponents *)startDateComponents
                     endDateComponents:(NSDateComponents *)endDateComponents;

@end
