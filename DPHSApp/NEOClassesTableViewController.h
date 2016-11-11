//
//  NEOClassesTableViewController.h
//  DPHS App
//
//  Created by Will Oakley on 10/24/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassTableViewCell.h"
#import "ZAActivityBar.h"

@interface NEOClassesTableViewController : UITableViewController <UITableViewDelegate> {
    NSMutableData *NEOAPIData;
    NSMutableArray *classDataID;
    NSMutableArray *classDataName;
    NSString *apiKey;
    NSNumber *userID;
    NSMutableArray *classGradesLetterArray;
    NSMutableArray *classGradesPercentageArray;
    NSMutableArray *classIDArray;
    NSMutableArray *classNamesArray;
    NSMutableArray *assignmentsInfoArray;
    NSURLConnection *classIDConnection;
    NSURLConnection *classNameConnection;
    int connectionCounter;
}
- (IBAction)pressedLogOut:(id)sender;

@end
