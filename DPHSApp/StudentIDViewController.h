//
//  StudentIDViewController.h
//  DPHS App
//
//  Created by Will Oakley on 10/19/15.
//  Copyright © Will Oakley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentIDViewController : UIViewController <UIAlertViewDelegate> {
    NSMutableArray *dataArray;
    NSString *apiKey;
    NSNumber *userID;
    NSURLConnection *studentInfoConnection;
    NSMutableData *NEOAPIData;
    UIImage *userImage;
}

@property (weak, nonatomic) IBOutlet UILabel *barcodeView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@end
