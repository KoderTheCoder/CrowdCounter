//
//  CreateEventViewController.h
//  CrowdCounter
//
//  Created by Koder on 11/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface CreateEventViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *createEventTextField;
- (IBAction)createEventButton:(id)sender;
@property(strong, nonatomic) FIRAuthStateDidChangeListenerHandle handle;
@property FIRDatabaseHandle refHandle;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property int eventCode;
@property (strong, nonatomic) NSString *eventID;
@end
