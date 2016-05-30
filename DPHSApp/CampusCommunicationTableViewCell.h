//
//  CampusCommunicationTableViewCell.h
//  DPHS App
//
//  Created by Will Oakley on 10/20/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CampusCommunicationTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *fromLabel;
@property (nonatomic, strong) IBOutlet UILabel *bodyTextLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;

@end
