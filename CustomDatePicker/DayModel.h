//
//  DayModel.h
//  CustomDatePicker
//
//  Created by Mehul Patel on 11/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CustomDate.h"

@interface DayModel : NSObject <NSCopying>

@property (nonatomic, strong) NSDate            *dateValue;
@property (nonatomic, strong) NSDate            *compDateValue;
@property (nonatomic, strong) CustomDate        *selectedDate;
@property (nonatomic, strong) CustomDate        *selectedCompareDate;
@property (nonatomic, strong) NSIndexPath       *indexPath;
@property (nonatomic, strong) NSIndexPath       *compIndexPath;
@property (nonatomic, strong) NSNumber          *isShowCompareSwitch;

- (CustomDate *) getDateComponents:(NSIndexPath *)indexPath;
//- (CustomDate *) getSelectedDateComponents:(BOOL)isCompare;
- (void) switchValueChanged:(NSNumber *)switchValue forIndexPath:(NSIndexPath *)indexPath;
- (NSInteger) getNumberOfRows:(NSInteger)section;

- (CustomDate *) getSelectedDate;
- (CustomDate *) getCompareSelectedCompareDate;
@end
