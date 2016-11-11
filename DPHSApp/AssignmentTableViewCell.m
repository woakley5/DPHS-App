//
//  AssignmentTableViewCell.m
//  DPHS App
//
//  Created by Will Oakley on 11/1/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import "AssignmentTableViewCell.h"

@implementation AssignmentTableViewCell

@synthesize assignmentGrade = _assignmentGrade;
@synthesize assignmentName = _assignmentName;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
