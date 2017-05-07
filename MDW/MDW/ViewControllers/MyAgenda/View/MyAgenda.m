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
    //}
}

-(void)viewWillAppear:(BOOL)animated{

    

    //    if([Connection checkInternetConnection]){
    //
    //        indicator = [self showProgressDialog];
    //        [indicator startAnimating];
    //
    //        [self getSessionsFromNetwork];
    //
    //        printf("Agenda View : checkInternetConnection\n");
    //
    //    }else{
    
    [self getSessionsFromDB];
    
    [self.tableView reloadData];
    printf("Agenda View : !checkInternetConnection\n");

    
}
/*====================== DATA =================================*/

-(NSMutableArray*)getSessionsFromNetwork{
    
    //get data accorging the view controller
    if([self.restorationIdentifier isEqualToString:@"MyAgendaDay1"]){
        
        dayAgenda = [model getDay1SessionsFromDB];
        
    }else if([self.restorationIdentifier isEqualToString:@"MyAgendaDay2"]){
        
        dayAgenda = [model getDay2SessionsFromDB];
        
    }else if([self.restorationIdentifier isEqualToString:@"MyAgendaDay3"]){
        
        dayAgenda = [model getDay3SessionsFromDB];
        
    }else{
        
        [model getAllSessionsFromNetwork];
        
    }
    //hide progress dialog
    [indicator stopAnimating];
    
    return dayAgenda;
}

-(NSMutableArray*)getSessionsFromDB{
    if([self.restorationIdentifier isEqualToString:@"MyAgendaDay1"]){
        dayAgenda = [model getDay1SessionsFromDB];
    }else if([self.restorationIdentifier isEqualToString:@"MyAgendaDay2"]){
        dayAgenda = [model getDay2SessionsFromDB];
    }else if([self.restorationIdentifier isEqualToString:@"MyAgendaDay3"]){
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
    UILabel * dateImage = [cell viewWithTag:7];
    
    //fill fields in the cell with data
    SessionDTO * session = [dayAgenda objectAtIndex:indexPath.row];
    name.attributedText = [LabelRendering renderHTML:session.name];
    location.text = session.location;
    date.text = [NSString stringWithFormat:@"%@ - %@", [DateConverter stringFromDate:session.startDate], [DateConverter stringFromDate:session.endDate]];
    //image
    UIImage * sessionImage = [AgendaImages getSessionImage:session];
    if( sessionImage != nil){
        icon.image = sessionImage;
    }
    //date in image
    if([session.sessionType isEqualToString:@"Break"]){
        dateImage.text = @"";
    }else{
        dateImage.text = [DateConverter dayStringFromDate:session.startDate];
    }
    
    

    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SessionDTO * session = [dayAgenda objectAtIndex:indexPath.row];
        
    AgendaDetailsViewController *agendaDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"AgendaDetailsViewController"];
    agendaDetails.session = session;
   
    agendaDetails.hidesBottomBarWhenPushed = YES;
    
    
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@"MDW"
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    [self.navigationController pushViewController:agendaDetails animated:YES ];

    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
/* ============================= Refresh Table =============================*/
-(void) refreshMytableView{
    
    //get Data
    [self getSessionsFromNetwork];
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




-(void) setAllSessionsArray : (NSMutableArray* ) sessions{
    
    
    //printf("Setting SessionNSMutableArray .. \n");
    
    dayAgenda = sessions;
    [self.tableView  reloadData];
    
    //hide progress dialog
    [self.view hideToastActivity];
    
    //printf("Array Size is >> %lu\n", (unsigned long)[dayAgenda count]);
    
    
    //    [self refreshMytableView];
    
}


-(void)showErrorToast : (NSString *)toastMsg{
    
    [self.view hideToastActivity];
    [self.view makeToast : toastMsg];
    
    if([self.restorationIdentifier isEqualToString:@"AgendaAll"]){
        dayAgenda = [model getAllSessionsFromDB];
    }else{
        [self getSessionsFromDB];
    }
    
    
    
}

@end
