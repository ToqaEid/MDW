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
    
    NSMutableArray * speakers;
    UIRefreshControl *refreshControl;
    
}

-(void)viewDidLoad{
    
    speakers = [NSMutableArray new];
    
    //testing block
    [speakers addObject:@"Eman"];
    [speakers addObject:@"Ahmed"];
    //set background image
    //self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.png"]];
    
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
    
    [speakers addObject:@"hello"];
    [self.tableView  reloadData];
    [refreshControl endRefreshing];
    
}

-(void) getExhibitorssArray :(NSMutableArray*) speakersArr{
    speakers = speakersArr;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return 3;
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
    
    //fill fields in the cell with data
    
    NSString * htmlString = @"<Font name=\"verdana\" size=\"4\" color=\"Blue\">Registration</Font>";
    
    name.attributedText = [self renderHTML:htmlString];
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

-(NSAttributedString*) renderHTML:(NSString*) htmlString{
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    
    return attrStr;
}
@end
