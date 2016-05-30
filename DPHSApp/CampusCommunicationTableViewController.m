//
//  CampusCommunicationTableViewController.m
//  DPHS App
//
//  Created by Will Oakley on 10/20/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import "CampusCommunicationTableViewController.h"
#import "CampusCommunicationTableViewCell.h"
#import <Parse/Parse.h>

@interface CampusCommunicationTableViewController ()

@end

@implementation CampusCommunicationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor blueColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(populateTable)
                  forControlEvents:UIControlEventValueChanged];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM d @ h:m a"];
    titleArray = [[NSMutableArray alloc] init];
    fromArray = [[NSMutableArray alloc] init];
    bodyTextArray = [[NSMutableArray alloc] init];
    timeArray = [[NSMutableArray alloc] init];
    [self populateTable];
}

-(void)populateTable {
    [titleArray removeAllObjects];
    [fromArray removeAllObjects];
    [bodyTextArray removeAllObjects];
    [timeArray removeAllObjects];
    PFQuery *query = [PFQuery queryWithClassName:@"CampusNote"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %lu announcements.", (unsigned long)objects.count);
            for (PFObject *object in objects) {
                [titleArray addObject:object[@"title"]];
                [fromArray addObject:object[@"from"]];
                [bodyTextArray addObject:object[@"bodyText"]];
                [timeArray addObject:[dateFormatter stringFromDate:object.createdAt]];
                [self.tableView reloadData];
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    [self.refreshControl endRefreshing];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [titleArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *CellIdentifier = @"announcementCell";
    
    CampusCommunicationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    long row = [indexPath row];
    
    cell.titleLabel.text = titleArray[row];
    cell.fromLabel.text = fromArray[row];
    cell.bodyTextLabel.text = bodyTextArray[row];
    cell.timeLabel.text = timeArray[row];

    
    return cell;
}



@end
