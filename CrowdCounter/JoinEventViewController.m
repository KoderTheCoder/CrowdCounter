//
//  JoinEventViewController.m
//  CrowdCounter
//
//  Created by Koder on 16/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import "JoinEventViewController.h"
#import "EventHomePageViewController.h"
@import Firebase;

@interface JoinEventViewController ()

@end

@implementation JoinEventViewController

@synthesize eventCodetxtField, eventIDforSegue;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ref = [[FIRDatabase database]reference];
    
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

- (IBAction)joinButton:(id)sender {
    [[_ref child:@"events"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        // Get user value
        NSDictionary *postDict = snapshot.value;
        
        for(id key in postDict){
            if([[postDict objectForKey:key] objectForKey:@"eventCode"] == self->eventCodetxtField.text){
                [[[[[self->_ref child:@"events"] child:key] child:@"members"]child:[[[FIRAuth auth] currentUser] uid]]
                  setValue:@{@"Name": @"null"}];
                self->eventIDforSegue = key;
                [self performSegueWithIdentifier:@"JoinEventAccepted" sender:self];
                break;
            }
        }
        
        
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    EventHomePageViewController *destinationVC = segue.destinationViewController;
    destinationVC.eventID = eventIDforSegue;
}
@end
