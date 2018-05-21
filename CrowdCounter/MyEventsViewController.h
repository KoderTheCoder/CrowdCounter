//
//  MyEventsViewController.h
//  CrowdCounter
//
//  Created by Koder on 16/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface MyEventsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *eventsTableView;
@property (strong, nonatomic) NSMutableArray *eventList;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property FIRDatabaseHandle refHandle;

@end
