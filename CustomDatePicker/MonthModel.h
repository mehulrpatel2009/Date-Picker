//
//  MonthModel.h
//  CustomDatePicker
//
//  Created by Mehul Patel on 11/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CustomDate.h"

@interface MonthModel : NSObject <NSCopying>

@property (nonatomic, strong) NSDate            *dateValue;
@property (nonatomic, strong) NSDate            *startDate;
@property (nonatomic, strong) NSDate            *endDate;
@property (nonatomic, strong) NSDate            *compStartDate;
@property (nonatomic, strong) NSDate            *compEndDate;
@property (nonatomic, strong) CustomDate        *selectedDate;
@property (nonatomic, strong) CustomDate        *selectedCompareDate;
@property (nonatomic, strong) NSIndexPath       *indexPath;
@property (nonatomic, strong) NSIndexPath       *compIndexPath;
@property (nonatomic, strong) NSNumber          *isShowCompareSwitch;

- (CustomDate *) getDateComponents:(NSIndexPath *)indexPath;
- (void) switchValueChanged:(NSNumber *)switchValue forIndexPath:(NSIndexPath *)indexPath;
- (NSInteger) getNumberOfRows:(NSInteger)section;

- (CustomDate *) getSelectedDate;
- (CustomDate *) getCompareSelectedCompareDate;
@end
