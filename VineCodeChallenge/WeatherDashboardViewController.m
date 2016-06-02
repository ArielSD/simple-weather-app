//
//  WeatherDashboardViewController.m
//  VineCodeChallenge
//
//  Created by Ariel Scott-Dicker on 5/26/16.
//  Copyright © 2016 Ariel Scott-Dicker. All rights reserved.
//

#import "WeatherDashboardViewController.h"

@interface WeatherDashboardViewController ()

@end

@implementation WeatherDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableView];
    [self configureCurrentWeatherLabel];
    [self configureCurrentConditionsTextView];
    [self configureRefreshButton];
    [self configureEnableLocationServicesLabel];
    [self configureLocationManager];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.weeklyForecastArray = [NSMutableArray new];
}

- (void)viewWillAppear:(BOOL)animated {
    if ([CLLocationManager authorizationStatus] == 4) {
        [self.locationManager startUpdatingLocation];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Layout

- (void)configureTableView {
    self.weatherTableView = [UITableView new];
    [self.view addSubview:self.weatherTableView];
    
    self.weatherTableView.dataSource = self;
    self.weatherTableView.delegate = self;
    
    [self.weatherTableView registerClass:[UITableViewCell class]
                  forCellReuseIdentifier:@"weatherCell"];
    
    self.weatherTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.weatherTableView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.weatherTableView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.weatherTableView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor
                                                        constant:self.view.frame.size.height / 4].active = YES;
    [self.weatherTableView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor
                                                       multiplier:0.5].active = YES;
}

- (void)configureCurrentWeatherLabel {
    self.currentWeatherLabel = [UILabel new];
    [self.view addSubview:self.currentWeatherLabel];
    
    self.currentWeatherLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.currentWeatherLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.currentWeatherLabel.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.currentWeatherLabel.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor
                                                         constant:-(self.view.frame.size.height) / 4].active = YES;
    
    self.currentWeatherLabel.textAlignment = NSTextAlignmentCenter;
    self.currentWeatherLabel.text = @"---";
}

- (void)configureCurrentConditionsTextView {
    self.currentConditionsTextView = [UITextView new];
    [self.view addSubview:self.currentConditionsTextView];
    
    self.currentConditionsTextView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.currentConditionsTextView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.currentConditionsTextView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.currentConditionsTextView.topAnchor constraintEqualToAnchor:self.currentWeatherLabel.bottomAnchor].active = YES;
    [self.currentConditionsTextView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor
                                                              multiplier:0.2].active = YES;
    
    self.currentConditionsTextView.textAlignment = NSTextAlignmentCenter;
    self.currentConditionsTextView.editable = NO;
    self.currentConditionsTextView.text = @"---";
}

- (void)configureRefreshButton {
    self.refreshButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:self.refreshButton];
    
    self.refreshButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.refreshButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.refreshButton.bottomAnchor constraintEqualToAnchor:self.weatherTableView.topAnchor].active = YES;
    
    [self.refreshButton setTitle:@"Refresh"
                        forState:UIControlStateNormal];
    
    [self.refreshButton addTarget:self
                           action:@selector(locationManager:didChangeAuthorizationStatus:)
                 forControlEvents:UIControlEventTouchUpInside];
}

- (void)configureEnableLocationServicesLabel {
    self.enableLocationServicesLabel = [UILabel new];
    [self.view addSubview:self.enableLocationServicesLabel];
    
    self.enableLocationServicesLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.enableLocationServicesLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.enableLocationServicesLabel.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.enableLocationServicesLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor
                                                               constant:(self.view.frame.size.height) / 8].active = YES;
    
    self.enableLocationServicesLabel.textAlignment = NSTextAlignmentCenter;
    self.enableLocationServicesLabel.textColor = [UIColor redColor];
    self.enableLocationServicesLabel.text = @"Please Enable Location Services!";
    self.enableLocationServicesLabel.hidden = YES;
}

- (void)configureLocationManager {
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter = 1000;
    [self.locationManager requestWhenInUseAuthorization];
}

#pragma mark - CLLocationMangerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *mostRecentLocation = [locations lastObject];
    NSDate *locationCaptureTime = mostRecentLocation.timestamp;
    NSTimeInterval timeSinceLocationCapture = [locationCaptureTime timeIntervalSinceNow];
    
    if (timeSinceLocationCapture <= 20) {
        self.currentLocation = mostRecentLocation;
        [self getWeatherOfCurrentLocation];
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if ([CLLocationManager authorizationStatus] == 4) {
        [self.locationManager startUpdatingLocation];
        self.enableLocationServicesLabel.hidden = YES;
        self.refreshButton.enabled = YES;
    }
    else {
        self.enableLocationServicesLabel.hidden = NO;
        self.refreshButton.enabled = NO;
    }
}

#pragma mark - Network Calls

- (void)getWeatherOfCurrentLocation {
    [ForecastAPIClient getWeatherConditionsForLocation:self.currentLocation
                                        WithCompletion:^(NSDictionary *weatherData) {
                                            NSArray *weeklyForecast = weatherData[@"daily"][@"data"];
                                            
                                            if (self.weeklyForecastArray.count == 0) {
                                                for (NSDictionary *day in weeklyForecast) {
                                                    WeatherReport *weatherReport = [WeatherReport weatherReportFromDictionary:day];
                                                    [self.weeklyForecastArray addObject:weatherReport];
                                                }
                                                [self.weeklyForecastArray removeObjectAtIndex:0];
                                            }
                                            
                                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                self.currentWeatherLabel.text = [NSString stringWithFormat:@"Current Temperature: %.2f", [weatherData[@"currently"][@"temperature"] doubleValue]];
                                                self.currentConditionsTextView.text = [NSString stringWithFormat:@"%@", weatherData[@"currently"][@"summary"]];
                                                [self.weatherTableView reloadData];
                                            }];
                                        }];
}

#pragma mark - Table View Delegate / Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.weeklyForecastArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                   reuseIdentifier:@"weatherCell"];
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"weatherCell"
                                           forIndexPath:indexPath];
    
    WeatherReport *weatherReportAtRow = self.weeklyForecastArray[indexPath.row];
    
    cell.textLabel.text = weatherReportAtRow.date;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WeatherReport *weatherReportAtSelectedRow = self.weeklyForecastArray[indexPath.row];
    DailyConditionsViewController *dailyConditionsViewController = [DailyConditionsViewController new];
    
    self.delegate = (id <WeatherDashboardViewControllerDelegate>)dailyConditionsViewController;
    
    [self.delegate weatherDashboardViewController:self
                     didSelectDayForWeatherReport:weatherReportAtSelectedRow];
    
    [self.navigationController pushViewController:dailyConditionsViewController
                                         animated:YES];
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
