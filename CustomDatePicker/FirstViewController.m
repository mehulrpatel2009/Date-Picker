//
//  FirstViewController.m
//  CustomDatePicker
//
//  Created by Mehul Patel on 23/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import "FirstViewController.h"
#import "SlideViewController.h"

@interface FirstViewController () <HHSlideDelegate>

@property (nonatomic, weak) IBOutlet UILabel        *dateRangeLabel;
@property (nonatomic, weak) IBOutlet UILabel        *comparedateRangeLabel;

@property (nonatomic, strong) FilterDateModel       *dateModel;

@end

@implementation FirstViewController

//---------------------------------------------------------------

#pragma mark
#pragma mark Memory management methods

//---------------------------------------------------------------

- (void) dealloc  {
    
}

//---------------------------------------------------------------

#pragma mark
#pragma mark Action methods

//---------------------------------------------------------------


//---------------------------------------------------------------

#pragma mark
#pragma mark Custom methods

//---------------------------------------------------------------

//---------------------------------------------------------------

#pragma mark -
#pragma mark HHSlideDelegate methods

//---------------------------------------------------------------

- (void) changeDate:(DatePreference *)preference {

    CustomDate *customDate = [preference.saveModel getSelectedDate];
    self.dateRangeLabel.text = customDate.displayString;
    
    self.comparedateRangeLabel.hidden = YES;
    CustomDate *compareDate = [preference.saveModel getSelectedCompareDate];
    if ([preference.saveModel getSwitchValue].boolValue) {
        self.comparedateRangeLabel.hidden = NO;
        self.comparedateRangeLabel.text = [NSString stringWithFormat:@"vs. %@", compareDate.displayString];
    }
}

//---------------------------------------------------------------

#pragma mark
#pragma mark View lifeCycle methods

//---------------------------------------------------------------

- (void) viewDidLoad {
    [super viewDidLoad];
    FilterDateModel *model = [FilterDateModel new];
    model.viewType = [NSNumber numberWithInteger:DateViewTypeDay];
    model.dayModel = [DayModel new];
    model.dayModel.dateValue = [NSDate date];
    self.dateModel = model;
}

//---------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDateSelection"]) {
        SlideViewController *controller = (SlideViewController *)segue.destinationViewController;
        controller.delegate = self;
        controller.dateModel = self.dateModel;
    }
}

//---------------------------------------------------------------

@end
