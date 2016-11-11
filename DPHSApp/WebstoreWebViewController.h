//
//  WebstoreWebViewController.h
//  DPHS App
//
//  Created by Will Oakley on 10/21/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebstoreWebViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)reloadButtonPressed:(id)sender;

@end
