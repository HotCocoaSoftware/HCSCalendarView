//
//  HCSDSLDatesPanel.m
//  HCSCalendarView
//
//  Created by Sahil Kapoor on 04/03/15.
//  Copyright (c) 2015 Hot Cocoa Software. All rights reserved.
//


#import "HCSDatesPanel.h"

#define CALENDAR_TITLE_COLOR [UIColor colorWithRed:152.f/255.f green:152.f/255.f blue:152.f/255.f alpha:1.f]
#define CALENDAR_UNAVAILABLE_DATE_COLOR [UIColor colorWithRed:58.f/255.f green:58.f/255.f blue:58.f/255.f alpha:1.000]
#define CALENDAR_SELECTED_DATE_COLOR [UIColor colorWithRed:70.f/255.f green:141.f/255.f blue:187.f/255.f alpha:1.000]
#define CALENDAR_NUMBERS_COLOR [UIColor colorWithRed:203.f/255.f green:203.f/255.f blue:203.f/255.f alpha:1.000]

@interface HCSDatesPanel ()

@property (nonatomic, strong) UILabel *dateRangeLabel;
@property (nonatomic, strong) UILabel *numberOfNightsLabel;
@property (nonatomic, strong) UIButton *dropdownButton;
@end

@implementation HCSDatesPanel

- (void)commonInit {
    
    self.backgroundColor = [UIColor blackColor];// VEGO_BACKGROUND_COLOR;
    [self setupDateRangeLabel];
    [self setupDividerImage];
    [self setupNumberOfNightsLabel];
    [self setupDropdownButton];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)setupDateRangeLabel {
    
    _dateRangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 115, 44)];
    _dateRangeLabel.backgroundColor = [UIColor clearColor];
    _dateRangeLabel.textAlignment = NSTextAlignmentRight;
    _dateRangeLabel.adjustsFontSizeToFitWidth = YES;
    _dateRangeLabel.minimumScaleFactor = 0.75f;
    
    [self addSubview:_dateRangeLabel];
}

- (void)setupDividerImage {
    
    UIImageView *divider = [[UIImageView alloc] initWithFrame:CGRectMake(159, 12, 2, 20)];
    divider.image = [UIImage imageNamed:@"divider_medium"];
    
    [self addSubview:divider];
}

- (void)setupNumberOfNightsLabel {
    
    _numberOfNightsLabel = [[UILabel alloc] initWithFrame:CGRectMake(191, 0, 114, 44)];
    _numberOfNightsLabel.backgroundColor = [UIColor clearColor];
    _numberOfNightsLabel.textColor = CALENDAR_NUMBERS_COLOR;
    _numberOfNightsLabel.font = [UIFont fontWithName:@"AvenirNext-Bold" size:13.f];
    
    [self addSubview:_numberOfNightsLabel];
}

- (void)setupDropdownButton {
    
    _dropdownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _dropdownButton.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 58);
    [_dropdownButton addTarget:self action:@selector(dropdownButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_dropdownButton setImage:[UIImage imageNamed:@"divider_dropdown_normal"] forState:UIControlStateNormal];
    [_dropdownButton setImageEdgeInsets:UIEdgeInsetsMake(44, 0, 0, 0)];
    
    [self addSubview:_dropdownButton];
}

- (void)setDropdownImageWithDateSelectorOpen:(BOOL)isSelectorOpen {
    
    UIImage *dropdownImage = isSelectorOpen ? [UIImage imageNamed:@"divider_dropdown_normal"] : [UIImage imageNamed:@"divider_dropdown_active"];
    [self.dropdownButton setImage:dropdownImage forState:UIControlStateNormal];
}

#pragma mark - Refresh dates

