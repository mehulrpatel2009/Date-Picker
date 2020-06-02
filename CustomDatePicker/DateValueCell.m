//
//  DateValueCell.m
//  CustomDatePicker
//
//  Created by Mehul Patel on 10/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import "DateValueCell.h"

@implementation DateValueCell

//---------------------------------------------------------------

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tick"]];
    
    _cardView = [[UIView alloc] init];
    self.cardView.translatesAutoresizingMaskIntoConstraints = NO;
    self.cardView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.cardView];
    
    // Card view constraints
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[cardView]|" options: 0 metrics:nil views:@{@"cardView" : self.cardView}]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[cardView]|" options: 0 metrics:nil views:@{@"cardView" : self.cardView}]];
    
    // Date title label
    _dateTitleLabel = [[UILabel alloc] init];
    self.dateTitleLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:14];
    self.dateTitleLabel.numberOfLines = 0;
    self.dateTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.dateTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.dateTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.cardView addSubview:self.dateTitleLabel];
    
    // Date value label
    _dateValueLabel = [[UILabel alloc] init];
    self.dateValueLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:13];
    self.dateValueLabel.numberOfLines = 0;
    self.dateValueLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.dateValueLabel.textAlignment = NSTextAlignmentLeft;
    self.dateValueLabel.textColor = [UIColor grayColor];
    [self.dateValueLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.cardView addSubview:self.dateValueLabel];
    
    // Compare switch
    _compareSwitch = [[JTMaterialSwitch alloc] initWithSize:JTMaterialSwitchSizeSmall state:JTMaterialSwitchStateOff];
    self.compareSwitch.thumbOnTintColor = [UIColor colorWithRed:19/255.0f green:35/255.0f blue:52/255.0f alpha:1];
    self.compareSwitch.trackOnTintColor = [UIColor colorWithRed:60/255.0f green:78/255.0f blue:91/255.0f alpha:1];
    self.compareSwitch.rippleFillColor = [UIColor colorWithRed:19/255.0f green:35/255.0f blue:52/255.0f alpha:1];
    
    [self.cardView addSubview:self.compareSwitch];
    
    // Constraints
    NSDictionary *views = @{@"dateTitleLabel" : self.dateTitleLabel, @"dateValueLabel" : self.dateValueLabel, @"compareSwitch" : self.compareSwitch};
    
    [self.cardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[dateTitleLabel]-15-|" options: 0 metrics:nil views:views]];
    [self.cardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[dateValueLabel]-15-|" options: 0 metrics:nil views:views]];

    [self.cardView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[dateTitleLabel]-1-[dateValueLabel]-15-|" options: 0 metrics:nil views:views]];
    
    // Add bottom line
    [self addBottomLine:self withColor:[UIColor colorWithRed:232.0/255.0 green:234.0/255.0 blue:235.0/255.0 alpha:1.0]];
    return self;
}

//---------------------------------------------------------------

- (void) addBottomLine:(UIView *)view withColor:(UIColor *)color {
    // Add line
    UIView *lineView = [[UIView alloc] init];
    [lineView setBackgroundColor:color];
    [lineView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [view addSubview:lineView];
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[lineView]|" options: 0 metrics:nil views:@{@"lineView" : lineView}]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lineView(2)]|" options: 0 metrics:nil views:@{@"lineView" : lineView}]];
}

//---------------------------------------------------------------

- (void) layoutSubviews {
    [super layoutSubviews];
    
    // Compare switch frame
    CGFloat marginX = self.contentView.bounds.size.width - 40;
    CGFloat marginY = 20;
    
    CGRect frame = self.compareSwitch.frame;
    frame.origin.x = marginX;
    frame.origin.y = marginY;
    self.compareSwitch.frame = frame;
}

//---------------------------------------------------------------


@end
