//
//  MyAgenda.m
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "MyAgenda.h"

@implementation MyAgenda{
    
    NSMutableArray * dayAgenda;
    UIRefreshControl *refreshControl;
    UIActivityIndicatorView * indicator;    //progress dialog
    MyAgendaModel * model;
    
}

-(void)viewDidLoad{
    
    dayAgenda = [NSMutableArray new];
    
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
    model = [[MyAgendaModel alloc]initWithController:self];
    if([Connection checkInternetConnection]){
        
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
    
    //get data accorging the view controller
    if([self.restorationIdentifier isEqualToString:@"AgendaDay1"]){
        
        dayAgenda = [model getDay1SessionsFromNetwork];
        
    }else if([self.restorationIdentifier isEqualToString:@"AgendaDay2"]){
        
        dayAgenda = [model getDay2SessionsFromNetwork];
        
    }else if([self.restorationIdentifier isEqualToString:@"AgendaDay3"]){
        
        dayAgenda = [model getDay3SessionsFromNetwork];
        
    }else{
        
        dayAgenda = [model getAllSessionsFromNetwork];
        
    }
    //hide progress dialog
    [indicator stopAnimating];
    
    return dayAgenda;
}

-(NSMutableArray*)getSessionsFromDB{
    if([self.restorationIdentifier isEqualToString:@"AgendaDay1"]){
        dayAgenda = [model getDay1SessionsFromDB];
    }else if([self.restorationIdentifier isEqualToString:@"AgendaDay2"]){
        dayAgenda = [model getDay2SessionsFromDB];
    }else if([self.restorationIdentifier isEqualToString:@"AgendaDay3"]){
        dayAgenda = [model getDay3SessionsFromDB];
    }else{
        dayAgenda = [model getAllSessionsFromDB];
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
        
    AgendaDetailsViewController *agendaDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"AgendaDetailsViewController"];
    
    agendaDetails.sessionTitle = session.name;
    agendaDetails.sessionDate = [DateConverter dayStringFromDate: session.startDate];
    agendaDetails.sessionTime = [NSString stringWithFormat:@"%@ - %@", [DateConverter stringFromDate: session.startDate] , [DateConverter stringFromDate: session.endDate]] ;
    agendaDetails.sessionDetails = session.SessionDescription;
    
    [self.navigationController presentViewController:agendaDetails animated:YES completion:nil];
    
}

/* ============================= Refresh Table =============================*/
-(void) refreshMytableView{
    
    [dayAgenda addObject:@"hello"];
    
    //get Data
    if([Connection checkInternetConnection]){
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
