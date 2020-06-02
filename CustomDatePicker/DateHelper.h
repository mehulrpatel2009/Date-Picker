//
//  DateHelper.h
//  CustomDatePicker
//
//  Created by Mehul Patel on 10/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateHelper : NSObject

+ (NSDateFormatter *) systemDateFormatter;

// Days
//+ (NSString *) getToday:(NSString *)format;
//+ (NSString *) getYesterday:(NSString *)format;
//+ (NSString *) getDayBeforeYesterday:(NSString *)format;
//+ (NSString *) getDayString:(NSString *)format forDay:(int)day;
+ (NSDate *) getDateBeforeDays:(int)days;
+ (NSDate *) getDateBeforeDays:(int)days forDate:(NSDate *)date;

// Week
+ (NSDate *) getFirstDayOfCurrentWeek;
+ (NSDate *) getLastDayOfCurrentWeek;
+ (NSDate *) getLastWeekDate:(NSDate *)forDate;
+ (NSDate *) getWeekDateForWeekNumber:(NSDate *)forDate weekNumber:(NSInteger)weekNumber;

// Month
+ (NSDate *) firstDateOfMonth:(NSDate *)date;
+ (NSDate *) lastDateOfMonth:(NSDate *)date;
+ (NSInteger) getMonthFromDate:(NSDate *)date;
+ (NSString *) getMonthNameString:(NSDate *)date;
+ (NSDate *) firstDateOfLastMonth:(NSDate *)date;
+ (NSDate *) lastDateOfLastMonth:(NSDate *)date;
+ (NSDate *) getDateForMonth:(NSInteger)month withDate:(NSDate *)date;

// Year
+ (NSInteger) getYearForDate:(NSDate *)date;
+ (NSString *) yearString:(NSDate *)date;
+ (BOOL) isCurrentYearSameWithDate:(NSDate *)date;
+ (NSDate *) getLastYearDate:(NSDate *)forDate;
+ (NSDate *) getDateForYear:(NSInteger)year withDate:(NSDate *)date;

@end
