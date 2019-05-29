//
//  ListViewController.h
//  SF Truck Feed
//
//  Created by Richard Yeh on 5/29/19.
//  Copyright © 2019 Richard Yeh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Truck;

@interface ListViewController : UITableViewController

@property NSArray<Truck *> *trucks;

@end
