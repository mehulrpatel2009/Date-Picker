//
//  SlideViewController.m
//  InGauge
//
//  Created by Mehul Patel on 10/01/18.
//  Copyright © 2017 FPG Pulse. All rights reserved.
//

#import "SlideViewController.h"
#import "DateTableViewController.h"
#import "DateHelper.h"
#import "CarbonKit.h"

#define SlideBar_Height 50

#define DAY_FORMAT              @"EEEE, dd MMM"
#define WEEK_FORMAT             @"dd MMM"
#define MONTH_FORMAT            @"MMMM"
#define YEAR_FORMAT             @"dd MMM yyyy"

#define DATE_ID                 6000

@interface SlideViewController () <CarbonTabSwipeNavigationDelegate, DateTableDelegate>

@property (nonatomic, strong) CarbonTabSwipeNavigation  *carbonTabSwipeNavigation;
@property (nonatomic, strong) FilterDateModel           *dayModel;
@property (nonatomic, strong) FilterDateModel           *weekModel;
@property (nonatomic, strong) FilterDateModel           *monthModel;
@property (nonatomic, strong) FilterDateModel           *rangeModel;
@property (nonatomic, strong) DatePreference            *datePreference;

@property (nonatomic, strong) NSArray                   *controllerArray;
@property (nonatomic, strong) NSArray                   *items;
@property (nonatomic, strong) NSNumber                  *switchStatus;
@property (nonatomic, assign) NSInteger                 dateId;
@end

@implementation SlideViewController

//---------------------------------------------------------------

#pragma mark -
#pragma mark Memory management methods

//---------------------------------------------------------------

