//
//  AthleticsSchedule.h
//  DPHS App
//
//  Created by Will Oakley on 10/25/14.
//  Copyright (c) 2014 Will Oakley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AthleticsSchedule : UITableViewController{
    NSInteger numberOfCells;
    NSInteger selectedRow;
    NSInteger selectedSection;
    NSString *selectedSport;
    NSString *viewTitle;
    NSMutableArray *objectIDValue;
    
    NSMutableArray *opponentArray;
    NSMutableArray *placeArray;
    NSMutableArray *timeArray;
    NSMutableArray *dateArray;
    NSMutableArray *homeScoreArray;
    NSMutableArray *awayScoreArray;
    NSMutableArray *opponentLogos;
}



@end
