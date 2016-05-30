//
//  RPViewController.m
//  RPSlidingMenuDemo
//
//  Created by Paul Thorsteinson on 2/24/2014.
//  Copyright (c) 2014 Robots and Pencils Inc. All rights reserved.
//

#import "RPViewController.h"


@interface RPViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation RPViewController

- (void)viewDidLoad{
    [super viewDidLoad];
}


#pragma mark - RPSlidingMenuViewController


-(NSInteger)numberOfItemsInSlidingMenu{
    return 9;
}

- (void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row{
    //Below Created by Will Oakley
    
    NSArray *titleArray = @[@"",@"Student ID",@"Athletics",@"Campus Info",@"Seminar Info",@"Aeries SIS",@"Naviance",@"Webstore", @"Support"];
    NSArray *subtitleArray = @[@"",
                               @"Access your scannable ID Card!",
                               @"View Sports Scores and Schedules!",
                               @"View Recent Campus Notifications!",
                               @"Make Appointments for Seminar!",
                               @"Check your Attendance and Graduation Status!",
                               @"View your college admissions information!",
                               @"Purchase school items on the webstore!",
                               @"Get support for this app!"];

    slidingMenuCell.textLabel.text = titleArray[row];
    slidingMenuCell.detailTextLabel.text = subtitleArray[row];
    switch (row) {
        case 0:
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"neoLogo"];
            break;
            
        case 1:
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"studentIDHomeBackground"];
            break;
            
        case 2:
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"athleticsBackground"];
            break;
        case 3:
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"campusLifeBackground"];
            break;
        case 4:
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"seminarBackground"];
            break;
        case 5:
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"aeriesBackground"];
            break;
        case 6:
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"navianceBackground"];
            break;
        case 7:
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"webstoreBackground"];
            break;
        case 8:
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"supportBackground"];
            break;
            
        default:
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"image1_320x210"];
            break;
    }
    
}

- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row{

    [super slidingMenu:slidingMenu didSelectItemAtRow:row];
    
    switch (row) {
        case 0:
            [self performSegueWithIdentifier:@"launchEDU" sender:self];
            break;
            
        case 1:
            [self performSegueWithIdentifier:@"launchStudentID" sender:self];
            break;
            
        case 2:
            [self performSegueWithIdentifier:@"launchAthletics" sender:self];
            break;
            
        case 3:
            [self performSegueWithIdentifier:@"launchCampusCommunication" sender:self];
            break;
            
        case 4:
            [self performSegueWithIdentifier:@"launchSeminarInfo" sender:self];
            break;
            
        case 5:
            [self performSegueWithIdentifier:@"launchAeries" sender:self];
            break;
            
        case 6:
            [self performSegueWithIdentifier:@"launchNaviance" sender:self];
            break;
            
        case 7:
            [self performSegueWithIdentifier:@"launchWebstore" sender:self];
            break;
            
        case 8:
            [self performSegueWithIdentifier:@"launchSupport" sender:self];
            break;
            
        default:
            NSLog(@"pressed button that doesnt exist");
            break;
    }

}



@end
