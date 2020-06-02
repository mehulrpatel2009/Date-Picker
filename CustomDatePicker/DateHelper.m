//
//  DateHelper.m
//  CustomDatePicker
//
//  Created by Mehul Patel on 10/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import "DateHelper.h"

@implementation DateHelper

//---------------------------------------------------------------

#pragma mark -
#pragma mark Days methods

//---------------------------------------------------------------

//+ (NSString *) getToday:(NSString *)format {
//    NSDateFormatter *dateFormatter = [self systemDateFormatter];
//    [dateFormatter setDateFormat:format];
//    NSString *dateFromString = [dateFormatter stringFromDate:[NSDate date]];
//    return dateFromString;
//}
//
////---------------------------------------------------------------
//
//+ (NSString *) getYesterday:(NSString *)format {
//    NSDateFormatter *dateFormatter = [self systemDateFormatter];
//    [dateFormatter setDateFormat:format];
//
//    // Get yesterday
//    NSString *dateFromString = [dateFormatter stringFromDate:[self getDateBeforeDays:-1]];
//    return dateFromString;
//}
//
////---------------------------------------------------------------
//
//+ (NSString *) getDayBeforeYesterday:(NSString *)format {
//    NSDateFormatter *dateFormatter = [self systemDateFormatter];
//    [dateFormatter setDateFormat:format];
//    
//    // Get yesterday
//    NSString *dateFromString = [dateFormatter stringFromDate:[self getDateBeforeDays:-2]];
//    return dateFromString;
//}
//
////---------------------------------------------------------------
//
//+ (NSString *) getDayString:(NSString *)format forDay:(int)day {
//    NSDateFormatter *dateFormatter = [self systemDateFormatter];
//    [dateFormatter setDateFormat:format];
//    
//    // Get yesterday
//    NSString *dateFromString = [dateFormatter stringFromDate:[self getDateBeforeDays:day]];
//    return dateFromString;
//}

//---------------------------------------------------------------

+ (NSDate *) getDateBeforeDays:(int)days {
    // Get calendar
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    NSDateComponents *comps = [cal components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    NSDate *today = [cal dateFromComponents:comps];
    
    // Get components
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    NSDate *resultDate = [cal dateByAddingComponents:components toDate:today options:0];
    return resultDate;
}

//---------------------------------------------------------------

+ (NSDate *) getDateBeforeDays:(int)days forDate:(NSDate *)date {
    // Get calendar
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    NSDate *today = [cal dateFromComponents:comps];
    
    // Get components
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    NSDate *resultDate = [cal dateByAddingComponents:components toDate:today options:0];
    return resultDate;
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark Week methods

//---------------------------------------------------------------

+ (NSDate *) getFirstDayOfCurrentWeek {
    // Week Start Date
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *components = [gregorian components: NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    
    // This will give you current day of week
    NSInteger dayOfWeek = [[gregorian components:NSCalendarUnitWeekday fromDate:[NSDate date]] weekday];
   
    // for beginning of the week
    [components setDay:([components day] - ((dayOfWeek) - 1))];
    // In above statement 1 defines the day number for week start
    // Sunday = 1, Saturday = 7

    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    return beginningOfWeek;
}

//---------------------------------------------------------------

+ (NSDate *) getLastDayOfCurrentWeek {
    // Week Start Date
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *components = [gregorian components: NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    
    // This will give you end day of week
    NSInteger endDayOfWeek = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]] weekday];
    
    // for end day of the week
    [components setDay:([components day] + (7 - endDayOfWeek))];
    
    NSDate *endDateOfWeek = [gregorian dateFromComponents:components];
    return endDateOfWeek;
}

//---------------------------------------------------------------

+ (NSDate *) getLastWeekDate:(NSDate *)forDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfMonth:-1];
    return [calendar dateByAddingComponents:components toDate:forDate options:0];
}


//---------------------------------------------------------------

+ (NSDate *) getWeekDateForWeekNumber:(NSDate *)forDate weekNumber:(NSInteger)weekNumber {
    NSDateComponents *comp = [NSDateComponents new];
    int numberOfDaysInAWeek = 7;
    comp.day = weekNumber * numberOfDaysInAWeek;
    return [[NSCalendar currentCalendar] dateByAddingComponents:comp toDate:forDate options:0];
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark Month methods

//---------------------------------------------------------------

+ (NSDate *) firstDateOfMonth:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth) fromDate:date];
    components.day = 1;
    NSDate *dayOneInCurrentMonth = [[NSCalendar currentCalendar] dateFromComponents:components];
    return dayOneInCurrentMonth;
}

//---------------------------------------------------------------

+ (NSDate *) lastDateOfMonth:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfMonth|NSCalendarUnitWeekday fromDate:date]; // Get necessary date components
    // set last of month
    [comps setMonth:[comps month] + 1];
    [comps setDay:0];
    NSDate *tDateMonth = [calendar dateFromComponents:comps];
    return tDateMonth;
}

//---------------------------------------------------------------

+ (NSInteger) getMonthFromDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    return [components month]; //gives you month
}

//---------------------------------------------------------------

+ (NSString *) getMonthNameString:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    [dateFormatter setDateFormat:@"MMMM"];
    return [dateFormatter stringFromDate:date];
}

//---------------------------------------------------------------

+ (NSDate *) firstDateOfLastMonth:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    components.month = components.month - 1;
    components.day = 1;
    NSDate *resultDate = [calendar dateFromComponents:components];
    return [self firstDateOfMonth:resultDate];
}

//---------------------------------------------------------------

+ (NSDate *) lastDateOfLastMonth:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    components.month = components.month - 1;
    components.day = 1;
    NSDate *resultDate = [calendar dateFromComponents:components];
    return [self lastDateOfMonth:resultDate];
}

//---------------------------------------------------------------

+ (NSDate *) getDateForMonth:(NSInteger)month withDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:month];
    NSDate *resultDate = [calendar dateByAddingComponents:offsetComponents toDate:date options:0];
    return resultDate;
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark Year methods

//---------------------------------------------------------------

+ (NSInteger) getYearForDate:(NSDate *)date {
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    return [gregorian component:NSCalendarUnitYear fromDate:date];
}

//---------------------------------------------------------------

+ (NSString *) yearString:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    [dateFormatter setDateFormat:@"yyyy"];
    return [dateFormatter stringFromDate:date];
}

//---------------------------------------------------------------

+ (BOOL) isCurrentYearSameWithDate:(NSDate *)date {
    // Get current year
    NSInteger currentYear = [self getYearForDate:[NSDate date]];
    NSInteger lastDateYear = [self getYearForDate:date];
    return (currentYear == lastDateYear);
}

//---------------------------------------------------------------

+ (NSDate *) getLastYearDate:(NSDate *)forDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:-1];
    return [calendar dateByAddingComponents:components toDate:forDate options:0];
}

//---------------------------------------------------------------

+ (NSDate *) getDateForYear:(NSInteger)year withDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:year];
    NSDate *resultDate = [calendar dateByAddingComponents:offsetComponents toDate:date options:0];
    return resultDate;
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark Common methods

//---------------------------------------------------------------

+ (NSDateFormatter *) systemDateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *sourceTimeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:sourceTimeZone];
    return dateFormatter;
}

//---------------------------------------------------------------

@end
