//
//  Truck.h
//  SF Truck Feed
//
//  Created by Richard Yeh on 5/29/19.
//  Copyright © 2019 Richard Yeh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Truck : NSObject

@property (copy) NSString *applicant;
@property NSDate *endTimestamp;
@property (copy) NSString *endtime;
@property NSNumber *latitude;
@property (copy) NSString *location;
@property NSNumber *longitude;
@property (copy) NSString *optionaltext;
@property NSDate *startTimestamp;
@property (copy) NSString *starttime;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray<Truck *> *)trucksFromJSON:(NSData *)jsonData
                               error:(NSError **)error;

@end
