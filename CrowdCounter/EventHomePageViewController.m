//
//  EventHomePageViewController.m
//  CrowdCounter
//
//  Created by Koder on 11/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import "EventHomePageViewController.h"
#import "AddDoorViewController.h"
#import "DoorDetailViewController.h"
@interface EventHomePageViewController ()

@end

@implementation EventHomePageViewController
@synthesize totalEnteredLbl, crowdDensityLbl, selectedDoorID, eventCodeLbl;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ref = [[FIRDatabase database] reference];
    _doorsList = [[NSMutableArray alloc] init];
    _doorsIDList = [[NSMutableArray alloc] init];
    //NSString *userID = [FIRAuth auth].currentUser.uid;
    [[[_ref child:@"events"] child:_eventID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        // Get user value
        [self.navigationItem setTitle:snapshot.value[@"eventName"]];
        self->eventCodeLbl.text = [@"Event Code: " stringByAppendingString: snapshot.value[@"eventCode"]];
        if(![snapshot.value[@"owner"] isEqualToString:[[[FIRAuth auth]currentUser]uid]]){
            [self->_addDoorButton setEnabled:NO];
            [self->_addDoorButton setHidden:YES];
        }
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
    [self setupData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITablView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _doorsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoorCell"];
    cell.textLabel.text = [_doorsList[indexPath.row] objectForKey:@"doorName"];
    return cell;
}

- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    selectedDoorID = _doorsIDList[indexPath.row];
    [self performSegueWithIdentifier:@"DoorDetails" sender:self];
    return indexPath;
}

-(void)setupData{
    __block int totalEntered = 0;
    _refHandle = [[[[_ref child:@"events"]child:_eventID]child:@"doors"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *postDict = snapshot.value;
        if(postDict != nil){
            [self->_doorsList removeAllObjects];
            [self->_doorsIDList removeAllObjects];
            
            for(id key in postDict){
                [self->_doorsList addObject:[postDict objectForKey:key]];
                [self->_doorsIDList addObject:key];
                totalEntered = [[[postDict objectForKey:key]objectForKey:@"entered"] intValue];
            }
            self->totalEnteredLbl.text = [@"Total Entered: " stringByAppendingString:[NSString stringWithFormat:@"%d", totalEntered]];
            
            [self->_MyDoorsTableView reloadData];
        }
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"AddDoor"]){
        AddDoorViewController *destinationVC = segue.destinationViewController;
        destinationVC.eventID = _eventID;
    }else if([segue.identifier isEqualToString:@"DoorDetails"]){
        DoorDetailViewController *destinationVC = segue.destinationViewController;
        destinationVC.eventID = _eventID;
        destinationVC.doorID = selectedDoorID;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
