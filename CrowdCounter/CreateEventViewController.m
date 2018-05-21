//
//  CreateEventViewController.m
//  CrowdCounter
//
//  Created by Koder on 11/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import "CreateEventViewController.h"
#import "EventHomePageViewController.h"
@import Firebase;

@interface CreateEventViewController ()

@end

@implementation CreateEventViewController

@synthesize createEventTextField;

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

- (IBAction)createEventButton:(id)sender {
    _eventCode = arc4random() % (9999-1000+1) + 1000;
    if(createEventTextField.text.length > 0){
        _eventID = [_ref childByAutoId].key;
        [[[self->_ref child:@"events"] child: _eventID]
         setValue:@{@"eventName": self->createEventTextField.text, @"owner":[[[FIRAuth auth] currentUser] uid], @"eventCode":[[NSString alloc] initWithFormat:@"%d", _eventCode]}];
        createEventTextField.text = @"";
        [self performSegueWithIdentifier:@"EventCreated" sender:self];
    }else{
        createEventTextField.layer.cornerRadius = 8.0f;
        createEventTextField.layer.masksToBounds = YES;
        createEventTextField.layer.borderColor = [[UIColor redColor] CGColor];
        createEventTextField.layer.borderWidth = 1.0f;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"EventCreated"]){
        EventHomePageViewController *destinationVC = segue.destinationViewController;
        destinationVC.eventID = _eventID;
    }
}

- (void) viewWillAppear:(BOOL)animated{
    self.handle = [[FIRAuth auth]
                   addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
                       // ...
                   }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [[FIRAuth auth] removeAuthStateDidChangeListener:_handle];
}
@end
