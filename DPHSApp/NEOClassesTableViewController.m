//
//  NEOClassesTableViewController.m
//  DPHS App
//
//  Created by Will Oakley on 10/24/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import "NEOClassesTableViewController.h"

@interface NEOClassesTableViewController ()

@end

@implementation NEOClassesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    classGradesLetterArray = [[NSMutableArray alloc] init];
    classGradesPercentageArray = [[NSMutableArray alloc] init];
    classIDArray = [[NSMutableArray alloc] init];
    classDataID = [[NSMutableArray alloc] init];
    classDataName = [[NSMutableArray alloc] init];
    classNamesArray = [[NSMutableArray alloc] init];
    
    apiKey = @"10626-319305-5aa73b4466f26ec215c49ace27e164c5bf1f7a31";
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] == nil) {
        NSLog(@"Not Logged In");
        [self performSegueWithIdentifier:@"showNEOLogin" sender:self];
    }
    else{
        userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
        NSLog(@"User ID is: %@", userID);
        [self requestClassIDs];
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"cameFromLogin"] == true) {
        NSLog(@"Came from Login");
        userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
        [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"cameFromLogin"];
        [self requestClassIDs];
    }
}



-(void)requestClassIDs{
    @try {
        [ZAActivityBar showWithStatus:@"Loading Classes..."];
        NSURLRequest *classIDRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://dphs.edu20.org/api/get_grades_for_user?api_key=%@&user_id=%@", apiKey, userID]]];
        
        classIDConnection = [[NSURLConnection alloc] initWithRequest:classIDRequest delegate:self];
        connectionCounter = 0;
    }
    @catch (NSException *exception) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Looks like there was an error connecting to NEO. Please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [ZAActivityBar dismiss];
        [self performSegueWithIdentifier:@"neoTableReturnHome" sender:self];
    }
    
   
}

-(void)requestClassNames{
    NSURLRequest *classNameRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://dphs.edu20.org/api/get_classes_with_ids?api_key=%@&class_ids=%@", apiKey, [classIDArray objectAtIndex:connectionCounter]]]];
        
    classNameConnection = [[NSURLConnection alloc] initWithRequest:classNameRequest delegate:self];
    connectionCounter++;
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
    @try{
        if(connection == classIDConnection){
            classDataID = [NSJSONSerialization JSONObjectWithData:NEOAPIData options:NSJSONReadingMutableLeaves error:nil];
        
            NSLog(@"Class ID Connection");

            for (int arrayCounter = 0; arrayCounter < [classDataID count]; arrayCounter++) {
                classDataID = [NSJSONSerialization JSONObjectWithData:NEOAPIData options:NSJSONReadingMutableLeaves error:nil];


                [classIDArray addObject:[[classDataID objectAtIndex:arrayCounter]objectForKey:@"class_id"]];
                [classGradesLetterArray addObject:[[[classDataID objectAtIndex:arrayCounter]objectForKey:@"grades"]objectForKey:@"grade"]];
                [classGradesPercentageArray addObject:[[[classDataID objectAtIndex:arrayCounter]objectForKey:@"grades"]objectForKey:@"percent"]];
            }
    
    
            [self requestClassNames];
        }
        if (connection == classNameConnection) {
            [ZAActivityBar dismiss];
            classDataName = [NSJSONSerialization JSONObjectWithData:NEOAPIData options:NSJSONReadingMutableLeaves error:nil];
        
            NSLog(@"Class Name Connection");
        
            [classNamesArray addObject:[[classDataName objectAtIndex:0] objectForKey:@"name"]];
            if (connectionCounter < [classIDArray count]) {
                [self requestClassNames];
            }
            else{
                [self.tableView reloadData];
            }
        }
        NSLog(@"%@", classNamesArray);
        }
    @catch(NSException *exception) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Looks like there was an error connecting to NEO. Please try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [ZAActivityBar dismiss];
        [alert show];
        [self performSegueWithIdentifier:@"neoTableReturnHome" sender:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [ZAActivityBar dismiss];
    UIAlertView *connectionFailedAlert = [[UIAlertView alloc] initWithTitle:@"Uh Oh!" message:@"Looks like there was an error connecting to NEO. Please try again later. This could also mean that your NEO ID has been entered incorrectly." delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil, nil];
    [connectionFailedAlert show];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [classIDArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"classCell" forIndexPath:indexPath];
    
    cell.className.text = [NSString stringWithFormat:@"%@", [classNamesArray objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *selectedClassID = [classIDArray objectAtIndex:indexPath.row];
    NSString *selectedClassGrade = [classGradesLetterArray objectAtIndex:indexPath.row];
    NSString *selectedClassName = [classNamesArray objectAtIndex:indexPath.row];
    NSNumber *selectedClassPercent = [classGradesPercentageArray objectAtIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults]setObject:selectedClassName forKey:@"NEOSelectedClassName"];
    [[NSUserDefaults standardUserDefaults]setObject:selectedClassID forKey:@"NEOSelectedClassID"];
    [[NSUserDefaults standardUserDefaults]setObject:selectedClassGrade forKey:@"NEOSelectedClassLetterGrade"];
    [[NSUserDefaults standardUserDefaults]setObject:selectedClassPercent forKey:@"NEOSelectedClassPercentage"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSKeyedArchiver archivedDataWithRootObject:[classDataID objectAtIndex:indexPath.row]] forKey:@"NEOSelectedClassData"];


    [self performSegueWithIdentifier:@"showNEOClass" sender:self];
}



- (IBAction)pressedLogOut:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userID"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"StudentIDNumber"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"StudentName"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"StudentGrade"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userImageData"];

    [self performSegueWithIdentifier:@"showNEOLogin" sender:self];
}
@end
