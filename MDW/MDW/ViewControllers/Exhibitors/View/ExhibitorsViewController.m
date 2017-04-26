//
//  ExhibitorsViewController.m
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "ExhibitorsViewController.h"
#import "SWRevealViewController.h"

@implementation ExhibitorsViewController{
    
    NSMutableArray * exibitors;
    UIRefreshControl *refreshControl;
    ExhibitorModel * model;
    
}

-(void)viewDidLoad{
    
    //intialize model
    model =[[ExhibitorModel alloc]initWithController:self];
    
    exibitors = [NSMutableArray new];
    
    //set background image
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //refresh table
    
    refreshControl=[[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(refreshMytableView)
             forControlEvents:UIControlEventValueChanged];
    refreshControl.tintColor = [UIColor whiteColor];
    refreshControl.backgroundColor = [UIColor orangeColor];
    [self.tableView addSubview:refreshControl];
    
    
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
    
    
    
    ///////////////// get data to populate tableView
    if(![VisitedViews getExhibitors]){

        [self.view makeToastActivity:CSToastPositionCenter];

        [model getExhibitorsFromNetwork];
        [VisitedViews setExhibitors:YES];
    }else{
        exibitors = [model getExhibitorsFromDB];
    }
    
}



-(void) refreshMytableView
{
    
    [self.tableView  reloadData];
    [refreshControl endRefreshing];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return exibitors.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //set cell color to clear
    [cell setBackgroundColor: [UIColor clearColor]];
    
    
    //intialize fields in the cell
    UIImageView * icon = [cell viewWithTag:1];
    UILabel * name = [cell viewWithTag:2];
    
    //fill fields in the cell with data
    ExhiptorsDTO * exhibitor = [exibitors objectAtIndex:indexPath.row];

    icon.image = [[UIImage alloc]initWithData:exhibitor.image];
    name.text = exhibitor.companyName;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExhiptorsDTO * exhibitor = [exibitors objectAtIndex:indexPath.row];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: exhibitor.companyURL]];
}

-(NSAttributedString*) renderHTML:(NSString*) htmlString{
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    
    return attrStr;
}


-(void)setAllExhibitors:(NSMutableArray *)exhibitors{

    exibitors = exhibitors;
    [self.tableView reloadData];
    
    //hide progress dialog
    [self.view hideToastActivity];


}

@end
