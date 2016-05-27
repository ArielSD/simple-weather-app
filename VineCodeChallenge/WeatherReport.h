//
//  WeatherReport.h
//  VineCodeChallenge
//
//  Created by Ariel Scott-Dicker on 5/27/16.
//  Copyright © 2016 Ariel Scott-Dicker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherReport : NSObject

@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *maximumTemperature;
@property (strong, nonatomic) NSString *minimumTemperature;
@property (strong, nonatomic) NSString *summary;

+ (instancetype)weatherReportFromDictionary:(NSDictionary *)dictionary;

- (NSString *)formatDate:(NSDate *)date;

@end
