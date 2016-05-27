//
//  ForecastAPIClient.h
//  VineCodeChallenge
//
//  Created by Ariel Scott-Dicker on 5/26/16.
//  Copyright © 2016 Ariel Scott-Dicker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ForecastAPIClient : NSObject

+ (void)getWeatherConditionsForLocation:(CLLocation *)location
                         WithCompletion:(void (^)(NSDictionary *weatherData))completionBlock;

@end
