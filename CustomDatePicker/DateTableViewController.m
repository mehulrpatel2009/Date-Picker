//
//  DateTableViewController.m
//  CustomDatePicker
//
//  Created by Mehul Patel on 10/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import "DateTableViewController.h"
#import "DateValueCell.h"
#import "LSLDatePickerDialog.h"

@interface DateTableViewController () <UITableViewDelegate, UITableViewDataSource, JTMaterialSwitchDelegate>

@property (nonatomic, weak) IBOutlet UITableView            *tableView;
@property (nonatomic, strong) NSIndexPath                   *selectedIndexPath;
@property (nonatomic, strong) NSIndexPath                   *compSelectedIndexPath;

@property (nonatomic, strong) CustomDate                    *selectedDate;
@property (nonatomic, strong) NSDate                        *startDate;
@property (nonatomic, strong) NSDate                        *endDate;
@property (nonatomic, strong) NSNumber                      *month;
@property (nonatomic, strong) NSNumber                      *year;

@end

@implementation DateTableViewController

//---------------------------------------------------------------

#pragma mark
#pragma mark Memory management methods

//---------------------------------------------------------------

- (void) dealloc  {
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
}

//---------------------------------------------------------------

#pragma mark
#pragma mark Action methods

//---------------------------------------------------------------

//---------------------------------------------------------------

#pragma mark
#pragma mark Custom methods

//---------------------------------------------------------------

- (void) showDatePicker:(CustomDate *)customDate forIndex:(NSIndexPath *)indexPath {
    NSDate* currentDate = [NSDate dateWithTimeIntervalSinceNow:3600 * 24 * 7]; //One week from now
    
    NSDateComponents* dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = -3;
    NSDate* threeYearsAgo = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:currentDate options:0];
    
    LSLDatePickerDialog *dialog = [[LSLDatePickerDialog alloc] initWithTextColor:[UIColor blackColor] buttonColor:[UIColor blueColor] font:[UIFont fontWithName:@"AvenirNext-Medium" size:14] locale:nil cancelButton:YES];
    
    [dialog showWithTitle:customDate.title doneButtonTitle:@"OK" cancelButtonTitle:@"CANCEL" defaultDate:customDate.dateValue minimumDate:threeYearsAgo maximumDate:currentDate datePickerMode:UIDatePickerModeDate callback:^(NSDate * _Nullable date) {
        if (date) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterLongStyle];
            [formatter setTimeStyle:NSDateFormatterLongStyle];
            
            self.dateModel.rangeModel.dateValue = date;
            
            if (indexPath.section == 0) {
                switch (indexPath.row) {
                    case 0: self.dateModel.rangeModel.startDate = date; break;
                    case 1: self.dateModel.rangeModel.endDate = date; break;
                    default: break;
                }
            } else {
                switch (indexPath.row) {
                    case 0: self.dateModel.rangeModel.compStartDate = date; break;
                    case 1: self.dateModel.rangeModel.compEndDate = date; break;
                    default: break;
                }
            }
            [self.tableView reloadData];

            // Update date filters
            [self.delegate updateDateFilterModel:self.dateModel];
        }
    }];
}

//---------------------------------------------------------------

#pragma mark
#pragma mark UITableView datasource methods

//---------------------------------------------------------------

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

//---------------------------------------------------------------

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dateModel getNumberOfRows:section];
}

//---------------------------------------------------------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.0;
}

//---------------------------------------------------------------

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat footerHeight = 0.0;
    if (section == 0) {
        footerHeight = (self.dateModel.viewType.integerValue == DateViewTypeWeek) ? 20 : 0.0;
    }
    return footerHeight;
}

//---------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *formCellIdentifier = [NSString stringWithFormat:@"DateValueCell%d%d", (int)indexPath.section, (int)indexPath.row];
    
    DateValueCell *cell = (DateValueCell *)[tableView dequeueReusableCellWithIdentifier:formCellIdentifier];
    if (cell == nil) {
        cell = [[DateValueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:formCellIdentifier];
    }

    // Remove selection for custom range
    NSIndexPath *markedIndexPath = (indexPath.section == 0) ? self.selectedIndexPath : self.compSelectedIndexPath;
    if ([markedIndexPath isEqual:indexPath] && (self.dateModel.viewType.integerValue != DateViewTypeCustom)) {
        UIImageView *accessoryImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tick"]];
        accessoryImage.tintColor = [UIColor colorWithRed:19/255.0f green:35/255.0f blue:52/255.0f alpha:1];
        cell.accessoryView = accessoryImage;
    } else {
        cell.accessoryView = nil;
    }
    
    cell.compareSwitch.delegate = self;
    CustomDate *customDate = [self.dateModel getDateComponents:indexPath];
    cell.dateTitleLabel.text = customDate.title;
    cell.dateValueLabel.text = customDate.dateString;
    cell.compareSwitch.hidden = !customDate.isNonDateObject.boolValue;
    
    NSNumber *switchValue = [self.dateModel getSwitchValue];
    [cell.compareSwitch setOn:switchValue.boolValue animated:NO];
    
    return cell;
}

