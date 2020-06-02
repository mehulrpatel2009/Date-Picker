//
//  DatePreference.m
//  CustomDatePicker
//
//  Created by Mehul Patel on 24/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import "DatePreference.h"

@implementation DatePreference

//---------------------------------------------------------------

#pragma mark - Object Encoding/Decoding

//---------------------------------------------------------------

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.dayModel forKey:@"dayModel"];
    [aCoder encodeObject:self.weekModel forKey:@"weekModel"];
    [aCoder encodeObject:self.monthModel forKey:@"monthModel"];
    [aCoder encodeObject:self.rangeModel forKey:@"rangeModel"];
    [aCoder encodeObject:self.saveModel forKey:@"saveModel"];
    [aCoder encodeObject:self.viewType forKey:@"viewType"];
}

//---------------------------------------------------------------

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    self.viewType = [aDecoder decodeObjectForKey:@"viewType"];
    self.dayModel = [aDecoder decodeObjectForKey:@"dayModel"];
    self.weekModel = [aDecoder decodeObjectForKey:@"weekModel"];
    self.monthModel = [aDecoder decodeObjectForKey:@"monthModel"];
    self.rangeModel = [aDecoder decodeObjectForKey:@"rangeModel"];
    self.saveModel = [aDecoder decodeObjectForKey:@"saveModel"];
    self.viewType = [aDecoder decodeObjectForKey:@"viewType"];
    return self;
}

//---------------------------------------------------------------

- (id)copyWithZone:(NSZone *)zone {
    DatePreference *model = [DatePreference new];
    model.dayModel = self.dayModel;
    model.weekModel = self.weekModel;
    model.monthModel = self.monthModel;
    model.rangeModel = self.rangeModel;
    model.saveModel = self.saveModel;
    model.viewType = self.viewType;
    return model;
}

//---------------------------------------------------------------

@end
