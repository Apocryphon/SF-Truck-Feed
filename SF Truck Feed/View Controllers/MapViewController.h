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

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property NSArray<Truck *> *trucks;
@property NSURLSessionDataTask *downloadTask;
@property UIView *detailsView;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
