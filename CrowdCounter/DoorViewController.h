//
//  DoorViewController.h
//  CrowdCounter
//
//  Created by Koder on 16/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface DoorViewController : UIViewController

@property (strong, nonatomic) NSString *eventID;
@property (strong, nonatomic) NSString *doorID;
@property (strong, nonatomic) IBOutlet UILabel *enteredLbl;
@property (strong, nonatomic) IBOutlet UILabel *exitedLbl;
- (IBAction)enteredButton:(id)sender;
- (IBAction)exitedButton:(id)sender;

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property FIRDatabaseHandle refHandle;

@end
