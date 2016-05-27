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
    [self configureMaximumTemperatureLabel];
    [self configureMinimumTemperatureLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)configureConditionsLabel {
    self.conditionsLabel = [UILabel new];
    [self.view addSubview:self.conditionsLabel];
    
    self.conditionsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.conditionsLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.conditionsLabel.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    
    self.conditionsLabel.textAlignment = NSTextAlignmentCenter;
    self.conditionsLabel.text = @"---";
}

- (void)configureMaximumTemperatureLabel {
    self.maximumTemperatureLabel = [UILabel new];
    [self.view addSubview:self.maximumTemperatureLabel];
    
    self.maximumTemperatureLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.maximumTemperatureLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.maximumTemperatureLabel.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.maximumTemperatureLabel.topAnchor constraintEqualToAnchor:self.conditionsLabel.bottomAnchor].active = YES;
    
    self.maximumTemperatureLabel.textAlignment = NSTextAlignmentCenter;
    self.maximumTemperatureLabel.text = @"High: ---";
}

- (void)configureMinimumTemperatureLabel {
    self.minimumTemperatureLabel = [UILabel new];
    [self.view addSubview:self.minimumTemperatureLabel];
    
    self.minimumTemperatureLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.minimumTemperatureLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.minimumTemperatureLabel.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.minimumTemperatureLabel.topAnchor constraintEqualToAnchor:self.maximumTemperatureLabel.bottomAnchor].active = YES;
    
    self.minimumTemperatureLabel.textAlignment = NSTextAlignmentCenter;
    self.minimumTemperatureLabel.text = @"Low: ---";
}

- (void)weatherDashboardViewController:(WeatherDashboardViewController *)weatherDashboardViewController
          didSelectDayForWeatherReport:(WeatherReport *)weatherReport {
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.conditionsLabel.text = weatherReport.summary;
        self.maximumTemperatureLabel.text = [NSString stringWithFormat:@"High: %@", weatherReport.maximumTemperature];
        self.minimumTemperatureLabel.text = [NSString stringWithFormat:@"Low: %@", weatherReport.minimumTemperature];
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