- (void) dealloc {
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark Action methods

//---------------------------------------------------------------

- (IBAction) cancelButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//---------------------------------------------------------------

- (IBAction) saveButtonTapped:(id)sender {
    switch ([self.carbonTabSwipeNavigation currentTabIndex]) {
        case 0: {
            self.datePreference.dayModel = self.dayModel;
            self.datePreference.saveModel = self.dayModel;
            break;
        }
        case 1: {
            self.datePreference.weekModel = self.weekModel;
            self.datePreference.saveModel = self.weekModel;
            break;
        }
        case 2: {
            self.datePreference.monthModel = self.monthModel;
            self.datePreference.saveModel = self.monthModel;
            break;
        }
        case 3: {
            self.datePreference.rangeModel = self.rangeModel;
            self.datePreference.saveModel = self.rangeModel;
            break;
        }
        default: break;
    }
    
    self.datePreference.viewType = [NSNumber numberWithInteger:[self.carbonTabSwipeNavigation currentTabIndex]];
    [self saveCustomObject:self.datePreference key:@"DatePreference"];
    [self.delegate changeDate:self.datePreference];
    [self.navigationController popViewControllerAnimated:YES];
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark Custom methods

//---------------------------------------------------------------

- (void) style {
    UIColor *color = [UIColor colorWithRed:19/255.0f green:35/255.0f blue:52/255.0f alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    self.carbonTabSwipeNavigation.toolbar.translucent = NO;
//    self.carbonTabSwipeNavigation.toolbar.backgroundColor = color;
    [self.carbonTabSwipeNavigation setTabExtraWidth:30];
    [self.carbonTabSwipeNavigation setTabBarHeight:55.0];
    self.carbonTabSwipeNavigation.carbonTabSwipeScrollView.backgroundColor = color;
    [self.carbonTabSwipeNavigation.carbonSegmentedControl setBackgroundColor:[UIColor clearColor]];
    
    // Indicator settings
    [self.carbonTabSwipeNavigation setIndicatorColor:[UIColor whiteColor]];
    [self.carbonTabSwipeNavigation setIndicatorHeight:2.0];
    
    // Custimize segmented control
    [self.carbonTabSwipeNavigation setNormalColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6]
                                             font:[UIFont fontWithName:@"AvenirNext-Medium" size:14]];
    [self.carbonTabSwipeNavigation setSelectedColor:color font:[UIFont fontWithName:@"AvenirNext-Medium" size:14]];
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark Preference methods

//---------------------------------------------------------------

//- (void) storeDateSettingsToPreference:(DatePreference *)datePreference {
//    [[NSUserDefaults standardUserDefaults] setObject:datePreference forKey:@"DatePreference"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}

- (void) saveCustomObject:(id)object key:(NSString *)key {
    NSData *data = nil;
    if (object == nil) {
        data = nil;
    } else {
        data = [NSKeyedArchiver archivedDataWithRootObject:object];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:key];
    [defaults synchronize];
}

//---------------------------------------------------------------

- (id) customObjectWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark Date utility methods

//---------------------------------------------------------------

- (FilterDateModel *) getDayModel {
    FilterDateModel *model = [FilterDateModel new];
    model.viewType = [NSNumber numberWithInteger:DateViewTypeDay];
    model.dayModel = [DayModel new];
    model.dayModel.isShowCompareSwitch = self.switchStatus;
    model.dayModel.dateValue = [NSDate date];
    model.dayModel.selectedDate = [model.dayModel getDateComponents:[NSIndexPath indexPathForRow:0 inSection:0]];
    model.dayModel.selectedCompareDate = [model.dayModel getDateComponents:[NSIndexPath indexPathForRow:0 inSection:1]];
    return model;
}

//---------------------------------------------------------------

- (FilterDateModel *) getWeekModel {
    FilterDateModel *model = [FilterDateModel new];
    model.viewType = [NSNumber numberWithInteger:DateViewTypeWeek];
    model.weekModel = [WeekModel new];
    model.weekModel.isShowCompareSwitch = self.switchStatus;
    model.weekModel.dateValue = [NSDate date];
    model.weekModel.startDate = [NSDate date];
    model.weekModel.endDate = [NSDate date];
    return model;
}

//---------------------------------------------------------------

- (FilterDateModel *) getMonthModel {
    FilterDateModel *model = [FilterDateModel new];
    model.viewType = [NSNumber numberWithInteger:DateViewTypeMonth];
    model.monthModel = [MonthModel new];
    model.monthModel.isShowCompareSwitch = self.switchStatus;
    model.monthModel.dateValue = [NSDate date];
    model.monthModel.startDate = [NSDate date];
    model.monthModel.endDate = [NSDate date];
    return model;
}

//---------------------------------------------------------------

- (FilterDateModel *) getRangeDatesModel {
    FilterDateModel *model = [FilterDateModel new];
    model.viewType = [NSNumber numberWithInteger:DateViewTypeCustom];
    model.rangeModel = [RangeModel new];
    model.rangeModel.isShowCompareSwitch = self.switchStatus;
    model.rangeModel.dateValue = [NSDate date];
    model.rangeModel.startDate = [NSDate date];
    model.rangeModel.endDate = [NSDate date];
    model.rangeModel.compStartDate = [NSDate date];
    model.rangeModel.compEndDate = [NSDate date];
    return model;
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark DateModelDelegate methods

//---------------------------------------------------------------

- (void) updateDateFilterModel:(FilterDateModel *)dateModel {
    self.dateModel = dateModel;
    switch (dateModel.viewType.integerValue) {
        case DateViewTypeDay: self.dayModel = dateModel; break;
        case DateViewTypeWeek: self.weekModel = dateModel; break;
        case DateViewTypeMonth: self.monthModel = dateModel; break;
        case DateViewTypeCustom: self.rangeModel = dateModel; break;
        default: break;
    }
    
    self.datePreference.dayModel = self.dayModel;
    self.datePreference.weekModel = self.weekModel;
    self.datePreference.monthModel = self.monthModel;
    self.datePreference.rangeModel = self.rangeModel;
    
    [self saveCustomObject:self.datePreference key:@"DatePreference"];
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark CarbonTabSwipeNavigation Delegate methods

// required
- (nonnull UIViewController *)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbontTabSwipeNavigation viewControllerAtIndex:(NSUInteger)index {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DateTableViewController *controller = nil;
    switch (index) {
        case 0: {
            DateTableViewController *dayViewController = (DateTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"DateTableViewController"];
            dayViewController.delegate = self;
            dayViewController.dateModel = self.dayModel;
            controller = dayViewController;
            break;
        }
        case 1: {
            DateTableViewController *weekViewController = (DateTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"DateTableViewController"];
            weekViewController.delegate = self;
            weekViewController.dateModel = self.weekModel;
            controller = weekViewController;
            break;
        }
        case 2: {
            DateTableViewController *monthViewController = (DateTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"DateTableViewController"];
            monthViewController.delegate = self;
            monthViewController.dateModel = self.monthModel;
            controller = monthViewController;
            break;
        }
        case 3: {
            DateTableViewController *customViewController = (DateTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"DateTableViewController"];
            customViewController.delegate = self;
            customViewController.dateModel = self.rangeModel;
            controller = customViewController;
            break;
        }
        default: controller = nil; break;
    }
    return controller;
}

//---------------------------------------------------------------

// optional
- (void)carbonTabSwipeNavigation:(CarbonTabSwipeNavigation *)carbonTabSwipeNavigation willMoveAtIndex:(NSUInteger)index {
    self.title = self.items[index];
}

//---------------------------------------------------------------

- (void)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                  didMoveAtIndex:(NSUInteger)index {
}

//---------------------------------------------------------------

- (UIBarPosition)barPositionForCarbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation {
    return UIBarPositionTop; // default UIBarPositionTop
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark Life Cycle methods

//---------------------------------------------------------------

- (void) viewDidLoad {
    [super viewDidLoad];
    self.dateId = DATE_ID;
    self.switchStatus = [NSNumber numberWithBool:NO];

    self.dayModel = [self getDayModel];
    self.weekModel = [self getWeekModel];
    self.monthModel = [self getMonthModel];
    self.rangeModel = [self getRangeDatesModel];
    
    
    self.datePreference = [self customObjectWithKey:@"DatePreference"];
    if (self.datePreference) {
        self.dayModel = self.datePreference.dayModel ? self.datePreference.dayModel : self.dayModel;
        self.weekModel = self.datePreference.weekModel ? self.datePreference.weekModel : self.weekModel;
        self.monthModel = self.datePreference.monthModel ? self.datePreference.monthModel : self.monthModel;
        self.rangeModel = self.datePreference.rangeModel ? self.datePreference.rangeModel : self.rangeModel;
    } else {
        _datePreference = [DatePreference new];
    }
    
    _items = [[NSArray alloc] initWithObjects:@"DAY", @"WEEK", @"MONTH", @"CUSTOM",nil];
    // Add tabs
    _carbonTabSwipeNavigation = [[CarbonTabSwipeNavigation alloc] initWithItems:self.items delegate:self];
    [self.carbonTabSwipeNavigation insertIntoRootViewController:self];
    [self style];
    
    // Update tab
    [self.carbonTabSwipeNavigation setCurrentTabIndex:self.datePreference.viewType.integerValue withAnimation:YES];
}

//---------------------------------------------------------------

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

//---------------------------------------------------------------

@end
