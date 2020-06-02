//
//  MonthModel.m
//  CustomDatePicker
//
//  Created by Mehul Patel on 11/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import "MonthModel.h"

@implementation MonthModel

//---------------------------------------------------------------

#pragma mark -
#pragma mark Getter methods

//---------------------------------------------------------------

- (CustomDate *) getSelectedDate {
    return (self.indexPath) ? [self getDateComponents:self.indexPath] : [self getDateComponents:[NSIndexPath indexPathForRow:0 inSection:0]];
}

//---------------------------------------------------------------

- (CustomDate *) getCompareSelectedCompareDate {
    return (self.compIndexPath) ? [self getDateComponents:self.compIndexPath] : [self getDateComponents:[NSIndexPath indexPathForRow:0 inSection:1]];
}

//---------------------------------------------------------------

- (NSInteger) getNumberOfRows:(NSInteger)section {
    return (section == 0) ? 4 : (self.isShowCompareSwitch.boolValue) ? 4 : 0;
}

//---------------------------------------------------------------

- (void) switchValueChanged:(NSNumber *)switchValue forIndexPath:(NSIndexPath *)indexPath {
    self.isShowCompareSwitch = switchValue;
    CustomDate *customDate = [self getDateComponents:indexPath];
    self.dateValue  = customDate.dateValue;
    self.startDate  = customDate.startDate;
    self.endDate  = customDate.endDate;
}

//---------------------------------------------------------------

- (CustomDate *) getDateComponents:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: return [self getLast30Days]; break;
            case 1: return [self getThisMonthDate]; break;
            case 2: return [self getLastMonthDate]; break;
            case 3: return [self compareSwitch]; break;
            default: return nil; break;
        }
    } else {
        switch (indexPath.row) {
            case 0: return [self getPreviousMonthDate]; break;
            case 1: return [self getFourWeeksAgo]; break;
            case 2: return [self getPreviousYear]; break;
            case 3: return [self get52WeeksAgo]; break;
            default: return nil; break;
        }
    }
    return nil;
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark Date methods

//---------------------------------------------------------------

- (CustomDate *) getLast30Days {
    // Get last 30 days
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"Last 30 days";
    // Start date - 30 days before
    customDate.startDate = [DateHelper getDateBeforeDays:-30];
    // End date - Yesterday
    customDate.endDate = [DateHelper getDateBeforeDays:-1];
    customDate.dateString = [self getDateRangeForWeekString:customDate];
    customDate.displayString = customDate.dateString;
    customDate.dateValue = self.dateValue;
    customDate.isRangeInPeriod = [NSNumber numberWithBool:YES];
    self.selectedDate = customDate;
    return customDate;
}

//---------------------------------------------------------------

- (CustomDate *) getThisMonthDate {
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"This month";
    customDate.startDate = [DateHelper firstDateOfMonth:[NSDate date]];
    customDate.endDate = [DateHelper lastDateOfMonth:[NSDate date]];
    customDate.month = [NSNumber numberWithInteger:[DateHelper getMonthFromDate:customDate.startDate]];
    customDate.year = [NSNumber numberWithInteger:[DateHelper getYearForDate:customDate.startDate]];
    customDate.dateString = [self getDateRangeForMonthString:customDate];
    customDate.displayString = customDate.dateString;
    customDate.dateValue = self.dateValue;
    self.selectedDate = customDate;
    return customDate;
}

//---------------------------------------------------------------

