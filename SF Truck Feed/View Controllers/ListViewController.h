//
//  ListViewController.h
//  SF Truck Feed
//
//  Created by Richard Yeh on 5/29/19.
//  Copyright © 2019 Richard Yeh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Truck;

@interface ListViewController : UIViewController

@property NSArray<Truck *> *trucks;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end
