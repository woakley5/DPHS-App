//
//  CampusCommunicationTableViewController.h
//  DPHS App
//
//  Created by Will Oakley on 10/20/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CampusCommunicationTableViewController : UITableViewController  {
    NSMutableArray *titleArray;
    NSMutableArray *fromArray;
    NSMutableArray *bodyTextArray;
    NSMutableArray *timeArray;
    
    NSDateFormatter *dateFormatter;
    
    NSInteger numberOfCells;
}


@end
