//
//  SpeakersViewController.m
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "SpeakersViewController.h"
#import "SWRevealViewController.h"

@implementation SpeakersViewController{
    
    NSMutableArray * speakers;
    UIRefreshControl *refreshControl;
    SpeakersModel * model;
    UIActivityIndicatorView * indicator;    //progress dialog
    
    
}

-(void)viewDidLoad{
    
    //intialize model
    model =[[SpeakersModel alloc]initWithController:self];
    
    speakers = [NSMutableArray new];
    
    //navigation bar
    
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
    [self getInitialData];
}

-(void) getInitialData{
    if([Connection checkInternetConnection]){
        
        indicator = [self showProgressDialog];
        [indicator startAnimating];
        
        speakers = [model getSpeakersFromNetwork];
        printf("%lu\n", (unsigned long)speakers.count);
        [self.tableView  reloadData];
        
        [indicator stopAnimating];
        printf("Speakers View : checkInternetConnection\n");
        
    }else{
        
        speakers = [model getSpeakersFromDB];
        [self.tableView  reloadData];
        //TODO : toast with check your connection
        printf("Speakers View : !checkInternetConnection\n");
        
    }

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
/*================================ Table View ========================================*/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return speakers.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //set cell color to clear
    [cell setBackgroundColor: [UIColor clearColor]];
    
    
    //intialize fields in the cell
    UIImageView * icon = [cell viewWithTag:1];
    UILabel * name = [cell viewWithTag:2];
    UILabel * description = [cell viewWithTag:3];
    
    //fill fields in the cell with data
    SpeakerDTO * speakerDTO = [speakers objectAtIndex:indexPath.row];
    
    //icon.image = speakerDTO.imageUrl;
    description.text = speakerDTO.companyName;
    name.text = [NSString stringWithFormat:@"%@ %@ %@", speakerDTO.firstName, speakerDTO.middleName, speakerDTO.lastName];
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SpeakerDTO * speaker = [speakers objectAtIndex:indexPath.row];
    
    SpeakerDetailsViewController *speakerDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"SpeakerDetailsViewController"];
    
    //pass data to detailed view
    
    //speakerDetails.speakerImage = speaker.imageUrl;
    speakerDetails.speakerName = [NSString stringWithFormat:@"%@ %@ %@", speaker.firstName, speaker.middleName, speaker.lastName];
    speakerDetails.speakerJob = speaker.title;
    speakerDetails.speakerCompany = speaker.companyName;
    
    
    
    //open detailed view
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@"MDW"
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    [self.navigationController pushViewController:speakerDetails animated:YES ];
    
}

-(NSAttributedString*) renderHTML:(NSString*) htmlString{
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    
    return attrStr;
}

/* ============================= Refresh Table =============================*/
-(void) refreshMytableView{
    
    
    //get Data
    if([Connection checkInternetConnection]){
        speakers = [model getSpeakersFromNetwork];
        printf("Speakers View : checkInternetConnection\n");
    }else{
        //TODO: add toast with check internet connection
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
