//
//  AddDoorViewController.h
//  CrowdCounter
//
//  Created by Koder on 11/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface AddDoorViewController : UIViewController

@property (strong, nonatomic) FIRDatabaseReference *ref;

@property (strong, nonatomic) IBOutlet UITextField *doorName;
@property (strong, nonatomic) IBOutlet UITextField *doorArea;
@property (strong, nonatomic) NSString *eventID;
@property (strong, nonatomic) NSString *doorID;
- (IBAction)createDoor:(id)sender;

@end
