//
//  DoorDetailViewController.m
//  CrowdCounter
//
//  Created by Koder on 18/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import "DoorDetailViewController.h"
#import "DoorViewController.h"

@interface DoorDetailViewController ()

@end

@implementation DoorDetailViewController

@synthesize doorName, attendantName, enteredLbl, exitedLbl, pplPerMin, crowdDensity, registerToDoorButton, attendantID, loggedInDisplayName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ref = [[FIRDatabase database] reference];
    
    [self getLoggedInUserDisplayName];
    
    //handler to listen for changes in the database
    _refHandle = [[[[[_ref child:@"events"] child:_eventID]child:@"doors"] child:_doorID] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *postDict = snapshot.value;
        self->doorName.text = [@"Door: " stringByAppendingString:[postDict objectForKey:@"doorName"]];
        self->attendantID = [postDict objectForKey:@"attendantID"];
        if([[postDict objectForKey:@"attendantID"]  isEqual: @""]){
            self->attendantName.text = @"Attendant: NA";
        }else{
            if([[[[FIRAuth auth]currentUser]uid] isEqualToString:[postDict objectForKey:@"attendantID"]]){
                [self->registerToDoorButton setTitle:@"Door Counter Page" forState:UIControlStateNormal];
            }else{
                [self->registerToDoorButton setEnabled:NO];
            }
            
            self->attendantName.text = [@"Attendant: " stringByAppendingString:[postDict objectForKey:@"attendantName"]];
        }
        if([postDict objectForKey:@"entered"] != nil){
            self->enteredLbl.text = [@"Entered: " stringByAppendingString:[NSString stringWithFormat:@"%@",[postDict objectForKey:@"entered"]]];
        }
        if([postDict objectForKey:@"exited"] != nil){
            self->exitedLbl.text = [@"Exited: " stringByAppendingString:[NSString stringWithFormat:@"%@",[postDict objectForKey:@"exited"]]];
        }
        if([postDict objectForKey:@"pplPerMin"] != nil){
            self->pplPerMin.text = [@"Peopl/Min: " stringByAppendingString:[NSString stringWithFormat:@"%@",[postDict objectForKey:@"pplPerMin"]]];
        }
        if([postDict objectForKey:@"crowdDensity"] != nil){
            self->crowdDensity.text = [@"Crowd Density: " stringByAppendingString:[NSString stringWithFormat:@"%@",[postDict objectForKey:@"crowdDensity"]]];
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

- (void) getLoggedInUserDisplayName{
    [[_ref child:@"users"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        for(id key in snapshot.value){
            if([key isEqualToString:[[[FIRAuth auth]currentUser]uid]]){
                self->loggedInDisplayName = [[snapshot.value objectForKey:key]objectForKey:@"displayName"];
            }
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DoorViewController *destinationVC = segue.destinationViewController;
    
    destinationVC.eventID = _eventID;
    destinationVC.doorID = _doorID;
}

- (IBAction)registerToDoor:(id)sender {
    if([[[[FIRAuth auth]currentUser]uid] isEqualToString:attendantID]){
        [self performSegueWithIdentifier:@"DoorCounter" sender:self];
    }else{
        [[[[[self->_ref child:@"events"] child:_eventID]child:@"doors"]child:_doorID]
         updateChildValues:@{@"attendantID":[[[FIRAuth auth]currentUser]uid], @"attendantName":loggedInDisplayName}];
        
        [self performSegueWithIdentifier:@"DoorCounter" sender:self];
    }
}
@end
