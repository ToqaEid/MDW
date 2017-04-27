//
//  SpeakersViewController.m
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "SpeakersViewController.h"
#import "SWRevealViewController.h"


#import <AFNetworking.h>
#import <AFImageDownloader.h>
#import <UIImageView+AFNetworking.h>

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
    if(![VisitedViews getSpeakers]){
        
        [self.view makeToastActivity:CSToastPositionCenter];
        
        [model getSpeakersFromNetwork];
        
        [VisitedViews setSpeakers:YES];
        
    }else{
        
        speakers = [model getSpeakersFromDB];
        [self.tableView  reloadData];
        
    }

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
    
    description.text = speakerDTO.companyName;
    name.text = [NSString stringWithFormat:@"%@ %@ %@", speakerDTO.firstName, speakerDTO.middleName, speakerDTO.lastName];

    //icon.image = speakerDTO.imageUrl;
    
    
    NSString * imageUrl = [[speakers objectAtIndex:[indexPath row]] imageURL] ;
    imageUrl = [imageUrl stringByReplacingOccurrencesOfString:@"www."    withString:@""];
    //printf(">>>>>>>>>>>>>>>>>>>>>> %s\n", [imageUrl UTF8String]);
    
    
//    [icon setImageWithURL:[NSURL URLWithString: imageUrl  ]
//              placeholderImage:[UIImage imageNamed:@"mario.jpg"] ];
//    
   
    if (speakerDTO.imageURL)
    {
        [self setImageFromURLString:imageUrl intoImageView:icon andSaveObject:speakerDTO];
    }
    
    
    
    
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SpeakerDTO * speaker = [speakers objectAtIndex:indexPath.row];
    
    SpeakerDetailsViewController *speakerDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"SpeakerDetailsViewController"];
    
    //pass data to detailed view
    speakerDetails.speaker = speaker;
    
    
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
    [model getSpeakersFromNetwork];
    
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



-(void) setAllSpeakers : (NSMutableArray *) sp{

    
    printf("Setting SpeakersNSMutableArray .. \n");
    
    speakers = sp;
    [self.tableView  reloadData];
    
    //hide progress dialog
    [self.view hideToastActivity];
    [refreshControl endRefreshing];

    printf("Array Size is >> %lu\n", (unsigned long)[speakers count]);
    
    
    
}



-(void)showErrorToast : (NSString *)toastMsg{
    
    [self.view hideToastActivity];
    [self.view makeToast : toastMsg];
    
    
}





-(void)setImageFromURLString:(NSString *)url intoImageView:(UIImageView *)imageView andSaveObject:(id)object{


    printf("___________ setting image:: %s\n", [url UTF8String]);


    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        //NSLog(@"<<<<< %@ ++ %@", documentsDirectoryURL.path, [response suggestedFilename]);
        
        NSString * simage = @"Speaker_";
        simage = [simage stringByAppendingFormat:@"%d",   ((SpeakerDTO *)object).speakerId   ];
        
        return [documentsDirectoryURL URLByAppendingPathComponent: simage];
        
        
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        //Setting ImageView
        
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:filePath];
        UIImage *image = [UIImage imageWithData: imageData];
        imageView.image = image;
        
        
//        //Adding In DB
//        if([object isKindOfClass:[ExhibitorDTO class]]){
//            ((ExhibitorDTO *) object).image = imageData;
//            [[DBHandler getDB]- addOrUpdateExhibitor:object];
//        }else if ([object isKindOfClass:[SpeakerDTO class]]){
//            ((SpeakerDTO *) object).image = imageData;
//            [[DBHandler getDB] addOrUpdateSpeaker:object];
//        }
//        

    
    }];
    [downloadTask resume];
    

}




@end
