//
//  SeminarWebViewController.h
//  DPHS App
//
//  Created by Will Oakley on 10/21/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeminarWebViewController : UIViewController <UIWebViewDelegate> {
    NSInteger selectedRow;
    NSInteger selectedSection;
    
    NSString *pageURL;
    NSString *navigationBarTitle;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)pressedBackButton:(id)sender;
- (IBAction)pressedRefreshButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
