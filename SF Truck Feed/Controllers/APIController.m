//
//  APIController.m
//  SF Truck Feed
//
//  Created by Richard Yeh on 5/30/19.
//  Copyright © 2019 Richard Yeh. All rights reserved.
//

#import "APIController.h"

NSString *dataUrl = @"https://data.sfgov.org/resource/jjew-r69b.json";

@implementation APIController

#pragma mark - API Fetch method

- (NSURLSessionDataTask *)downloadTaskWithCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))competionHandler
{
    NSString *callString = [NSString stringWithFormat:@"%@?dayofweekstr=%@", dataUrl, [self todayOfWeek]];
    
    return [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:callString]
                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                           if (competionHandler) {
                                               competionHandler(data, response, error);
                                           }
                                       }];
}

#pragma mark - Helper method

- (NSString *)todayOfWeek
{
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat: @"EEEE"];
    return [dayFormatter stringFromDate:[NSDate date]];
}

@end
