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

- (void)viewDidLoad
{
    [self.detailTableView registerNib:[UINib nibWithNibName:@"TruckTableViewCell" bundle:nil]
               forCellReuseIdentifier:TruckTableViewCellIdentifier];
    self.detailTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.detailTableView.rowHeight = UITableViewAutomaticDimension;
    self.detailTableView.estimatedRowHeight = 92;
    self.detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
                    [strongSelf.mapView addAnnotations:strongSelf.trucks];
                    [strongSelf.mapView showAnnotations:strongSelf.trucks animated:NO];
                    
                });
            }
            strongSelf.downloadTask = nil;
        }
    }];
    
    [self.downloadTask resume];
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    self.selectedTruck = view.annotation;
    [self.detailTableView reloadData];
    self.detailTableView.hidden = NO;
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    self.selectedTruck = nil;
    self.detailTableView.hidden = YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TruckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TruckTableViewCellIdentifier];
    if (self.selectedTruck) {
        [cell populateWithTruck:self.selectedTruck];
    }
    return cell;
}

@end
