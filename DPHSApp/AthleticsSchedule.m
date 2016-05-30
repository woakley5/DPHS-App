//
//  AthleticsSchedule.m
//  DPHS App
//
//  Created by Will Oakley on 10/25/14.
//  Copyright (c) 2014 Will Oakley. All rights reserved.
//

#import "AthleticsSchedule.h"
#import "eventTableViewCell.h"
#import <Parse/Parse.h>

@interface AthleticsSchedule ()

@end

@implementation AthleticsSchedule

- (void)viewDidLoad {
    [super viewDidLoad];
    opponentArray = [[NSMutableArray alloc] init];
    placeArray = [[NSMutableArray alloc] init];
    dateArray = [[NSMutableArray alloc] init];
    timeArray = [[NSMutableArray alloc] init];
    homeScoreArray = [[NSMutableArray alloc] init];
    awayScoreArray = [[NSMutableArray alloc] init];
    objectIDValue = [[NSMutableArray alloc] init];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self populateTable];
}

- (void)populateTable{
    selectedRow = [[NSUserDefaults standardUserDefaults] integerForKey:@"athleticsSelectedRow"];
    selectedSection = [[NSUserDefaults standardUserDefaults] integerForKey:@"athleticsSelectedSection"];
    
    if (selectedSection == 0) {
        if (selectedRow == 0) {
            selectedSport = @"Football";
            viewTitle = @"Football";
        }
        if (selectedRow == 1) {
            selectedSport = @"CrossCountry";
            viewTitle = @"Cross Country";
        }
        if (selectedRow == 2) {
            selectedSport = @"BoysWaterPolo";
            viewTitle = @"Boys Water Polo";
        }
        if (selectedRow == 3) {
            selectedSport = @"GirlsVolleyball";
            viewTitle = @"Girls Volleyball";
        }
        if (selectedRow == 4) {
            selectedSport = @"GirlsTennis";
            viewTitle = @"Girls Tennis";
        }
        if (selectedRow == 5) {
            selectedSport = @"GirlsGolf";
            viewTitle = @"Girls Golf";
        }
    }
    if (selectedSection == 1) {
        if (selectedRow == 0) {
            selectedSport = @"BoysBasketball";
            viewTitle = @"Boys Basketball";
        }
        if (selectedRow == 1) {
            selectedSport = @"GirlsBasketball";
            viewTitle = @"Girls Basketball";
        }
        if (selectedRow == 2) {
            selectedSport = @"BoysSoccer";
            viewTitle = @"Boys Soccer";
        }
        if (selectedRow == 3) {
            selectedSport = @"GirlsSoccer";
            viewTitle = @"Girls Soccer";
        }
        if (selectedRow == 4) {
            selectedSport = @"GirlsWaterPolo";
            viewTitle = @"Girls Water Polo";
        }
        if (selectedRow == 5) {
            selectedSport = @"Wrestling";
            viewTitle = @"Wrestling";
        }
    }
    if (selectedSection == 2) {
        if (selectedRow == 0) {
            selectedSport = @"Baseball";
            viewTitle = @"Baseball";
        }
        if (selectedRow == 1) {
            selectedSport = @"Swim_Dive";
            viewTitle = @"Swim & Dive";
        }
        if (selectedRow == 2) {
            selectedSport = @"Track";
            viewTitle = @"Track & Field";
        }
        if (selectedRow == 3) {
            selectedSport = @"Softball";
            viewTitle = @"Softball";
        }
        if (selectedRow == 4) {
            selectedSport = @"BoysVolleyball";
            viewTitle = @"Boys Volleyball";
        }
        if (selectedRow == 5) {
            selectedSport = @"BoysTennis";
            viewTitle = @"Boys Tennis";
        }
        if (selectedRow == 6) {
            selectedSport = @"BoysGolf";
            viewTitle = @"Boys Golf";
        }
    }
    
    self.navigationItem.title = viewTitle;
    
    NSLog(@"Selected sport: %@",selectedSport);
    PFQuery *query = [PFQuery queryWithClassName:selectedSport];
    [query orderByAscending:@"GameNumber"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (!error) {
            numberOfCells = [array count];
            NSLog(@"Successfully retrieved %lu events.", numberOfCells);
            [self.tableView reloadData];
            for (PFObject *object in array) {
                [objectIDValue addObject:object.objectId];
                NSLog(@"%@", object.objectId);
                [opponentArray addObject:object[@"Opponent"]];
                [placeArray addObject:object[@"Place"]];
                [dateArray addObject:object[@"Date"]];
                [timeArray addObject:object[@"Time"]];
                [homeScoreArray addObject:object[@"HomeScore"]];
                [awayScoreArray addObject:object[@"AwayScore"]];
                
            }
            NSLog(@"Arrays - Opponent: %@  Place: %@  Date: %@  Time: %@", opponentArray, placeArray, dateArray, timeArray);
            NSLog(@"Object ID %@", objectIDValue);
        }
        else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numberOfCells;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"eventCell";
    
    eventTableViewCell *cell = [tableView
                              dequeueReusableCellWithIdentifier:CellIdentifier];
    long row = [indexPath row];

    cell.opponentLabel.text = opponentArray[row];
    cell.placeLabel.text = [NSString stringWithFormat:@"@ %@",placeArray[row]];
    cell.dateLabel.text = dateArray[row];
    cell.timeLabel.text = timeArray[row];
    cell.homeScoreLabel.text = homeScoreArray[row];
    cell.awayScoreLabel.text = awayScoreArray[row];
    
    PFQuery *imagequery = [PFQuery queryWithClassName:selectedSport];
    [imagequery getObjectInBackgroundWithId:objectIDValue[row] block:^(PFObject *imageObject, NSError *error) {
        PFFile *imageFile = [imageObject objectForKey:@"opponentLogo"];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                [cell.schoolLogo setImage:image];
            }
        }];
    }];
    

    return cell;
}




@end
