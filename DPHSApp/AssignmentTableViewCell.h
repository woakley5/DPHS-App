//
//  AssignmentTableViewCell.h
//  DPHS App
//
//  Created by Will Oakley on 11/1/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssignmentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *assignmentName;
@property (weak, nonatomic) IBOutlet UILabel *assignmentGrade;

@end
