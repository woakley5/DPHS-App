//
//  ClassTableViewCell.m
//  DPHS App
//
//  Created by Will Oakley on 10/24/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import "ClassTableViewCell.h"

@implementation ClassTableViewCell

@synthesize className = _className;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
