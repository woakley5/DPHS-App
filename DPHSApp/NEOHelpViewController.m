//
//  NEOHelpViewController.m
//  DPHS App
//
//  Created by Will Oakley on 11/2/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import "NEOHelpViewController.h"

@interface NEOHelpViewController ()

@end

@implementation NEOHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, 1200);
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1200);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