//- (void)refreshWithStartDateComponents:(NSDateComponents *)startDateComponents
//                     endDateComponents:(NSDateComponents *)endDateComponents {
//    
//    self.dateRangeLabel.attributedText = [self dateRangeAttributedStringWithStartDateComponents:startDateComponents endDateComponents:endDateComponents];
//    self.numberOfNightsLabel.attributedText = [self numberOfNightsAttributedStringWithStartDateComponents:startDateComponents endDateComponents:endDateComponents];
//}
//
//- (NSAttributedString *)dateRangeAttributedStringWithStartDateComponents:(NSDateComponents *)startDateComponents
//                                                       endDateComponents:(NSDateComponents *)endDateComponents {
//    
//    NSString *dateRangeString = [VGDateFormatter dateRangeStringForStartDateComponents:startDateComponents endDateComponents:endDateComponents includeYear:NO];
//    
//    NSMutableAttributedString *attributedText =
//    [[NSMutableAttributedString alloc] initWithString:dateRangeString attributes:@{NSFontAttributeName              : [UIFont fontWithName:@"AvenirNext-Medium" size:13.f],
//                                                                                   NSForegroundColorAttributeName  : CALENDAR_NUMBERS_COLOR}];
//    
//    NSArray *numberRangeValues = [self rangesOfNumeralsInString:dateRangeString];
//    
//    for (NSValue *rangeValue in numberRangeValues) {
//        [attributedText setAttributes:@{NSFontAttributeName            : [UIFont fontWithName:@"AvenirNext-Bold" size:13.f],
//                                        NSForegroundColorAttributeName  : CALENDAR_NUMBERS_COLOR}
//                                range:[rangeValue rangeValue]];
//    }
//    
//    return attributedText;
//}

//- (NSAttributedString *)numberOfNightsAttributedStringWithStartDateComponents:(NSDateComponents *)startDateComponents
//                                                            endDateComponents:(NSDateComponents *)endDateComponents {
//    
//    NSInteger days = [VGDateFormatter numberOfDaysBetweenStartDateComponents:startDateComponents
//                                                           endDateComponents:endDateComponents];
//    
//    NSString *daysString = [@(days) stringValue];
//    NSString *numberOfNightsString = [NSString stringWithFormat:@"%@%@", daysString, days == 1 ? @"Night" : @"Nights"];
//    NSRange daysStringRange = [numberOfNightsString rangeOfString:daysString];
//    
//    NSMutableAttributedString *attributedText =
//    [[NSMutableAttributedString alloc] initWithString:numberOfNightsString
//                                           attributes:@{NSFontAttributeName            : [UIFont fontWithName:@"AvenirNext-Medium" size:13.f],
//                                                        NSForegroundColorAttributeName  : CALENDAR_NUMBERS_COLOR}];
//    
//    [attributedText setAttributes:@{NSFontAttributeName            : [UIFont fontWithName:@"AvenirNext-Bold" size:13.f],
//                                    NSForegroundColorAttributeName  : CALENDAR_NUMBERS_COLOR}
//                            range:daysStringRange];
//    [attributedText setAttributes:@{NSKernAttributeName : @11} range:NSMakeRange(NSMaxRange(daysStringRange) - 1, 1)]; // add spacing btw number value and nights string
//    
//    return attributedText;
//}

- (NSArray *)rangesOfNumeralsInString:(NSString *)str  {
    
    NSCharacterSet *cs = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSMutableArray *results = [NSMutableArray array];
    NSScanner *scanner = [NSScanner scannerWithString:str];
    
    while (![scanner isAtEnd]) {
        
        [scanner scanUpToCharactersFromSet:cs intoString:NULL]; // skip non-numeral characters
        NSString *temp;
        NSUInteger location = [scanner scanLocation];
        
        if ([scanner scanCharactersFromSet:cs intoString:&temp]) {
            
            NSRange range = NSMakeRange(location, [temp length]);
            [results addObject:[NSValue valueWithRange:range]];
        }
    }
    
    return results;
}
#pragma mark - Targets and Actions

- (void)dropdownButtonTapped:(id)sender {
    
    [self.delegate dropdownButtonDidToggleForDatesPanel:self];
}


@end
