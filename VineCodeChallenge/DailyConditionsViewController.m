//
//  DailyConditionsViewController.m
//  VineCodeChallenge
//
//  Created by Ariel Scott-Dicker on 5/27/16.
//  Copyright © 2016 Ariel Scott-Dicker. All rights reserved.
//

#import "DailyConditionsViewController.h"

@interface DailyConditionsViewController () <WeatherDashboardViewControllerDelegate>

@end

@implementation DailyConditionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureConditionsLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)configureConditionsLabel {
    self.conditionsLabel = [UILabel new];
    [self.view addSubview:self.conditionsLabel];
    
    self.conditionsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.conditionsLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.conditionsLabel.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.conditionsLabel.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [self.conditionsLabel.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = YES;
    
    self.conditionsLabel.textAlignment = NSTextAlignmentCenter;
    self.conditionsLabel.text = @"---";
}

- (void)weatherDashboardViewController:(WeatherDashboardViewController *)weatherDashboardViewController
          didSelectDayForWeatherReport:(WeatherReport *)weatherReport {
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.conditionsLabel.text = weatherReport.summary;
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
