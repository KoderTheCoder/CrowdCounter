//
//  MyEventsViewController.m
//  CrowdCounter
//
//  Created by Koder on 16/5/18.
//  Copyright © 2018 Koder_6042. All rights reserved.
//

#import "MyEventsViewController.h"
#import "EventHomePageViewController.h"
@import Firebase;

@interface MyEventsViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MyEventsViewController

@synthesize selectedEventID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _eventList = [[NSMutableArray alloc] init];
    _eventIDList = [[NSMutableArray alloc] init];
    _ref = [[FIRDatabase database] reference];
    
    
    
    [self setupData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITablView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _eventList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyEventCell"];
    cell.textLabel.text = [_eventList[indexPath.row] objectForKey:@"eventName"];
    cell.detailTextLabel.text = [_eventList[indexPath.row] objectForKey:@"eventCode"];
    return cell;
}

- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    selectedEventID = _eventIDList[indexPath.row];
    [self performSegueWithIdentifier:@"ShowEvent" sender:self];
    return indexPath;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    EventHomePageViewController *destinationVC = segue.destinationViewController;
    destinationVC.eventID = selectedEventID;
}

-(void)setupData{
    _refHandle = [[_ref child:@"events"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *postDict = snapshot.value;
        [self->_eventList removeAllObjects];
        [self->_eventIDList removeAllObjects];
        
        for(id key in postDict){
            if([[[postDict objectForKey:key] objectForKey:@"owner"]isEqualToString:[[[FIRAuth auth] currentUser]uid]]){
                [self->_eventList addObject:[postDict objectForKey:key]];
                [self->_eventIDList addObject:key];
            }else{
                for(id membersKey in [[postDict objectForKey:key]objectForKey:@"members"]){
                    if([membersKey isEqualToString:[[[FIRAuth auth] currentUser] uid]]){
                        [self->_eventList addObject:[postDict objectForKey:key]];
                        [self->_eventIDList addObject:key];
                        break;
                    }
                }
            }
        }
        [self->_eventsTableView reloadData];
    }];
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
