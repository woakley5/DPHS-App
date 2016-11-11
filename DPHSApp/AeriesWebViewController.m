//
//  AeriesWebViewController.m
//  DPHS App
//
//  Created by Will Oakley on 10/21/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import "AeriesWebViewController.h"

@interface AeriesWebViewController ()

@end

@implementation AeriesWebViewController

- (void)viewDidLoad {
    self.webView.delegate = self;

    self.activityIndicator.hidesWhenStopped = YES;
    NSURL *url = [NSURL URLWithString:@"https://aeries.sbunified.org/parent/LoginParent.aspx"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [_webView goBack];
}

- (IBAction)reloadButtonPressed:(id)sender {
    [_webView reload];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityIndicator stopAnimating];
}

@end
