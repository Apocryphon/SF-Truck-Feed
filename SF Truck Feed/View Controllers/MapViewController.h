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

@interface MapViewController : UIViewController <MKMapViewDelegate, UITableViewDelegate>

@property NSArray<Truck *> *trucks;
@property NSURLSessionDataTask *downloadTask;
@property Truck *selectedTruck;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;

@end
