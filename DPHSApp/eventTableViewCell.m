//
//  eventTableViewCell.m
//  DPHS App
//
//  Created by Will Oakley on 10/26/14.
//  Copyright (c) 2014 Will Oakley. All rights reserved.
//

#import "eventTableViewCell.h"

@implementation eventTableViewCell

@synthesize opponentLabel = _opponentLabel;
@synthesize placeLabel = _placeLabel;
@synthesize dateLabel = _dateLabel;
@synthesize timeLabel = _timeLabel;
@synthesize homeScoreLabel = _homeScoreLabel;
@synthesize awayScoreLabel = _awayScoreLabel;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
