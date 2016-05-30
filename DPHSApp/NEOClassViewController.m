//
//  NEOClassViewController.m
//  DPHS App
//
//  Created by Will Oakley on 10/24/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import "NEOClassViewController.h"

@interface NEOClassViewController ()

@end

@implementation NEOClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    apiKey = @"10626-319305-5aa73b4466f26ec215c49ace27e164c5bf1f7a31";
    
    className = [[NSUserDefaults standardUserDefaults] objectForKey:@"NEOSelectedClassName"];
    classID = [[NSUserDefaults standardUserDefaults] objectForKey:@"NEOSelectedClassID"];
    overallGradeLetter = [[NSUserDefaults standardUserDefaults] objectForKey:@"NEOSelectedClassLetterGrade"];
    overallGradePercent = [[NSUserDefaults standardUserDefaults] objectForKey:@"NEOSelectedClassPercentage"];
    classDataDictionary = [[NSMutableDictionary alloc] init];
    classDataDictionary = (NSMutableDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"NEOSelectedClassData"]];
    
    NSLog(@"classDataDictionary: %@", classDataDictionary);
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@",className];

    [self.gradeProgressCircle setProgress:[overallGradePercent doubleValue]/100.0
                               timing:TPPropertyAnimationTimingEaseOut
                             duration:1.0
                                delay:0.2];
    
    self.gradeProgressCircle.trackColor = [UIColor redColor];
    self.gradeProgressCircle.progressColor = [UIColor greenColor];
    
    self.gradeProgressCircle.trackWidth = 50;
    self.gradeProgressCircle.progressWidth = 50;
    
    self.letterLabel.text = [NSString stringWithFormat:@"Current Grade: %@", overallGradeLetter];
    self.percentLabel.text = [NSString stringWithFormat:@"%@ %%", overallGradePercent];
    
    
    NSURLRequest *classAssignmentsRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://dphs.edu20.org/api/get_assignments_for_class?api_key=%@&class_id=%@", apiKey, classID]]];
    
    classAssignmentsConnection = [[NSURLConnection alloc] initWithRequest:classAssignmentsRequest delegate:self];
    
    [ZAActivityBar showWithStatus:@"Loading Assignments..."];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"Data Recieved");
    NEOAPIData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [NEOAPIData appendData:data];
    
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [ZAActivityBar dismiss];
    assignmentsDataArray = [NSJSONSerialization JSONObjectWithData:NEOAPIData options:NSJSONReadingMutableLeaves error:nil];
    
    [self.assignmentTable reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [ZAActivityBar dismiss];
    UIAlertView *connectionFailedAlert = [[UIAlertView alloc] initWithTitle:@"Uh Oh!" message:@"Looks like there was an error connecting to NEO. Please try again later." delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil, nil];
    [connectionFailedAlert show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([assignmentsDataArray count] == 0) {
        return [assignmentsDataArray count];

    }
    else {
        return [[[[[classDataDictionary objectForKey:@"grades"]objectForKey:@"grading_periods"]objectAtIndex:0]objectForKey:@"assignments"] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AssignmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"assignmentCell" forIndexPath:indexPath];

    cell.assignmentName.text = [[assignmentsDataArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    NSString *gradeString = [NSString stringWithFormat:@"%@ / %@", [[[[[[classDataDictionary objectForKey:@"grades"]objectForKey:@"grading_periods"]objectAtIndex:0]objectForKey:@"assignments"]objectAtIndex:indexPath.row]objectForKey:@"score"], [[[[[[classDataDictionary objectForKey:@"grades"]objectForKey:@"grading_periods"]objectAtIndex:0]objectForKey:@"assignments"]objectAtIndex:indexPath.row]objectForKey:@"points"]];
    
    cell.assignmentGrade.text = gradeString;
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    UILabel *assignmentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width/2, 18)];
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 50, 5, tableView.frame.size.width/4, 18)];
    [assignmentsLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [assignmentsLabel setText:@"Assignment/Section"];
    [scoreLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [scoreLabel setText:@"Score"];
    [view addSubview:assignmentsLabel];
    [view addSubview:scoreLabel];

    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]];
    return view;
}



@end
