//
//  DayModel.m
//  CustomDatePicker
//
//  Created by Mehul Patel on 11/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import "DayModel.h"

@implementation DayModel

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
    return (section == 0) ? 4 : (self.isShowCompareSwitch.boolValue) ? 3 : 0;
}

//---------------------------------------------------------------

- (void) switchValueChanged:(NSNumber *)switchValue forIndexPath:(NSIndexPath *)indexPath {
    self.isShowCompareSwitch = switchValue;
    CustomDate *customDate = [self getDateComponents:indexPath];
    self.dateValue  = customDate.dateValue;
}

//---------------------------------------------------------------

- (CustomDate *) getDateComponents:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: return [self getToday]; break;
            case 1: return [self getYesterday]; break;
            case 2: return [self dayBeforeYesterday]; break;
            case 3: return [self compareSwitch]; break;
            default: return nil; break;
        }
    } else {
        switch (indexPath.row) {
            case 0: return [self getPreviousDay]; break;
            case 1: return [self getSameDayLastWeek]; break;
            case 2: return [self getSameDayLastYear]; break;
            default: return nil; break;
        }
    }
    
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark Date methods

//---------------------------------------------------------------

- (CustomDate *) getToday {
    NSString *todayString = [self getDateRangeForDayString:[NSDate date]];
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"Today";
    customDate.dateValue = [NSDate date];
    customDate.dateString = todayString;
    customDate.displayString = customDate.dateString;
    return customDate;
}

//---------------------------------------------------------------

- (CustomDate *) getYesterday {
    NSDate *yesterday = [DateHelper getDateBeforeDays:-1];
    NSString *yesterdayString = [self getDateRangeForDayString:yesterday];
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"Yesterday";
    customDate.dateValue = yesterday;
    customDate.dateString = yesterdayString;
    customDate.displayString = customDate.dateString;
    return customDate;
}

//---------------------------------------------------------------

- (CustomDate *) dayBeforeYesterday {
    NSDate *dayBeforeYesterday = [DateHelper getDateBeforeDays:-2];
    NSString *dayBeforeYesterdayString = [self getDateRangeForDayString:dayBeforeYesterday];
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"Day before yesterday";
    customDate.dateValue = dayBeforeYesterday;
    customDate.dateString = dayBeforeYesterdayString;
    customDate.displayString = customDate.dateString;
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

- (CustomDate *) getPreviousDay {
    NSDate *getPreviousDay = [DateHelper getDateBeforeDays:-1 forDate:self.dateValue];
    NSString *getPreviousDayString = [self getDateRangeForDayString:getPreviousDay];
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"Previous day";
    customDate.dateValue = getPreviousDay;
    customDate.dateString = getPreviousDayString;    
    customDate.displayString = customDate.dateString;
    return customDate;
}

//---------------------------------------------------------------

- (CustomDate *) getSameDayLastWeek {
    NSDate *sameDayLastWeek = [DateHelper getLastWeekDate:self.dateValue];
    NSString *sameDayLastWeekString = [self getDateRangeForDayString:sameDayLastWeek];
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"Same day last week";
    customDate.dateValue = sameDayLastWeek;
    customDate.dateString = sameDayLastWeekString;
    customDate.displayString = customDate.dateString;
    return customDate;
}

//---------------------------------------------------------------

- (CustomDate *) getSameDayLastYear {
    NSDate *sameDayLastYear = [DateHelper getLastYearDate:self.dateValue];
    NSString *sameDayLastYearString = [self getDateRangeForDayString:sameDayLastYear];
    CustomDate *customDate = [CustomDate new];
    customDate.title = @"Same day last year";
    customDate.dateValue = sameDayLastYear;
    customDate.dateString = sameDayLastYearString;
    customDate.displayString = customDate.dateString;
    return customDate;
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark Helper methods

//---------------------------------------------------------------

- (NSString *) getDateRangeForDayString:(NSDate *)date {
    // Check if Year is changed then set format that specify year in it
    NSString *dayFormat = ([DateHelper isCurrentYearSameWithDate:date]) ? DAY_FORMAT : RANGE_YEAR_FORMAT;
    
    // Create date range string
    NSDateFormatter *dateFormatter = [DateHelper systemDateFormatter];
    dateFormatter.dateFormat = dayFormat;
    return [dateFormatter stringFromDate:date];
}

//---------------------------------------------------------------

#pragma mark - Object Encoding/Decoding

//---------------------------------------------------------------

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.dateValue forKey:@"dateValue"];
    [aCoder encodeObject:self.compDateValue forKey:@"compDateValue"];
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
    self.compDateValue = [aDecoder decodeObjectForKey:@"compDateValue"];
    self.selectedDate = [aDecoder decodeObjectForKey:@"selectedDate"];
    self.selectedCompareDate = [aDecoder decodeObjectForKey:@"selectedCompareDate"];
    self.indexPath = [aDecoder decodeObjectForKey:@"indexPath"];
    self.compIndexPath = [aDecoder decodeObjectForKey:@"compIndexPath"];
    self.isShowCompareSwitch = [aDecoder decodeObjectForKey:@"isShowCompareSwitch"];
    return self;
}

//---------------------------------------------------------------

- (id)copyWithZone:(NSZone *)zone {
    DayModel *model = [DayModel new];
    model.dateValue = self.dateValue;
    model.compDateValue = self.compDateValue;
    model.selectedDate = self.selectedDate;
    model.selectedCompareDate = self.selectedCompareDate;
    model.indexPath = self.indexPath;
    model.compIndexPath = self.compIndexPath;
    model.isShowCompareSwitch = self.isShowCompareSwitch;
    return model;
}

//---------------------------------------------------------------

@end
