//
//  NEOClassViewController.h
//  DPHS App
//
//  Created by Will Oakley on 10/24/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KAProgressLabel.h"
#import "AssignmentTableViewCell.h"
#import "ZAActivityBar.h"

@interface NEOClassViewController : UIViewController <UITableViewDataSource> {
    NSString *className;
    NSNumber *classID;
    NSNumber *overallGradePercent;
    NSString *overallGradeLetter;
    NSArray *assignmentsDataArray;
    NSMutableArray *dataArray;
    NSMutableDictionary *classDataDictionary;
    NSString *apiKey;
    NSNumber *userID;
    NSURLConnection *classAssignmentsConnection;
    NSMutableData *NEOAPIData;


}

@property (weak, nonatomic) IBOutlet KAProgressLabel *gradeProgressCircle;
@property (strong, nonatomic) IBOutlet UITableView *assignmentTable;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (weak, nonatomic) IBOutlet UILabel *letterLabel;

@end
