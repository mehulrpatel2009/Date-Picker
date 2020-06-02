//
//  CustomDate.m
//  CustomDatePicker
//
//  Created by Mehul Patel on 10/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import "CustomDate.h"

@implementation CustomDate

//---------------------------------------------------------------

#pragma mark - Object Encoding/Decoding

//---------------------------------------------------------------

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.customDateId forKey:@"customDateId"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.displayString forKey:@"displayString"];
    [aCoder encodeObject:self.dateString forKey:@"dateString"];
    [aCoder encodeObject:self.dateValue forKey:@"dateValue"];
    [aCoder encodeObject:self.startDate forKey:@"startDate"];
    [aCoder encodeObject:self.endDate forKey:@"endDate"];
    [aCoder encodeObject:self.compStartDate forKey:@"compStartDate"];
    [aCoder encodeObject:self.compEndDate forKey:@"compEndDate"];
    [aCoder encodeObject:self.month forKey:@"month"];
    [aCoder encodeObject:self.year forKey:@"year"];
    [aCoder encodeObject:self.isNonDateObject forKey:@"isNonDateObject"];
}

//---------------------------------------------------------------

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    self.customDateId = [aDecoder decodeObjectForKey:@"customDateId"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.displayString = [aDecoder decodeObjectForKey:@"displayString"];
    self.dateString = [aDecoder decodeObjectForKey:@"dateString"];
    self.dateValue = [aDecoder decodeObjectForKey:@"dateValue"];
    self.startDate = [aDecoder decodeObjectForKey:@"startDate"];
    self.endDate = [aDecoder decodeObjectForKey:@"endDate"];
    self.compStartDate = [aDecoder decodeObjectForKey:@"compStartDate"];
    self.compEndDate = [aDecoder decodeObjectForKey:@"compEndDate"];
    self.month = [aDecoder decodeObjectForKey:@"month"];
    self.year = [aDecoder decodeObjectForKey:@"year"];
    self.isNonDateObject = [aDecoder decodeObjectForKey:@"isNonDateObject"];
    return self;
}

//---------------------------------------------------------------

- (id)copyWithZone:(NSZone *)zone {
    CustomDate *customDate = [CustomDate new];
    customDate.customDateId = self.customDateId;
    customDate.title = self.title;
    customDate.displayString = self.displayString;
    customDate.dateString = self.dateString;
    customDate.dateValue = self.dateValue;
    customDate.startDate = self.startDate;
    customDate.endDate = self.endDate;
    customDate.compStartDate = self.compStartDate;
    customDate.compEndDate = self.compEndDate;
    customDate.month = self.month;
    customDate.year = self.year;
    customDate.isNonDateObject = self.isNonDateObject;
    return customDate;
}

//---------------------------------------------------------------

@end
