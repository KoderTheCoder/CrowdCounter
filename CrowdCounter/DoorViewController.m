//
//  DoorViewController.m
//  CrowdCounter
//
//  Created by Koder on 16/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import "DoorViewController.h"
@import Firebase;

@interface DoorViewController ()

@end

@implementation DoorViewController

@synthesize enteredLbl, exitedLbl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *unregister = [[UIBarButtonItem alloc]initWithTitle:@"Unregister" style:UIBarButtonItemStylePlain target:self action: @selector(unregisterPressed:)];
    self.navigationController.topViewController.navigationItem.rightBarButtonItem = unregister;
    unregister.enabled=TRUE;
    unregister.title = @"Unregister";
    
    _ref = [[FIRDatabase database] reference];
    /*
    _refHandle = [[[[_ref child:@"events"]child:_eventID]child:_doorID] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *postDict = snapshot.value;
        
        self->enteredLbl.text = [NSString stringWithFormat:@"%@",[postDict objectForKey:@"entered"]];
        self->exitedLbl.text = [NSString stringWithFormat:@"%@",[postDict objectForKey:@"exited"]];
    }];
     */
    [[[[[_ref child:@"events"] child:_eventID]child:@"doors"] child:_doorID] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *postDict = snapshot.value;
        self->enteredLbl.text = [NSString stringWithFormat:@"%@",[postDict objectForKey:@"entered"]];
        self->exitedLbl.text = [NSString stringWithFormat:@"%@",[postDict objectForKey:@"exited"]];
    }];
    
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

- (IBAction)enteredButton:(id)sender {
    [[[[[_ref child:@"events"]child:_eventID]child:@"doors"]child:_doorID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *postDict = snapshot.value;
        NSNumber *entered = [NSNumber numberWithInt:[[postDict objectForKey:@"entered"] intValue]+1];
        
        [[[[[self->_ref child:@"events"] child:self->_eventID]child:@"doors"]child:self->_doorID]
         updateChildValues:@{@"entered": entered}];
    }];
}

- (IBAction)exitedButton:(id)sender {
    [[[[[_ref child:@"events"]child:_eventID]child:@"doors"]child:_doorID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *postDict = snapshot.value;
        NSNumber *exited = [NSNumber numberWithInt:[[postDict objectForKey:@"exited"] intValue]+1];
        
        [[[[[self->_ref child:@"events"] child:self->_eventID]child:@"doors"]child:self->_doorID]
         updateChildValues:@{@"exited": exited}];
    }];
}

- (IBAction) unregisterPressed:(id)sender {
    //do as you please with buttonClicked.argOne
    [[[[[self->_ref child:@"events"] child:self->_eventID]child:@"doors"]child:self->_doorID]
     updateChildValues:@{@"attendantID": @""}];
    
    [[self navigationController]popViewControllerAnimated:YES];
    
}
@end
