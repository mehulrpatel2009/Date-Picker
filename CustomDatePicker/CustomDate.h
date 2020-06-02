//
//  CustomDate.h
//  CustomDatePicker
//
//  Created by Mehul Patel on 10/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateHelper.h"

#define DAY_FORMAT              @"EEEE, dd MMM"
#define WEEK_FORMAT             @"dd MMM"
#define MONTH_FORMAT            @"MMMM"
#define YEAR_FORMAT             @"dd MMM yyyy"
#define RANGE_YEAR_FORMAT       @"EEEE, dd MMM yyyy"

#define DISPLAY_FORMAT          @"MMM dd, yyyy"

#define KEY_DATE_TITLE              @"DateTitle"
#define KEY_DATE_FORAMT_STRING      @"DateFormatString"
#define KEY_DATE_VALUE              @"DateValue"

@interface CustomDate : NSObject <NSCopying>

//* Title for the date
@property (nonatomic, strong) NSNumber          *customDateId;
//* Title for the date
@property (nonatomic, strong) NSString          *title;
//* Display string on control
@property (nonatomic, strong) NSString          *displayString;
//* Date display string on UI
@property (nonatomic, strong) NSString          *dateString;
//* Single day no date range
@property (nonatomic, strong) NSDate            *dateValue;
//* Date range - Start date of range
@property (nonatomic, strong) NSDate            *startDate;
//* Date range - End date of range
@property (nonatomic, strong) NSDate            *endDate;
//* Date range - Compare Start date of range
@property (nonatomic, strong) NSDate            *compStartDate;
//* Date range - Compare End date of range
@property (nonatomic, strong) NSDate            *compEndDate;
//* Month in integer
@property (nonatomic, strong) NSNumber          *month;
//* year in integer
@property (nonatomic, strong) NSNumber          *year;
//* Check wheter object is date type
@property (nonatomic, strong) NSNumber          *isNonDateObject;
//* Check if dates are in period
@property (nonatomic, strong) NSNumber          *isRangeInPeriod;

@end
