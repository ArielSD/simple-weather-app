//
//  DailyConditionsViewController.h
//  VineCodeChallenge
//
//  Created by Ariel Scott-Dicker on 5/27/16.
//  Copyright © 2016 Ariel Scott-Dicker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherDashboardViewController.h"

@interface DailyConditionsViewController : UIViewController

@property (strong, nonatomic) UILabel *conditionsLabel;

- (void)configureConditionsLabel;

@end
