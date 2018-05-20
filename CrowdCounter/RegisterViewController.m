//
//  RegisterViewController.m
//  CrowdCounter
//
//  Created by Koder on 11/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import "RegisterViewController.h"
@import Firebase;
@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize email, confirmEmail, displayName, password, confirmPassword, errorTxtBox, errors;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ref = [[FIRDatabase database] reference];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)createAccount:(id)sender {
    errors = false;
    if(email.text.length > 0 && displayName.text.length > 0 && password > 0){
        if(![email.text isEqualToString:confirmEmail.text ]){
            [self errorBorder:email];
            [self errorBorder:confirmEmail];
            errorTxtBox.text = @"'Emails do not match'";
            errors = true;
        }
        if(password.text != confirmPassword.text){
            [self errorBorder:password];
            [self errorBorder:confirmPassword];
            errorTxtBox.text = @"'Passwords do not match'";
            errors = true;
        }
        if(!errors){
            [[FIRAuth auth] createUserWithEmail:email.text
                                       password:password.text
                                     completion:^(FIRAuthDataResult * _Nullable authResult,
                                                  NSError * _Nullable error) {
                                         if(error){
                                             errorTxtBox.text = @"Something went wrong";
                                         }else{
                                             [[[_ref child:@"users"] child:authResult.user.uid]
                                              setValue:@{@"email": email.text, @"displayName":displayName.text}];
                                             [self performSegueWithIdentifier:@"backToLogin" sender:self];
                                         }
                                     }];
        }
    }else{
        errorTxtBox.text = @"Please fill in all fields";
    }
}

-(void)errorBorder:(UITextField *)textBox{
    textBox.layer.cornerRadius = 8.0f;
    textBox.layer.masksToBounds = YES;
    textBox.layer.borderColor = [[UIColor redColor] CGColor];
    textBox.layer.borderWidth = 1.0f;
}

- (void) viewWillAppear:(BOOL)animated{
    self.handle = [[FIRAuth auth]
                   addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
                       // ...
                   }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [[FIRAuth auth] removeAuthStateDidChangeListener:_handle];
}

@end
