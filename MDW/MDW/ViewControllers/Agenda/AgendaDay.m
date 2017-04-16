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

}

-(void)viewDidLoad{
    
    dayAgenda = [NSMutableArray new];
    
    //testing block
    [dayAgenda addObject:@"hello1"];
    [dayAgenda addObject:@"hello2"];
    //set background image
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.png"]];
    
    
    self.tableView.tableHeaderView = [self.view viewWithTag:6];
    
    
    
   // self.tableView = [[UITableView alloc]initWithFrame:self.tableView.frame style:UITableViewStylePlain];
    
    
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
}

-(void) refreshMytableView
{
    
    [dayAgenda addObject:@"hello"];
    [self.tableView  reloadData];
    [refreshControl endRefreshing];
    
}

-(void) getDayAgendaArray :(NSMutableArray*) agenda{
    dayAgenda = agenda;
}

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
    UILabel * description = [cell viewWithTag:3];
    UILabel * date = [cell viewWithTag:4];
    
    //fill fields in the cell with data
    
    if([self.restorationIdentifier isEqualToString:@"AgendaDay1"] ){
        
        NSString * htmlString = @"<Font name=\"verdana\" size=\"4\" color=\"Blue\">Registration</Font>";
        description.text = [dayAgenda objectAtIndex:indexPath.row];
        
        name.attributedText = [self renderHTML:htmlString];
        
    }else{
        name.text = @"hello";
    }
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    UIView * headerView = [self.view viewWithTag:6];
//    return headerView;
//}

-(NSAttributedString*) renderHTML:(NSString*) htmlString{
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    
    return attrStr;
}
@end