//
//  NEOLoginViewController.m
//  DPHS App
//
//  Created by Will Oakley on 11/2/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import "NEOLoginViewController.h"

@interface NEOLoginViewController ()

@end

@implementation NEOLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField =[[JJMaterialTextfield alloc] initWithFrame:CGRectMake(40, 120, self.view.frame.size.width-80, 70)];
    self.textField.textColor=[UIColor whiteColor];
    self.textField.font = [UIFont systemFontOfSize:26];
    [self.textField enableMaterialPlaceHolder:YES];
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.errorColor=[UIColor colorWithRed:0.910 green:0.329 blue:0.271 alpha:1.000];
    self.textField.lineColor= [UIColor colorWithRed:0.996f green:0.804f blue:0.094f alpha:1.00f];
    self.textField.tintColor= [UIColor colorWithRed:0.000f green:0.435f blue:0.988f alpha:1.00f];
    self.textField.placeholder=@"NEO ID";
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.view.frame;
    
    [self.view addSubview:self.textField];
    [self.backgroundImage addSubview:effectView];
    effectView.alpha = 0.0;
    
    [UIView animateWithDuration:0.5 delay:0.6 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        effectView.alpha = 1.0;
    } completion:^(BOOL finished) {
        NSLog(@"Animation complete");
    }];
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

- (IBAction)pressedSave:(id)sender {
    if (self.textField.text != nil && self.textField.text.length == 7) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterNoStyle;
        NSNumber *myNumber = [numberFormatter numberFromString:self.textField.text];
        [[NSUserDefaults standardUserDefaults] setObject:myNumber forKey:@"userID"];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"cameFromLogin"];
        [self dismissViewControllerAnimated:true completion:^{
            NSLog(@"Logged In");
        }];
    }
    else {
        UIAlertView *invalidIDAlert = [[UIAlertView alloc] initWithTitle:@"Uh oh!" message:@"Looks like that NEO ID is invalid. Remember that NEO IDs are 7 digits of numbers only. This number is NOT your student ID. Check the help screen for more info." delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil, nil];
        [invalidIDAlert show];
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

@end
