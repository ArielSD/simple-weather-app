//
//  WeatherReport.m
//  VineCodeChallenge
//
//  Created by Ariel Scott-Dicker on 5/27/16.
//  Copyright © 2016 Ariel Scott-Dicker. All rights reserved.
//

#import "WeatherReport.h"

@implementation WeatherReport

+ (instancetype)weatherReportFromDictionary:(NSDictionary *)dictionary {
    WeatherReport *weatherReport = [WeatherReport new];
    
    NSNumber *unixTimeNumber = dictionary[@"time"];
    double unixTimeInterval = [unixTimeNumber doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:unixTimeInterval];
    NSString *dateString = [weatherReport formatDate:date];
    
    weatherReport.date = dateString;
    weatherReport.maximumTemperature = dictionary[@"temperatureMax"];
    weatherReport.minimumTemperature = dictionary[@"temperatureMin"];
    weatherReport.summary = dictionary[@"summary"];
    return weatherReport;
}

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

@end
