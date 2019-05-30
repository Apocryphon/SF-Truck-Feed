//
//  APIController.h
//  SF Truck Feed
//
//  Created by Richard Yeh on 5/30/19.
//  Copyright © 2019 Richard Yeh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIController : NSObject

- (NSURLSessionDataTask *)downloadTaskWithCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))competionHandler;

@end
