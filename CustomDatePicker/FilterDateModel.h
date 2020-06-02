//
//  FilterDateModel.h
//  CustomDatePicker
//
//  Created by Mehul Patel on 10/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DayModel.h"
#import "WeekModel.h"
#import "MonthModel.h"
#import "RangeModel.h"

#define APP_COLOR                 [UIColor colorWithRed:7/255.0f green:7/255.0f blue:20/255.0f alpha:1]

typedef enum : NSUInteger {
    DateViewTypeDay = 0,
    DateViewTypeWeek = 1,
    DateViewTypeMonth = 2,
    DateViewTypeCustom = 3,
} DateViewType;

@interface FilterDateModel : NSObject <NSCopying>

@property (nonatomic, strong) NSNumber          *viewType;
@property (nonatomic, strong) DayModel          *dayModel;
@property (nonatomic, strong) WeekModel         *weekModel;
@property (nonatomic, strong) MonthModel        *monthModel;
@property (nonatomic, strong) RangeModel        *rangeModel;

- (NSInteger) getNumberOfRows:(NSInteger)section;
- (CustomDate *) getDateComponents:(NSIndexPath *)indexPath;
- (void) switchValueChanged:(NSNumber *)switchValue forIndexPath:(NSIndexPath *)indexPath;
- (CustomDate *) getSelectedDate;
- (CustomDate *) getSelectedCompareDate;
- (NSNumber *) getSwitchValue;
- (NSIndexPath *) getIndexPath;
- (NSIndexPath *) getCompareIndexPath;

@end
