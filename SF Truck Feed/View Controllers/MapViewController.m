//
//  MapViewController.m
//  SF Truck Feed
//
//  Created by Richard Yeh on 5/30/19.
//  Copyright © 2019 Richard Yeh. All rights reserved.
//

#import "MapViewController.h"

#import "APIController.h"
#import "Truck.h"
#import "TruckTableViewCell.h"

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refresh];
}

- (void)refresh
{
    _trucks = @[];
    
    __weak typeof(self) weakSelf = self;
    self.downloadTask = [[APIController new] downloadTaskWithCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *jsonError = nil;
        
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            if (data) {
                NSArray<Truck *> *allTrucks = [Truck trucksFromJSON:data
                                                              error:&jsonError];
                strongSelf.trucks = [Truck openTrucks:allTrucks];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                });
            }
            strongSelf.downloadTask = nil;
        }
    }];
    
    [self.downloadTask resume];
}


@end
