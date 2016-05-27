//
//  WeatherDashboardViewController.h
//  VineCodeChallenge
//
//  Created by Ariel Scott-Dicker on 5/26/16.
//  Copyright © 2016 Ariel Scott-Dicker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ForecastAPIClient.h"
#import "DailyConditionsViewController.h"
#import "WeatherReport.h"

@class WeatherDashboardViewController;

@protocol WeatherDashboardViewControllerDelegate <NSObject>

@required

- (void)weatherDashboardViewController:(WeatherDashboardViewController *)weatherDashboardViewController
          didSelectDayForWeatherReport:(WeatherReport *)weatherReport;

@end

@interface WeatherDashboardViewController : UIViewController <CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) id <WeatherDashboardViewControllerDelegate> delegate;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) NSMutableArray *weeklyForecastArray;

@property (strong, nonatomic) UILabel *currentWeatherLabel;
@property (strong, nonatomic) UITextView *currentConditionsTextView;
@property (strong, nonatomic) UITableView *weatherTableView;
@property (strong, nonatomic) UIButton *refreshButton;
@property (strong, nonatomic) UILabel *enableLocationServicesLabel;

- (void)configureTableView;
- (void)configureCurrentWeatherLabel;
- (void)configureCurrentConditionsTextView;
- (void)configureRefreshButton;
- (void)configureEnableLocationServicesLabel;
- (void)configureLocationManager;

- (void)getWeatherOfCurrentLocation;

@end
