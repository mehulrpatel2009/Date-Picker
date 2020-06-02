//
//  RangeModel.m
//  CustomDatePicker
//
//  Created by Mehul Patel on 11/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import "RangeModel.h"

@implementation RangeModel

//---------------------------------------------------------------

#pragma mark -
#pragma mark Getter methods

//---------------------------------------------------------------

- (NSInteger) getNumberOfRows:(NSInteger)section {
    return (section == 0) ? 3 : (self.isShowCompareSwitch.boolValue) ? 2 : 0;
}

//---------------------------------------------------------------

- (void) switchValueChanged:(NSNumber *)switchValue forIndexPath:(NSIndexPath *)indexPath {
    self.isShowCompareSwitch = switchValue;
}

//---------------------------------------------------------------

- (CustomDate *) getDateComponents:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: return [self getStartDate]; break;
            case 1: return [self getEndDate]; break;
            case 2: return [self compareSwitch]; break;
            default: return nil; break;
        }
    } else {
        switch (indexPath.row) {
            case 0: return [self getCompareStartDate]; break;
            case 1: return [self getCompareEndDate]; break;
            default: return nil; break;
        }
    }
    return nil;
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark Date methods

//---------------------------------------------------------------

- (CustomDate *) getStartDate {
    // Custom range - Start Date
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"Start date";
    customDate.dateValue = self.startDate;
    customDate.startDate = self.startDate;
    customDate.endDate = self.endDate;
    customDate.compStartDate = self.compStartDate;
    customDate.compEndDate = self.compEndDate;
    // Strings
    customDate.dateString = [self getCustomDateRangeString:customDate];
    customDate.displayString = [self getDateRangeDisplayString:customDate isCompare:NO];
    self.selectedDate = customDate;
    return customDate;
}

//---------------------------------------------------------------

- (CustomDate *) getEndDate {
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"End date";
    customDate.dateValue = self.endDate;
    customDate.startDate = self.startDate;
    customDate.endDate = self.endDate;
    customDate.compStartDate = self.compStartDate;
    customDate.compEndDate = self.compEndDate;
    
    customDate.dateString = [self getCustomDateRangeString:customDate];
    customDate.displayString = [self getDateRangeDisplayString:customDate isCompare:NO];
    self.selectedDate = customDate;
    return customDate;
}

//---------------------------------------------------------------

- (CustomDate *) compareSwitch {
    // Non Date object - Compare Switch
    CustomDate *compareSwitchModel = [CustomDate new];
    compareSwitchModel.title = @"Compare to";
    compareSwitchModel.isNonDateObject = [NSNumber numberWithBool:YES];
    return compareSwitchModel;
}

//---------------------------------------------------------------

- (CustomDate *) getCompareStartDate {
    // Custom range - Start Date
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"Start date";
    customDate.startDate = self.startDate;
    customDate.endDate = self.endDate;
    customDate.dateValue = self.compStartDate;
    customDate.compStartDate = self.compStartDate;
    customDate.compEndDate = self.compEndDate;
    
    customDate.dateString = [self getCustomDateRangeString:customDate];
    customDate.displayString = [self getDateRangeDisplayString:customDate isCompare:YES];
    self.selectedCompareDate = customDate;
    return customDate;
}

//---------------------------------------------------------------

