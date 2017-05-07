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
    AgendaDayModel * model;
    UIActivityIndicatorView * indicator;    //progress dialog

}



-(void)dealloc{
    printf("********agenda dealloc*********\n");
    
}


-(void)viewDidLoad{
    
    dayAgenda = [NSMutableArray new];
    model = [[AgendaDayModel alloc]initWithController:self];

    
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
    
//    if(![VisitedViews getAgenda]){
        //getData
        [self.view makeToastActivity:CSToastPositionCenter];
        
        [model getAllSessions : NO : nil];
        
//        [VisitedViews setAgenda : YES];
//    }else{
//        
//        if([self.restorationIdentifier isEqualToString:@"AgendaAll"]){
//            dayAgenda = [model getAllSessionsFromDB];
//        }else{
//            [self getSessionsFromDB];
//        }
//        
//        
//        NSLog(@"getSessionsFromDB");
//
//    }
    [self.tableView reloadData];

}

/*====================== DATA =================================*/

-(void)getSessions{
    
    //get data accorging the view controller
    if([self.restorationIdentifier isEqualToString:@"AgendaDay1"]){
        
        dayAgenda = [model getDay1SessionsFromDB];
        
    }else if([self.restorationIdentifier isEqualToString:@"AgendaDay2"]){
        
        dayAgenda = [model getDay2SessionsFromDB];
        
    }else if([self.restorationIdentifier isEqualToString:@"AgendaDay3"]){
        
        dayAgenda = [model getDay3SessionsFromDB];
        
        
    }else{
        
       dayAgenda = [model getAllSessionsFromDB];
        
    }
    
}
-(void) getSessionsFromDB{
    //get data accorging the view controller
    if([self.restorationIdentifier isEqualToString:@"AgendaDay1"]){
        NSLog(@"getSessionsFromDB AgendaDay1");
        dayAgenda = [model getDay1SessionsFromDB];
        
    }else if([self.restorationIdentifier isEqualToString:@"AgendaDay2"]){
        NSLog(@"getSessionsFromDB AgendaDay2");

        dayAgenda = [model getDay2SessionsFromDB];
        
    }else if([self.restorationIdentifier isEqualToString:@"AgendaDay3"]){
        NSLog(@"getSessionsFromDB AgendaDay3");

        dayAgenda = [model getDay3SessionsFromDB];
        
    }
    
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
    
    printf("\nsession %s\n", [session.description UTF8String]);
    
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
    [model getAllSessions: YES : self.restorationIdentifier];
    
}

-(void) endRefresh : (NSMutableArray *) dayAgenda1 : (NSString *) viewID{
    if([viewID isEqualToString: @"AgendaAll"]){
        NSLog(@"allday");
        dayAgenda = dayAgenda1;
    }else{
        [self getSessionsFromDB];
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
