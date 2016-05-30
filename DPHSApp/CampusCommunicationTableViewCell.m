//
//  CampusCommunicationTableViewCell.m
//  DPHS App
//
//  Created by Will Oakley on 10/20/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import "CampusCommunicationTableViewCell.h"

@implementation CampusCommunicationTableViewCell

@synthesize titleLabel = _titleLabel;
@synthesize fromLabel = _fromLabel;
@synthesize bodyTextLabel = _bodyTextLabel;
@synthesize timeLabel = _timeLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