- (CustomDate *) getCompareEndDate {
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"End date";
    customDate.startDate = self.startDate;
    customDate.endDate = self.endDate;
    customDate.dateValue = self.compEndDate;
    customDate.compStartDate = self.compStartDate;
    customDate.compEndDate = self.compEndDate;
    
    customDate.dateString = [self getCustomDateRangeString:customDate];
    customDate.displayString = [self getDateRangeDisplayString:customDate isCompare:YES];
    self.selectedCompareDate = customDate;
    return customDate;
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark Helper methods

//---------------------------------------------------------------

- (NSString *) getCustomDateRangeString:(CustomDate *)customDate {
    // Check if Year is changed then set format that specify year in it
    NSString *dayFormat = ([DateHelper isCurrentYearSameWithDate:customDate.dateValue]) ? DAY_FORMAT : RANGE_YEAR_FORMAT;
    
    // Create date range string
    NSDateFormatter *dateFormatter = [DateHelper systemDateFormatter];
    dateFormatter.dateFormat = dayFormat;
    return [dateFormatter stringFromDate:customDate.dateValue];
}

//---------------------------------------------------------------

- (NSString *) getDateRangeDisplayString:(CustomDate *)customDate isCompare:(BOOL)isCompare {
    // Check if Year is changed then set format that specify year in it
    // Create date range string
    NSDateFormatter *dateFormatter = [DateHelper systemDateFormatter];
    dateFormatter.dateFormat = DISPLAY_FORMAT;
    NSString *firstDate = [dateFormatter stringFromDate:customDate.startDate];
    NSString *lastDate = [dateFormatter stringFromDate:customDate.endDate];
    
    if (isCompare) {
        firstDate = [dateFormatter stringFromDate:customDate.compStartDate];
        lastDate = [dateFormatter stringFromDate:customDate.compEndDate];
    }
    NSString *finalString = [NSString stringWithFormat:@"%@ - %@", firstDate, lastDate];
    return finalString;
}

//---------------------------------------------------------------

#pragma mark - Object Encoding/Decoding

//---------------------------------------------------------------

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.dateValue forKey:@"dateValue"];
    [aCoder encodeObject:self.startDate forKey:@"startDate"];
    [aCoder encodeObject:self.endDate forKey:@"endDate"];
    [aCoder encodeObject:self.compStartDate forKey:@"compStartDate"];
    [aCoder encodeObject:self.compEndDate forKey:@"compEndDate"];
    [aCoder encodeObject:self.selectedDate forKey:@"selectedDate"];
    [aCoder encodeObject:self.selectedCompareDate forKey:@"selectedCompareDate"];
    [aCoder encodeObject:self.indexPath forKey:@"indexPath"];
    [aCoder encodeObject:self.compIndexPath forKey:@"compIndexPath"];
    [aCoder encodeObject:self.isShowCompareSwitch forKey:@"isShowCompareSwitch"];
}

//---------------------------------------------------------------

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    self.dateValue = [aDecoder decodeObjectForKey:@"dateValue"];
    self.startDate = [aDecoder decodeObjectForKey:@"startDate"];
    self.endDate = [aDecoder decodeObjectForKey:@"endDate"];
    self.compStartDate = [aDecoder decodeObjectForKey:@"compStartDate"];
    self.compEndDate = [aDecoder decodeObjectForKey:@"compEndDate"];
    self.selectedDate = [aDecoder decodeObjectForKey:@"selectedDate"];
    self.selectedCompareDate = [aDecoder decodeObjectForKey:@"selectedCompareDate"];
    self.indexPath = [aDecoder decodeObjectForKey:@"indexPath"];
    self.compIndexPath = [aDecoder decodeObjectForKey:@"compIndexPath"];
    self.isShowCompareSwitch = [aDecoder decodeObjectForKey:@"isShowCompareSwitch"];
    return self;
}

//---------------------------------------------------------------

- (id)copyWithZone:(NSZone *)zone {
    RangeModel *model = [RangeModel new];
    model.dateValue = self.dateValue;
    model.startDate = self.startDate;
    model.endDate = self.endDate;
    model.compStartDate = self.compStartDate;
    model.compEndDate = self.compEndDate;
    model.selectedDate = self.selectedDate;
    model.selectedCompareDate = self.selectedCompareDate;
    model.indexPath = self.indexPath;
    model.compIndexPath = self.compIndexPath;
    model.isShowCompareSwitch = self.isShowCompareSwitch;
    return model;
}

//---------------------------------------------------------------

@end
