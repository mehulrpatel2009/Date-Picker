//
//  SlideViewController.h
//  InGauge
//
//  Created by Mehul Patel on 10/01/18.
//  Copyright © 2017 FPG Pulse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterDateModel.h"
#import "DatePreference.h"

@protocol HHSlideDelegate <NSObject>

- (void) changeDate:(DatePreference *)preference;

@end

@interface SlideViewController : UIViewController

@property (nonatomic, weak) id<HHSlideDelegate>             delegate;
@property (nonatomic, strong) FilterDateModel               *dateModel;

@end
