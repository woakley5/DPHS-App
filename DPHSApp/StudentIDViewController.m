//
//  StudentIDViewController.m
//  DPHS App
//
//  Created by Will Oakley on 10/19/15.
//  Copyright © Will Oakley. All rights reserved.
//

#import "StudentIDViewController.h"

@interface StudentIDViewController ()

@end

@implementation StudentIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArray = [[NSMutableArray alloc] init];
    apiKey = @"10626-319305-5aa73b4466f26ec215c49ace27e164c5bf1f7a31";
    self.barcodeView.font = [UIFont fontWithName:@"New" size:75];
}

-(void)viewWillAppear:(BOOL)animated{
    self.nameLabel.text = nil;
    self.idNumberLabel.text = nil;
    self.barcodeView.text = nil;
    self.barcodeView.alpha = 0;
    [self checkForIDData];
    
}

-(void)checkForIDData{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"StudentIDNumber"] == nil) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userID" ] == nil) {
            UIAlertView *notLoggedInAlert = [[UIAlertView alloc] initWithTitle:@"Uh oh!" message:@"Looks like you arent logged into NEO. Please do this before accessing your Student ID. Your ID will be filled with data from NEO" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK!", nil];
            [notLoggedInAlert show];
        }
        else{
            userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
            NSURLRequest *studentInfoRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://dphs.edu20.org/api/get_users_with_ids?api_key=%@&user_ids=%@", apiKey, userID]]];
            studentInfoConnection = [[NSURLConnection alloc] initWithRequest:studentInfoRequest delegate:self];
           
        }
    }
    else{
        [self blurBackground];
        self.nameLabel.text = [NSString stringWithFormat:@"%@  ",[[NSUserDefaults standardUserDefaults] objectForKey:@"StudentName"]];
        self.idNumberLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"StudentIDNumber"];
        self.barcodeView.text = [NSString stringWithFormat:@"*%@*",[[NSUserDefaults standardUserDefaults] objectForKey:@"StudentIDNumber"]];
        NSData *userImageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userImageData"];
        self.userImage.image = [UIImage imageWithData:userImageData];
        [UIView animateWithDuration:0.5 animations:^{
            self.barcodeView.alpha = 1;
        }];
    }
}

-(void)blurBackground{
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.view.frame;
    
    [self.backgroundImage addSubview:effectView];
    effectView.alpha = 0.0;
    
    [UIView animateWithDuration:0.5 delay:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        effectView.alpha = 1.0;
    } completion:^(BOOL finished) {
        NSLog(@"Animation complete");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self performSegueWithIdentifier:@"homeFromID" sender:self];
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
    dataArray = [NSJSONSerialization JSONObjectWithData:NEOAPIData options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@", dataArray);
    [[NSUserDefaults standardUserDefaults] setObject:[[dataArray objectAtIndex:0]objectForKey:@"student_id"] forKey:@"StudentIDNumber"];
    NSString *name = [NSString stringWithFormat:@"%@ %@",[[dataArray objectAtIndex:0]objectForKey:@"first_name"], [[dataArray objectAtIndex:0]objectForKey:@"last_name"]];
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"StudentName"];
    [[NSUserDefaults standardUserDefaults] setObject:[[dataArray objectAtIndex:0]objectForKey:@"year_of_graduation"] forKey:@"StudentGrade"];
    NSURL *url = [NSURL URLWithString:[[dataArray objectAtIndex:0]objectForKey:@"picture"]];
    NSLog(@"Picture URL: %@", url);
    NSData *data = [NSData dataWithContentsOfURL:url];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userImageData"];
    [self checkForIDData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    UIAlertView *connectionFailedAlert = [[UIAlertView alloc] initWithTitle:@"Uh Oh!" message:@"Looks like there was an error connecting to NEO. Please try again later. This could also mean that your NEO ID has been entered incorrectly." delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil, nil];
    [connectionFailedAlert show];
}



@end
