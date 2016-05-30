//
//  SeminarWebViewController.m
//  DPHS App
//
//  Created by Will Oakley on 10/21/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import "SeminarWebViewController.h"

@interface SeminarWebViewController ()

@end

@implementation SeminarWebViewController

-(void)viewDidLoad {
    self.webView.delegate = self;

    self.activityIndicator.hidesWhenStopped = YES;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    NSURL *url;
    
    selectedRow = [[NSUserDefaults standardUserDefaults] integerForKey:@"seminarSelectedRow"];
    selectedSection = [[NSUserDefaults standardUserDefaults] integerForKey:@"seminarSelectedSection"];
                       
    if (selectedSection == 0) {
        if (selectedRow == 0) {
            pageURL = @"https://docs.google.com/document/d/1uhaKv9MFa_wAG15uuoN3bhvJsbszuGCtJL8XHg68bbQ/edit";
            navigationBarTitle = @"Enrichment Seminar";
        }
        if (selectedRow == 1) {
            pageURL = @"https://docs.google.com/forms/d/1vsJZdIqxLaoOf-BmqptrS-wGxoBUgvzhSNSbK-IEmnU/viewform";
            navigationBarTitle = @"Academic Mentor";
        }
        if (selectedRow == 2) {
            pageURL = @"https://docs.google.com/document/d/1Dob78FNRsB1h_u-0s7B5_rroKegVsh5jYXriol0RdPY/edit";
            navigationBarTitle = @"Golden Tickets";
        }
    }
    if (selectedSection == 1) {
        if (selectedRow == 0) {
            pageURL = @"https://docs.google.com/forms/d/1-GKqFqnvUzPVVXeoLGd09uNlajPDBsJk1MwkPNxNps0/viewform";
            navigationBarTitle = @"Writing Center";
        }
        if (selectedRow == 1) {
            pageURL = @"https://docs.google.com/forms/d/1ijVUtmn7AFQgYjpHlymdnyB6GBCec0UFVo1lorWPHWY/viewform";
            navigationBarTitle = @"Math Center";
        }
        if (selectedRow == 2) {
            pageURL = @"https://docs.google.com/forms/d/1KPMNZSRBWSUBwar8uEH9fPG-5KR7B4-zeLpOFIWAhFE/viewform";
            navigationBarTitle = @"Library/Computer Lab";
        }
        if (selectedRow == 3) {
            pageURL = @"https://docs.google.com/document/d/1E2EUjw9wBI5n6gsXtdqOX8gWYwWo6pylClTrPszW8QQ/edit?pli=1";
            navigationBarTitle = @"Workshops";
        }
    }
    
    self.navigationItem.title = navigationBarTitle;
    url = [NSURL URLWithString:pageURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (IBAction)pressedBackButton:(id)sender {
    [_webView goBack];
}

- (IBAction)pressedRefreshButton:(id)sender {
    [_webView reload];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityIndicator stopAnimating];
}

@end
