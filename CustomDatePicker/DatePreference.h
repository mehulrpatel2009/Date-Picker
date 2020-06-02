//
//  DatePreference.h
//  CustomDatePicker
//
//  Created by Mehul Patel on 24/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FilterDateModel.h"

@interface DatePreference : NSObject <NSCopying>

@property (nonatomic, strong) FilterDateModel       *dayModel;
@property (nonatomic, strong) FilterDateModel       *weekModel;
@property (nonatomic, strong) FilterDateModel       *monthModel;
@property (nonatomic, strong) FilterDateModel       *rangeModel;
@property (nonatomic, strong) FilterDateModel       *saveModel;

@property (nonatomic, strong) NSNumber              *viewType;

@end
