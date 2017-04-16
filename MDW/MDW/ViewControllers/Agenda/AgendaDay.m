//
//  AgendaDay1.m
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "AgendaDay.h"


@implementation AgendaDay{

    NSMutableArray * dayAgenda;
    UIRefreshControl *refreshControl;
    AgendaDayController * controller;
    UIActivityIndicatorView * indicator;    //progress dialog

}

-(void)viewDidLoad{
    
    dayAgenda = [NSMutableArray new];
    
    //testing block
    [dayAgenda addObject:@"hello1"];
    [dayAgenda addObject:@"hello2"];
    
    //set background image
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    //refresh table
    [self prepareRefreshControlForTableView];

    
    //side menu
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                     style:UIBarButtonItemStylePlain
                                                                     target:revealViewController
                                                                     action:@selector(revealToggle:)];
        

        self.navigationItem.leftBarButtonItem = revealButtonItem;	

        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    //getData
    controller = [[AgendaDayController alloc]initWithView:self];
    if([controller checkInternetConnection]){
        indicator = [self showProgressDialog];
        [indicator startAnimating];
        [self getSessionsFromNetwork];
        printf("Agenda View : checkInternetConnection\n");
    }else{
        [self getSessionsFromDB];
        printf("Agenda View : !checkInternetConnection\n");
    }
}

/*====================== DATA =================================*/



-(NSMutableArray*)getSessionsFromNetwork{
    if([self.restorationIdentifier isEqualToString:@"AgendaDay1"]){
        dayAgenda = [controller getDay1SessionsFromNetworkFromModel];
    }else if([self.restorationIdentifier isEqualToString:@"AgendaDay2"]){
        dayAgenda = [controller getDay2SessionsFromNetworkFromModel];
    }else if([self.restorationIdentifier isEqualToString:@"AgendaDay3"]){
        dayAgenda = [controller getDay3SessionsFromNetworkFromModel];
    }else{
        dayAgenda = [controller getAllSessionsFromNetworkFromModel];
    }
    [indicator stopAnimating];
    return dayAgenda;
}

-(NSMutableArray*)getSessionsFromDB{
    if([self.restorationIdentifier isEqualToString:@"AgendaDay1"]){
        dayAgenda = [controller getDay1SessionsFromDBFromModel];
    }else if([self.restorationIdentifier isEqualToString:@"AgendaDay2"]){
        dayAgenda = [controller getDay2SessionsFromDBFromModel];
    }else if([self.restorationIdentifier isEqualToString:@"AgendaDay3"]){
        dayAgenda = [controller getDay3SessionsFromDBFromModel];
    }else{
        dayAgenda = [controller getAllSessionsFromDBFromModel];
    }
    return dayAgenda;
}

/*======================== Progress Dialog =========================*/
-(UIActivityIndicatorView *) showProgressDialog{
    UIActivityIndicatorView *indicator1 = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator1.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator1.center = self.view.center;
    [self.view addSubview:indicator1];
    [indicator1 bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    return indicator1;
}
/*============================= Table View ==============================*/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 3;
    return dayAgenda.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //set cell color to clear
    [cell setBackgroundColor: [UIColor clearColor]];
    
    
    //intialize fields in the cell
    UIImageView * icon = [cell viewWithTag:1];
    UILabel * name = [cell viewWithTag:2];
    UILabel * location = [cell viewWithTag:3];
    UILabel * date = [cell viewWithTag:4];
    
    //fill fields in the cell with data
    SessionDTO * session = [dayAgenda objectAtIndex:indexPath.row];
    name.attributedText = [LabelRendering renderHTML:session.name];
    location.text = session.location;
    
   
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SessionDTO * session = [dayAgenda objectAtIndex:indexPath.row];
    
    AgendaDetailsViewController * agendaDetails = [AgendaDetailsViewController new];
    
    agendaDetails.sessionTitle = session.name;
    agendaDetails.sessionDate = [DateConverter dayStringFromDate: session.startDate];
    agendaDetails.sessionTime = [NSString stringWithFormat:@"%@ - %@", [DateConverter stringFromDate: session.startDate] , [DateConverter stringFromDate: session.endDate]] ;
    agendaDetails.sessionDetails = session.SessionDescription;
    
    [self presentViewController:agendaDetails animated:YES completion:nil];
    
}

-(void) refreshMytableView{
    
    [dayAgenda addObject:@"hello"];
    
    //get Data
    if([controller checkInternetConnection]){
        [self getSessionsFromNetwork];
        printf("Agenda View : checkInternetConnection\n");
    }
    
    [self.tableView  reloadData];
    [refreshControl endRefreshing];
    
}

-(void) prepareRefreshControlForTableView{
    
    refreshControl=[[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(refreshMytableView)
             forControlEvents:UIControlEventValueChanged];
    refreshControl.tintColor = [UIColor whiteColor];
    refreshControl.backgroundColor = [UIColor orangeColor];
    [self.tableView addSubview:refreshControl];
}

@end
