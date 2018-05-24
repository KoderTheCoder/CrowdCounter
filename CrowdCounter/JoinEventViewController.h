//
//  JoinEventViewController.h
//  CrowdCounter
//
//  Created by Koder on 16/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface JoinEventViewController : UIViewController
- (IBAction)joinButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *eventCodetxtField;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) NSString *eventIDforSegue;

@end