- (CustomDate *) getLastMonthDate {
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"Last month";
    customDate.startDate = [DateHelper firstDateOfLastMonth:[NSDate date]];
    customDate.endDate = [DateHelper lastDateOfLastMonth:[NSDate date]];
    customDate.month = [NSNumber numberWithInteger:[DateHelper getMonthFromDate:customDate.startDate]];
    customDate.year = [NSNumber numberWithInteger:[DateHelper getYearForDate:customDate.startDate]];
    customDate.dateString = [self getDateRangeForMonthString:customDate];
    customDate.displayString = customDate.dateString;
    customDate.dateValue = self.dateValue;
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

- (CustomDate *) getPreviousMonthDate {
    CustomDate *customDate = [CustomDate new];
    
    if ([self isSelectedDateRangeIsPeriod]) {
        // Date for Period
        customDate.title = @"Previous period";
        customDate.startDate = [DateHelper getDateForMonth:-1 withDate:self.startDate];
        customDate.endDate = [DateHelper getDateForMonth:-1 withDate:self.endDate];
        
        customDate.month = [NSNumber numberWithInteger:[DateHelper getMonthFromDate:customDate.startDate]];
        customDate.year = [NSNumber numberWithInteger:[DateHelper getYearForDate:customDate.startDate]];
        customDate.dateString = [self getDateRangeForWeekString:customDate];
        customDate.displayString = customDate.dateString;
    } else {
        // Date for month only
        customDate.title = @"Previous month";
        customDate.startDate = [DateHelper firstDateOfLastMonth:self.startDate];
        customDate.endDate = [DateHelper lastDateOfLastMonth:self.endDate];
        customDate.month = [NSNumber numberWithInteger:[DateHelper getMonthFromDate:customDate.startDate]];
        customDate.year = [NSNumber numberWithInteger:[DateHelper getYearForDate:customDate.startDate]];
        customDate.dateString = [self getDateRangeForMonthString:customDate];
        customDate.displayString = customDate.dateString;
    }
    
    
    self.selectedCompareDate = customDate;
    return customDate;
}

//---------------------------------------------------------------

- (CustomDate *) getFourWeeksAgo {
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"Four weeks ago";
    customDate.startDate = [DateHelper getWeekDateForWeekNumber:self.startDate weekNumber:-4];
    customDate.endDate = [DateHelper getWeekDateForWeekNumber:self.endDate weekNumber:-4];
    customDate.dateString = [self getDateRangeForWeekString:customDate];
    customDate.displayString = customDate.dateString;
    self.selectedCompareDate = customDate;
    return customDate;
}

//---------------------------------------------------------------

- (CustomDate *) getPreviousYear {
    CustomDate *customDate = [CustomDate new];
    
    if ([self isSelectedDateRangeIsPeriod]) {
        // Date for Period
        customDate.title = @"Previous year";
        customDate.dateValue = [DateHelper getLastYearDate:self.startDate];
        customDate.startDate = [DateHelper getDateForYear:-1 withDate:self.startDate];
        customDate.endDate = [DateHelper getDateForYear:-1 withDate:self.endDate];
        
        customDate.month = [NSNumber numberWithInteger:[DateHelper getMonthFromDate:customDate.startDate]];
        customDate.year = [NSNumber numberWithInteger:[DateHelper getYearForDate:customDate.startDate]];
        customDate.dateString = [self getDateRangeForWeekString:customDate];
        customDate.displayString = customDate.dateString;

    } else {
        // Date for month only
        customDate.title = @"Previous year";
        customDate.dateValue = [DateHelper getLastYearDate:self.startDate];
        customDate.startDate = [DateHelper getLastYearDate:self.startDate];
        customDate.endDate = [DateHelper getLastYearDate:self.startDate];
        
        customDate.month = [NSNumber numberWithInteger:[DateHelper getMonthFromDate:customDate.startDate]];
        customDate.year = [NSNumber numberWithInteger:[DateHelper getYearForDate:customDate.startDate]];
        customDate.dateString = [self getDateRangeForMonthString:customDate];
        customDate.displayString = customDate.dateString;
    }

    self.selectedCompareDate = customDate;
    return customDate;
}

//---------------------------------------------------------------

- (CustomDate *) get52WeeksAgo {
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"52 weeks ago";
    customDate.startDate = [DateHelper getWeekDateForWeekNumber:self.startDate weekNumber:-52];
    customDate.endDate = [DateHelper getWeekDateForWeekNumber:self.endDate weekNumber:-52];
    customDate.dateString = [self getDateRangeForWeekString:customDate];
    customDate.displayString = customDate.dateString;
    self.selectedCompareDate = customDate;
    return customDate;
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark Helper methods

//---------------------------------------------------------------

- (BOOL) isSelectedDateRangeIsPeriod {
    CustomDate *customDate = [self getDateComponents:self.indexPath];
    return customDate.isRangeInPeriod.boolValue;
}

//---------------------------------------------------------------

- (NSString *) getDateRangeForWeekString:(CustomDate *)customDate {
    
    // Check if Year is changed then set format that specify year in it
    NSString *weekFormat = ([DateHelper isCurrentYearSameWithDate:customDate.startDate]) ? WEEK_FORMAT : YEAR_FORMAT;
    
    // Create date range string
    NSDateFormatter *dateFormatter = [DateHelper systemDateFormatter];
    dateFormatter.dateFormat = weekFormat;
    NSString *startDateString = [dateFormatter stringFromDate:customDate.startDate];
    NSString *endDateString = [dateFormatter stringFromDate:customDate.endDate];
    return [NSString stringWithFormat:@"%@ - %@", startDateString, endDateString];
}

//---------------------------------------------------------------

- (NSString *) getDateRangeForMonthString:(CustomDate *)customDate {
    // Check if Year is changed then set format that specify year in it
    NSString *monthString = ([DateHelper isCurrentYearSameWithDate:customDate.startDate]) ? [DateHelper getMonthNameString:customDate.startDate] : [NSString stringWithFormat:@"%@ %@", [DateHelper getMonthNameString:customDate.startDate], customDate.year.stringValue];
    return monthString;
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
    MonthModel *model = [MonthModel new];
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
