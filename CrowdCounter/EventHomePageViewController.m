//
//  EventHomePageViewController.m
//  CrowdCounter
//
//  Created by Koder on 11/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import "EventHomePageViewController.h"
#import "AddDoorViewController.h"
@interface EventHomePageViewController ()

@end

@implementation EventHomePageViewController
@synthesize totalEnteredLbl, crowdDensityLbl;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ref = [[FIRDatabase database] reference];
    
    //NSString *userID = [FIRAuth auth].currentUser.uid;
    [[[_ref child:@"events"] child:_eventID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        // Get user value
        [self.navigationItem setTitle:snapshot.value[@"eventName"]];
        
        // ...
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"AddDoor"]){
        AddDoorViewController *destinationVC = segue.destinationViewController;
        destinationVC.eventID = _eventID;
    }
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
