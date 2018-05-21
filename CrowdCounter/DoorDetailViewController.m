//
//  DoorDetailViewController.m
//  CrowdCounter
//
//  Created by Koder on 18/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import "DoorDetailViewController.h"

@interface DoorDetailViewController ()

@end

@implementation DoorDetailViewController

@synthesize doorName, attendantName, enteredLbl, exitedLbl, pplPerMin, crowdDensity;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ref = [[FIRDatabase database] reference];
    
    
    //handler to listen for changes in the database
    _refHandle = [[[[_ref child:@"events"] child:_eventID] child:_doorID] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *postDict = snapshot.value;
        self->doorName.text = [@"Door: " stringByAppendingString:[postDict objectForKey:@"doorName"]];
        
        if([[postDict objectForKey:@"attendantID"]  isEqual: @""]){
            self->attendantName.text = @"Attendant: NA";
        }else{
            [[[self->_ref child:@"users"] child:[postDict objectForKey:@"attendantID"]] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                
                //get the users display name from attendantID
                self->attendantName.text = snapshot.value[@"displayName"];
            } withCancelBlock:^(NSError * _Nonnull error) {
                NSLog(@"%@", error.localizedDescription);
            }];
        }
        if([postDict objectForKey:@"entered"] != nil){
            self->enteredLbl.text = [@"Entered: " stringByAppendingString:[postDict objectForKey:@"entered"]];
        }
        if([postDict objectForKey:@"exited"] != nil){
            self->exitedLbl.text = [@"Exited: " stringByAppendingString:[postDict objectForKey:@"exited"]];
        }
        if([postDict objectForKey:@"pplPerMin"] != nil){
            self->pplPerMin.text = [@"Peopl/Min: " stringByAppendingString:[postDict objectForKey:@"pplPerMin"]];
        }
        if([postDict objectForKey:@"crowdDensity"] != nil){
            self->crowdDensity.text = [@"Crowd Density: " stringByAppendingString:[postDict objectForKey:@"crowdDensity"]];
        }
    }];
    
    /*
    [[[[_ref child:@"events"] child:_eventID] child:_doorID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        // Get user value
        [self.navigationItem setTitle:snapshot.value[@"doorName"]];
        
        // ...
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
     */
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

@end
