//
//  ListViewController.m
//  SF Truck Feed
//
//  Created by Richard Yeh on 5/29/19.
//  Copyright © 2019 Richard Yeh. All rights reserved.
//

#import "ListViewController.h"

#import "APIController.h"
#import "Truck.h"
#import "TruckTableViewCell.h"

@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TruckTableViewCell" bundle:nil]
         forCellReuseIdentifier:TruckTableViewCellIdentifier];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refresh];
}

#pragma mark - Load

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
                    [strongSelf.tableView reloadData];
                });
            }
            strongSelf.downloadTask = nil;
        }
    }];

    [self.downloadTask resume];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.trucks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TruckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TruckTableViewCellIdentifier];
    [cell populateWithTruck:[self.trucks objectAtIndex:indexPath.row]];
    return cell;
}

@end
