//
//  DoorDetailViewController.h
//  CrowdCounter
//
//  Created by Koder on 18/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface DoorDetailViewController : UIViewController

- (IBAction)registerToDoor:(id)sender;

@property (strong, nonatomic) NSString *loggedInDisplayName;

@property (strong, nonatomic) IBOutlet UIButton *registerToDoorButton;
@property (strong, nonatomic) IBOutlet UILabel *doorName;
@property (strong, nonatomic) NSString *attendantID;
@property (strong, nonatomic) IBOutlet UILabel *attendantName;
@property (strong, nonatomic) IBOutlet UILabel *enteredLbl;
@property (strong, nonatomic) IBOutlet UILabel *exitedLbl;
@property (strong, nonatomic) IBOutlet UILabel *pplPerMin;
@property (strong, nonatomic) IBOutlet UILabel *crowdDensity;
@property (strong, nonatomic) NSString *doorID;
@property (strong, nonatomic) NSString *eventID;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property FIRDatabaseHandle refHandle;
@end
