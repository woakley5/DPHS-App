//
//  SeminarInfoTableViewController.m
//  DPHS App
//
//  Created by Will Oakley on 10/21/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import "SeminarInfoTableViewController.h"

@interface SeminarInfoTableViewController ()

@end

@implementation SeminarInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedRow = indexPath.row;
    [[NSUserDefaults standardUserDefaults] setInteger:selectedRow forKey:@"seminarSelectedRow"];
    selectedSection = indexPath.section;
    [[NSUserDefaults standardUserDefaults] setInteger:selectedSection forKey:@"seminarSelectedSection"];
    [self performSegueWithIdentifier:@"showSeminarWebView" sender:self];
}

@end
