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
@property (strong, nonatomic) NSNumber *maximumTemperature;
@property (strong, nonatomic) NSNumber *minimumTemperature;
@property (strong, nonatomic) NSString *summary;

+ (instancetype)weatherReportFromDictionary:(NSDictionary *)dictionary;

- (NSString *)formatDate:(NSDate *)date;

@end
