//
//  RegisterViewController.h
//  CrowdCounter
//
//  Created by Koder on 11/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
@interface RegisterViewController : UIViewController

@property (nonatomic) BOOL errors;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *confirmEmail;
@property (strong, nonatomic) IBOutlet UITextField *displayName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassword;
@property (strong, nonatomic) IBOutlet UILabel *errorTxtBox;
@property(strong, nonatomic) FIRAuthStateDidChangeListenerHandle handle;
@property (strong, nonatomic) FIRDatabaseReference *ref;

- (IBAction)createAccount:(id)sender;

- (void)errorBorder:(UITextField *)textBox;

@end
