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
    TruckTableViewCell *detailCell = (TruckTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"TruckTableViewCell" owner:self options:nil] firstObject];
    [detailCell populateWithTruck:view.annotation];

    self.detailsView = detailCell.contentView;
    self.detailsView.backgroundColor = [UIColor whiteColor];
    self.detailsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.detailsView];

    [self.detailsView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [self.detailsView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [self.detailsView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    [self.detailsView removeFromSuperview];
    self.detailsView = nil;
}

@end
