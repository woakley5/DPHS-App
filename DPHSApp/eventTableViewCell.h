//
//  eventTableViewCell.h
//  DPHS App
//
//  Created by Will Oakley on 10/26/14.
//  Copyright (c) 2014 Will Oakley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
@interface eventTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *opponentLabel;
@property (nonatomic, strong) IBOutlet UILabel *placeLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UILabel *homeScoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *awayScoreLabel;
@property (nonatomic, strong) IBOutlet PFImageView *schoolLogo;


@end
