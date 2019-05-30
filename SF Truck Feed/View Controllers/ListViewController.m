//
//  ListViewController.m
//  SF Truck Feed
//
//  Created by Richard Yeh on 5/29/19.
//  Copyright © 2019 Richard Yeh. All rights reserved.
//

#import "ListViewController.h"

#import "Truck.h"
#import "TruckTableViewCell.h"

@interface ListViewController ()

@end

NSString *dataUrl = @"https://data.sfgov.org/resource/jjew-r69b.json";

@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.topItem.title = NSLocalizedString(@"Food Trucks", @"Food Trucks");


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

- (NSString *)todayOfWeek
{
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat: @"EEEE"];
    return [dayFormatter stringFromDate:[NSDate date]];
}

- (NSArray<Truck *> *)openTrucks
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"HH:mm";
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *testDate = [calendar dateBySettingHour:9
                                             minute:30
                                             second:0
                                             ofDate:[NSDate date]
                                            options:0];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(startTimestamp <= %@) AND (endTimestamp >= %@)", testDate, testDate];
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(startTimestamp <= %@) AND (endTimestamp >= %@)", [NSDate date], [NSDate date]];

    return [self.trucks filteredArrayUsingPredicate:predicate];
}

#pragma mark - Load

- (void)refresh
{
    _trucks = @[];

    NSString *callString = [NSString stringWithFormat:@"%@?dayofweekstr=%@", dataUrl, [self todayOfWeek]];

    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:callString]
                                                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                         NSError *jsonError = nil;

                                                                         typeof(self) strongSelf = weakSelf;
                                                                         if (strongSelf) {
                                                                             if (data) {
                                                                                 strongSelf.trucks = [Truck trucksFromJSON:data
                                                                                                                     error:&jsonError];
                                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                                     [strongSelf.tableView reloadData];
                                                                                 });
                                                                             }
                                                                         }
                                          }];

    [downloadTask resume];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.openTrucks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TruckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TruckTableViewCellIdentifier];
    [cell populateWithTruck:[[self openTrucks] objectAtIndex:indexPath.row]];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
