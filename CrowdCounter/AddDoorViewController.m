//
//  AddDoorViewController.m
//  CrowdCounter
//
//  Created by Koder on 11/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import "AddDoorViewController.h"
#import "DoorDetailViewController.h"
@interface AddDoorViewController ()

@end

@implementation AddDoorViewController
@synthesize doorName, doorArea;

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

- (IBAction)createDoor:(id)sender {
    NSNumber* timeStampObj = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]]; //get the time the door created
    
    
    _doorID = [_ref childByAutoId].key;
    [[[[[self->_ref child:@"events"] child: _eventID] child:@"doors"]child: _doorID]
     setValue:@{@"doorName": doorName.text, @"area":[NSNumber numberWithInt:[doorArea.text intValue]], @"attendantID":@"", @"attendantName":@"", @"entered":@0, @"exited":@0, @"pplPerMin":@0, @"crowdDensity":@0, @"timeCreated":timeStampObj }];
    doorName.text = @"";
    doorArea.text = @"";
    [self performSegueWithIdentifier:@"ShowDoor" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DoorDetailViewController *destinationVC = segue.destinationViewController;
    destinationVC.eventID = _eventID;
    destinationVC.doorID = _doorID;
}
@end