//---------------------------------------------------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomDate *customDate = [self.dateModel getDateComponents:indexPath];
    
    DateValueCell *cell = (DateValueCell *)[tableView cellForRowAtIndexPath:indexPath];

    //*** Note: Do not select Non Date Object!!!!
    if (customDate.isNonDateObject.boolValue) {
        [cell.compareSwitch setOn:![cell.compareSwitch getSwitchState] animated:YES];
        [self switchStateChanged:[cell.compareSwitch getSwitchState]];
        return;
    }
    
    // Custom date range
    if (self.dateModel.viewType.integerValue == DateViewTypeCustom) {
        // Open date picker
        [self showDatePicker:customDate forIndex:indexPath];
    } else {
        
        // Cell animation
        cell.transform = CGAffineTransformMakeScale(0.9, 0.9);
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {}];

        // Set indicator
        UIImageView *accessoryImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tick"]];
        accessoryImage.tintColor = [UIColor colorWithRed:19/255.0f green:35/255.0f blue:52/255.0f alpha:1];
        cell.accessoryView = accessoryImage;

        // Remove indicator from previous cell if any
        if (indexPath.section == 0) {
            if (self.selectedIndexPath) {
                DateValueCell *previousCell = (DateValueCell *)[tableView cellForRowAtIndexPath:self.selectedIndexPath];
                previousCell.accessoryView = nil;
                self.selectedIndexPath = indexPath;
            }
            
            switch (self.dateModel.viewType.integerValue) {
                case DateViewTypeDay: {
                    self.dateModel.dayModel.indexPath = indexPath;
                    self.dateModel.dayModel.dateValue = customDate.dateValue;
                    self.dateModel.dayModel.selectedDate = customDate;
                    break;
                }
                case DateViewTypeWeek: {
                    self.dateModel.weekModel.indexPath = indexPath;
                    self.dateModel.weekModel.startDate = customDate.startDate;
                    self.dateModel.weekModel.endDate = customDate.endDate;
                    break;
                }
                case DateViewTypeMonth: {
                    self.dateModel.monthModel.indexPath = indexPath;
                    self.dateModel.monthModel.startDate = customDate.startDate;
                    self.dateModel.monthModel.endDate = customDate.endDate;
                    self.dateModel.monthModel.dateValue = customDate.dateValue;
                    break;
                }
                case DateViewTypeCustom: {
                    self.dateModel.rangeModel.indexPath = indexPath;
                    self.dateModel.rangeModel.dateValue = customDate.dateValue;
                    self.dateModel.rangeModel.startDate = customDate.startDate;
                    self.dateModel.rangeModel.endDate = customDate.endDate;
                    break;
                }
                default:
                    break;
            }
        } else {
            if (self.compSelectedIndexPath) {
                DateValueCell *previousCell = (DateValueCell *)[tableView cellForRowAtIndexPath:self.compSelectedIndexPath];
                previousCell.accessoryView = nil;
                self.compSelectedIndexPath = indexPath;
            }
            
            switch (self.dateModel.viewType.integerValue) {
                case DateViewTypeDay: {
                    self.dateModel.dayModel.compIndexPath = indexPath;
                    self.dateModel.dayModel.compDateValue = customDate.dateValue;
                    self.dateModel.dayModel.selectedCompareDate = customDate;
                    break;
                }
                case DateViewTypeWeek: {
                    self.dateModel.weekModel.compIndexPath = indexPath;
                    self.dateModel.weekModel.compStartDate = customDate.startDate;
                    self.dateModel.weekModel.compEndDate = customDate.endDate;
                    break;
                }
                case DateViewTypeMonth: {
                    self.dateModel.monthModel.compIndexPath = indexPath;
                    self.dateModel.monthModel.compStartDate = customDate.startDate;
                    self.dateModel.monthModel.compEndDate = customDate.endDate;
                    break;
                }
                case DateViewTypeCustom: {
                    self.dateModel.rangeModel.compIndexPath = indexPath;
                    self.dateModel.rangeModel.compStartDate = customDate.startDate;
                    self.dateModel.rangeModel.compEndDate = customDate.endDate;
                    break;
                }
                default:
                    break;
            }
        }
        
        [self.tableView reloadData];
    }
    
    // Update date filters
    [self.delegate updateDateFilterModel:self.dateModel];
}

//---------------------------------------------------------------

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
    footerView.backgroundColor = [UIColor clearColor];
    footerView.tag = section;
    
    // User label
    UILabel *noteLabel = [[UILabel alloc] init];
    noteLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:10];
    noteLabel.numberOfLines = 0;
    noteLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    noteLabel.textAlignment = NSTextAlignmentRight;
    noteLabel.textColor = [UIColor grayColor];
    [noteLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [footerView addSubview:noteLabel];

    noteLabel.text = @"First day of the week - Sunday";
    // Card view constraints
    [footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[noteLabel]|" options: 0 metrics:nil views:@{@"noteLabel" : noteLabel}]];
    [footerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[noteLabel]|" options: 0 metrics:nil views:@{@"noteLabel" : noteLabel}]];
    return footerView;
}

//---------------------------------------------------------------

#pragma mark -
#pragma mark JTMaterialSwitchState methods

//---------------------------------------------------------------

- (void) switchStateChanged:(JTMaterialSwitchState)currentState {
    NSNumber *isShowCompareSwitch = (currentState == JTMaterialSwitchStateOn) ? [NSNumber numberWithBool:YES] : [NSNumber numberWithBool:NO];
    [self.dateModel switchValueChanged:isShowCompareSwitch forIndexPath:self.selectedIndexPath];
    [self.delegate updateDateFilterModel:self.dateModel];
    [self.tableView reloadData];
}

//---------------------------------------------------------------

#pragma mark
#pragma mark View lifeCycle methods

//---------------------------------------------------------------

- (void) viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
//    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.compSelectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    
    // Set indexPath if exist!
    self.selectedIndexPath = [self.dateModel getIndexPath] ? [self.dateModel getIndexPath] : self.selectedIndexPath;
    self.compSelectedIndexPath = [self.dateModel getCompareIndexPath] ? [self.dateModel getCompareIndexPath] : self.compSelectedIndexPath;
    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}


//---------------------------------------------------------------

@end
