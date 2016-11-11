//
//  NEOLoginViewController.h
//  DPHS App
//
//  Created by Will Oakley on 11/2/15.
//  Copyright © 2015 Will Oakley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJMaterialTextfield.h"

@interface NEOLoginViewController : UIViewController

@property (strong, nonatomic) JJMaterialTextfield *textField;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
- (IBAction)pressedSave:(id)sender;

@end
