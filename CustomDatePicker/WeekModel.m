//
//  WeekModel.m
//  CustomDatePicker
//
//  Created by Mehul Patel on 11/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import "WeekModel.h"

@implementation WeekModel

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
    return (section == 0) ? 4 : (self.isShowCompareSwitch.boolValue) ? 2 : 0;
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
            case 0: return [self getLast7Days]; break;
            case 1: return [self getThisWeek]; break;
            case 2: return [self getLastWeek]; break;
            case 3: return [self compareSwitch]; break;
            default: return nil; break;
        }
    } else {
        switch (indexPath.row) {
            case 0: return [self getPreviousPeriod]; break;
            case 1: return [self getFourWeeksAgo]; break;
            default: return nil; break;
        }
    }
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark Date methods

//---------------------------------------------------------------

- (CustomDate *) getLast7Days {
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"Last 7 days";
    // Start date - 7 days before
    customDate.startDate = [DateHelper getDateBeforeDays:-7];
    // End date - Yesterday
    customDate.endDate = [DateHelper getDateBeforeDays:-1];
    customDate.dateString = [self getDateRangeForWeekString:customDate];
    customDate.displayString = customDate.dateString;
    self.selectedDate = customDate;
    return customDate;
}

//---------------------------------------------------------------

- (CustomDate *) getThisWeek {
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"This week";
    customDate.startDate = [DateHelper getFirstDayOfCurrentWeek];
    customDate.endDate = [DateHelper getLastDayOfCurrentWeek];
    customDate.dateString = [self getDateRangeForWeekString:customDate];
    customDate.displayString = customDate.dateString;
    self.selectedDate = customDate;
    return customDate;
}

//---------------------------------------------------------------

- (CustomDate *) getLastWeek {
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"Last week";
    customDate.startDate = [DateHelper getLastWeekDate: [DateHelper getFirstDayOfCurrentWeek]];
    customDate.endDate = [DateHelper getLastWeekDate: [DateHelper getLastDayOfCurrentWeek]];
    customDate.dateString = [self getDateRangeForWeekString:customDate];
    customDate.displayString = customDate.dateString;
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

- (CustomDate *) getPreviousPeriod {
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"Previous period";
    
//    NSDate *getWeekEnd = [DateHelper getDateBeforeDays:-7 forDate:self.startDate];
    customDate.startDate = [DateHelper getDateBeforeDays:-7 forDate:self.startDate];
    customDate.endDate = [DateHelper getDateBeforeDays:-1 forDate:self.startDate];
    customDate.dateString = [self getDateRangeForWeekString:customDate];
    customDate.displayString = customDate.dateString;
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

#pragma mark -
#pragma mark Helper methods

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
    WeekModel *model = [WeekModel new];
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
