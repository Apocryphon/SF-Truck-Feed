//
//  Truck.m
//  SF Truck Feed
//
//  Created by Richard Yeh on 5/29/19.
//  Copyright © 2019 Richard Yeh. All rights reserved.
//

#import "Truck.h"

@implementation Truck

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        self.applicant = dictionary[@"applicant"];
        self.endTimestamp = [self dateFromTimestamp:dictionary[@"end24"]];
        self.endtime = dictionary[@"endtime"];
        self.latitude = dictionary[@"latitude"];
        self.location = dictionary[@"location"];
        self.longitude = dictionary[@"longitude"];
        self.optionaltext = dictionary[@"optionaltext"];
        self.startTimestamp = [self dateFromTimestamp:dictionary[@"start24"]];
        self.starttime = dictionary[@"starttime"];
    }

    return self;
}

- (NSDate *)dateFromTimestamp:(NSString *)timestamp
{
    NSString *hour      = [[timestamp componentsSeparatedByString:@":"] firstObject];
    NSString *minute    = [[timestamp componentsSeparatedByString:@":"] lastObject];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    return [calendar dateBySettingHour:hour.integerValue
                                minute:minute.integerValue
                                second:0
                                ofDate:[NSDate date]
                               options:0];
}

#pragma mark - Deserialization method

+ (NSArray<Truck *> *)trucksFromJSON:(NSData *)jsonData
                               error:(NSError **)error
{
    NSError *localError = nil;
    NSArray<NSDictionary *> *parsedArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                           options:0
                                                                             error:&localError];

    if (localError != nil) {
        *error = localError;
        return nil;
    }

    NSMutableArray *trucks = [NSMutableArray new];
    for (NSDictionary *truckDictionary in parsedArray) {
        Truck *truck = [[Truck alloc] initWithDictionary:truckDictionary];
        [trucks addObject:truck];
    }

    [trucks sortUsingComparator:^NSComparisonResult(Truck *truck1, Truck *truck2) {
        return [truck1.applicant localizedCaseInsensitiveCompare:truck2.applicant];
    }];

    return trucks;
}

+ (NSArray<Truck *> *)openTrucks:(NSArray *)trucks
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"HH:mm";
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *testDate = [calendar dateBySettingHour:9
                                            minute:30
                                            second:0
                                            ofDate:[NSDate date]
                                           options:0];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(startTimestamp <= %@) AND (endTimestamp >= %@)", testDate, testDate];
    
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(startTimestamp <= %@) AND (endTimestamp >= %@)", [NSDate date], [NSDate date]];
    
    return [trucks filteredArrayUsingPredicate:predicate];
}

#pragma mark - MKAnnotation

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.latitude.doubleValue, self.longitude.doubleValue);
}

@end
