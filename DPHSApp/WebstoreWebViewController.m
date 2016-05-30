//
//  WebstoreWebViewController.m
//  DPHS App
//
//  Created by Will Oakley on 10/21/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import "WebstoreWebViewController.h"

@interface WebstoreWebViewController ()

@end

@implementation WebstoreWebViewController

- (void)viewDidLoad {
    self.webView.delegate = self;

    self.activityIndicator.hidesWhenStopped = YES;
    NSURL *url = [NSURL URLWithString:@"https://webstores.activenetwork.com/school-software/dos_pueblos_high_sch/"];
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
