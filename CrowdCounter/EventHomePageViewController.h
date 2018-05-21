//
//  EventHomePageViewController.h
//  CrowdCounter
//
//  Created by Koder on 11/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface EventHomePageViewController : UIViewController
@property (strong, nonatomic) NSString *eventID;
@property (strong, nonatomic) IBOutlet UILabel *totalEnteredLbl;
@property (strong, nonatomic) IBOutlet UILabel *crowdDensityLbl;
@property (strong, nonatomic) IBOutlet UILabel *eventCodeLbl;
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end
