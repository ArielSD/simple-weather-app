//
//  ForecastAPIClient.m
//  VineCodeChallenge
//
//  Created by Ariel Scott-Dicker on 5/26/16.
//  Copyright © 2016 Ariel Scott-Dicker. All rights reserved.
//

#import "ForecastAPIClient.h"
#import "Secrets.h"

@implementation ForecastAPIClient

+ (void)getWeatherConditionsForLocation:(CLLocation *)location
                         WithCompletion:(void (^)(NSDictionary *weatherData))completionBlock {
    
    NSString *forecastURLString = [NSString stringWithFormat:@"https://api.forecast.io/forecast/%@/%f,%f", ForecastAPIKey,location.coordinate.latitude, location.coordinate.longitude];
    NSURL *url = [NSURL URLWithString:forecastURLString];
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *urlSessionDataTask = [urlSession dataTaskWithURL:url
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                             NSDictionary *weatherData = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                         options:0
                                                                                                                           error:nil];
                                                             completionBlock(weatherData);
                                                         }];
    [urlSessionDataTask resume];
}

@end
