//
//  DateValueCell.h
//  CustomDatePicker
//
//  Created by Mehul Patel on 10/01/18.
//  Copyright © 2018 Synoverge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTMaterialSwitch/JTMaterialSwitch.h>

@interface DateValueCell : UITableViewCell

@property (nonatomic, strong) UIView                *cardView;
@property (nonatomic, strong) UILabel               *dateTitleLabel;
@property (nonatomic, strong) UILabel               *dateValueLabel;
@property (nonatomic, strong) JTMaterialSwitch      *compareSwitch;

@end
