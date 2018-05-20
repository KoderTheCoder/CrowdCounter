//
//  ViewController.m
//  CrowdCounter
//
//  Created by Koder on 11/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import "ViewController.h"
@import Firebase;
@interface ViewController ()

@end

@implementation ViewController

@synthesize email, password;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    self.handle = [[FIRAuth auth]
                   addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
                       
                   }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [[FIRAuth auth] removeAuthStateDidChangeListener:_handle];
}


- (IBAction)login:(id)sender {
    [[FIRAuth auth] signInWithEmail:email.text
                           password:password.text
                         completion:^(FIRAuthDataResult * _Nullable authResult,
                                      NSError * _Nullable error) {
                             if(error){
                                 _errorTxtBox.text = @"Username or password incorrect";
                             }else{
                                 [self performSegueWithIdentifier:@"LoggedIn" sender:self];
                             }
                         }];
}
@end
