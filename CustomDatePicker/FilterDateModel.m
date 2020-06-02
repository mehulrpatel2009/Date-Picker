//
//  FilterDateModel.m
//  CustomDatePicker
//
//  Created by Mehul Patel on 10/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import "FilterDateModel.h"

@implementation FilterDateModel

//---------------------------------------------------------------

#pragma mark -
#pragma mark Getter methods

//---------------------------------------------------------------

- (NSInteger) getNumberOfRows:(NSInteger)section {
    switch (self.viewType.integerValue) {
        case DateViewTypeDay:       return [self.dayModel getNumberOfRows:section];     break;
        case DateViewTypeWeek:      return [self.weekModel getNumberOfRows:section];    break;
        case DateViewTypeMonth:     return [self.monthModel getNumberOfRows:section];   break;
        case DateViewTypeCustom:    return [self.rangeModel getNumberOfRows:section];   break;
        default: return 0; break;
    }
}

//---------------------------------------------------------------

- (NSNumber *) getSwitchValue {
    switch (self.viewType.integerValue) {
        case DateViewTypeDay:       return self.dayModel.isShowCompareSwitch;     break;
        case DateViewTypeWeek:      return self.weekModel.isShowCompareSwitch;    break;
        case DateViewTypeMonth:     return self.monthModel.isShowCompareSwitch;   break;
        case DateViewTypeCustom:    return self.rangeModel.isShowCompareSwitch;   break;
        default: return 0; break;
    }
}

//---------------------------------------------------------------

- (CustomDate *) getDateComponents:(NSIndexPath *)indexPath {
    switch (self.viewType.integerValue) {
        case DateViewTypeDay:       return [self.dayModel getDateComponents:indexPath];     break;
        case DateViewTypeWeek:      return [self.weekModel getDateComponents:indexPath];    break;
        case DateViewTypeMonth:     return [self.monthModel getDateComponents:indexPath];   break;
        case DateViewTypeCustom:    return [self.rangeModel getDateComponents:indexPath];   break;
        default: return 0; break;
    }
}

//---------------------------------------------------------------

- (CustomDate *) getSelectedDate {
    switch (self.viewType.integerValue) {
        case DateViewTypeDay:       return [self.dayModel getSelectedDate];         break;
        case DateViewTypeWeek:      return [self.weekModel getSelectedDate];        break;
        case DateViewTypeMonth:     return [self.monthModel getSelectedDate];       break;
        case DateViewTypeCustom:    return self.rangeModel.selectedDate;            break;
        default: return 0; break;
    }
}

//---------------------------------------------------------------

- (CustomDate *) getSelectedCompareDate {
    switch (self.viewType.integerValue) {
        case DateViewTypeDay:       return [self.dayModel getCompareSelectedCompareDate];   break;
        case DateViewTypeWeek:      return [self.weekModel getCompareSelectedCompareDate];  break;
        case DateViewTypeMonth:     return [self.monthModel getCompareSelectedCompareDate]; break;
        case DateViewTypeCustom:    return self.rangeModel.selectedCompareDate;             break;
        default: return 0; break;
    }
}

//---------------------------------------------------------------

- (NSIndexPath *) getIndexPath {
    switch (self.viewType.integerValue) {
        case DateViewTypeDay:       return self.dayModel.indexPath;   break;
        case DateViewTypeWeek:      return self.weekModel.indexPath;  break;
        case DateViewTypeMonth:     return self.monthModel.indexPath; break;
        case DateViewTypeCustom:    return self.rangeModel.indexPath; break;
        default: return 0; break;
    }
}

//---------------------------------------------------------------

- (NSIndexPath *) getCompareIndexPath {
    switch (self.viewType.integerValue) {
        case DateViewTypeDay:       return self.dayModel.compIndexPath;   break;
        case DateViewTypeWeek:      return self.weekModel.compIndexPath;  break;
        case DateViewTypeMonth:     return self.monthModel.compIndexPath; break;
        case DateViewTypeCustom:    return self.rangeModel.compIndexPath; break;
        default: return 0; break;
    }
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark Setter methods

//---------------------------------------------------------------

- (void) switchValueChanged:(NSNumber *)switchValue forIndexPath:(NSIndexPath *)indexPath {
    switch (self.viewType.integerValue) {
        case DateViewTypeDay:     [self.dayModel switchValueChanged:switchValue forIndexPath:indexPath];    break;
        case DateViewTypeWeek:    [self.weekModel switchValueChanged:switchValue forIndexPath:indexPath];   break;
        case DateViewTypeMonth:   [self.monthModel switchValueChanged:switchValue forIndexPath:indexPath];  break;
        case DateViewTypeCustom:  [self.rangeModel switchValueChanged:switchValue forIndexPath:indexPath];  break;
        default: break;
    }
}

//---------------------------------------------------------------

#pragma mark - Object Encoding/Decoding

//---------------------------------------------------------------

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.viewType forKey:@"viewType"];
    [aCoder encodeObject:self.dayModel forKey:@"dayModel"];
    [aCoder encodeObject:self.weekModel forKey:@"weekModel"];
    [aCoder encodeObject:self.monthModel forKey:@"monthModel"];
    [aCoder encodeObject:self.rangeModel forKey:@"rangeModel"];
}

//---------------------------------------------------------------

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    self.viewType = [aDecoder decodeObjectForKey:@"viewType"];
    self.dayModel = [aDecoder decodeObjectForKey:@"dayModel"];
    self.weekModel = [aDecoder decodeObjectForKey:@"weekModel"];
    self.monthModel = [aDecoder decodeObjectForKey:@"monthModel"];
    self.rangeModel = [aDecoder decodeObjectForKey:@"rangeModel"];
    return self;
}

//---------------------------------------------------------------

- (id)copyWithZone:(NSZone *)zone {
    FilterDateModel *model = [FilterDateModel new];
    model.viewType = self.viewType;
    model.dayModel = self.dayModel;
    model.weekModel = self.weekModel;
    model.monthModel = self.monthModel;
    model.rangeModel = self.rangeModel;
    return model;
}

//---------------------------------------------------------------

@end
