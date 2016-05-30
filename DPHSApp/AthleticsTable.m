//
//  AthleticsTable.m
//  DPHS App
//
//  Created by Will Oakley on 10/25/14.
//  Copyright (c) 2014 Will Oakley. All rights reserved.
//

#import "AthleticsTable.h"

@interface AthleticsTable ()

@end

@implementation AthleticsTable

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected at section: %li row: %li", (long)indexPath.section, (long)indexPath.row);
    selectedRow = indexPath.row;
    [[NSUserDefaults standardUserDefaults] setInteger:selectedRow forKey:@"athleticsSelectedRow"];
    selectedSection = indexPath.section;
    [[NSUserDefaults standardUserDefaults] setInteger:selectedSection forKey:@"athleticsSelectedSection"];
    [self performSegueWithIdentifier:@"showAthleticsSchedule" sender:self];
}

@end
