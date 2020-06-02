//
//  DateTableViewController.h
//  CustomDatePicker
//
//  Created by Mehul Patel on 10/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterDateModel.h"

@protocol  DateTableDelegate <NSObject>

- (void) updateDateFilterModel:(FilterDateModel *)dateModel;

@end

@interface DateTableViewController : UIViewController

@property (nonatomic, weak) id<DateTableDelegate>   delegate;
@property (nonatomic, strong) FilterDateModel       *dateModel;

@end
