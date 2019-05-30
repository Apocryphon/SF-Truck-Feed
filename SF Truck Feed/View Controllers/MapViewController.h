//
//  MapViewController.h
//  SF Truck Feed
//
//  Created by Richard Yeh on 5/30/19.
//  Copyright © 2019 Richard Yeh. All rights reserved.
//

#import <UIKit/UIKit.h>

@import MapKit;

@class Truck;
@class TruckTableViewCell;

@interface MapViewController : UIViewController

@property NSArray<Truck *> *trucks;
@property NSURLSessionDataTask *downloadTask;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet TruckTableViewCell *truckDetailsCell;

@end
