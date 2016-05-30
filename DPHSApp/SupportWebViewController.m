//
//  SupportWebViewController.m
//  DPHS App
//
//  Created by Will Oakley on 11/3/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import "SupportWebViewController.h"

@interface SupportWebViewController ()

@end

@implementation SupportWebViewController

- (void)viewDidLoad {
    self.webView.delegate = self;
    
    self.activityIndicator.hidesWhenStopped = YES;
    NSURL *url = [NSURL URLWithString:@"https://docs.google.com/forms/d/1dgaDCzwg_0JO6uutspB5fDjhu6OwhIkWe5Z722mcw68/viewform?usp=send_form"];
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
