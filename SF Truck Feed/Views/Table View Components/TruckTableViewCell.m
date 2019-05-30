//
//  TruckTableViewCell.m
//  SF Truck Feed
//
//  Created by Richard Yeh on 5/29/19.
//  Copyright © 2019 Richard Yeh. All rights reserved.
//

#import "TruckTableViewCell.h"

#import "Truck.h"

NSString *const TruckTableViewCellIdentifier = @"TruckTableViewCellIdentifier";

@implementation TruckTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)populateWithTruck:(Truck *)truck
{
    self.nameLabel.text         = truck.applicant;
    self.addressLabel.text      = truck.location;
    self.descriptionLabel.text  = truck.optionaltext;
    self.openingHoursLabel.text = [NSString stringWithFormat:@"%@ - %@", truck.starttime, truck.endtime];
}

@end
