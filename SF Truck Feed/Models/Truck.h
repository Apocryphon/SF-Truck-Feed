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
@property (copy) NSString *end24;
@property (copy) NSString *endtime;
@property NSNumber *latitude;
@property (copy) NSString *location;
@property NSNumber *longitude;
@property (copy) NSString *optionaltext;
@property (copy) NSString *start24;
@property (copy) NSString *starttime;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray<Truck *> *)trucksFromJSON:(NSData *)jsonData
                               error:(NSError **)error;

@end
