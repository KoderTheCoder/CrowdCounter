//
//  ViewController.h
//  CrowdCounter
//
//  Created by Koder on 11/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
@interface ViewController : UIViewController
@property(strong, nonatomic) FIRAuthStateDidChangeListenerHandle handle;

@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UILabel *errorTxtBox;
- (IBAction)login:(id)sender;

@end

