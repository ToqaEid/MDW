//
//  ExhibitorsViewController.m
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "ExhibitorsViewController.h"
#import "SWRevealViewController.h"
#import <AFNetworking.h>
#import <AFImageDownloader.h>
#import <UIImageView+AFNetworking.h>
#import "speakerDAO.h"

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
    
    
    
    ///////////////// get data to populate tableView
    if(![VisitedViews getExhibitors]){

        [self.view makeToastActivity:CSToastPositionCenter];

        [model getExhibitorsFromNetwork];
        [VisitedViews setExhibitors:YES];
    }else{
        exibitors = [model getExhibitorsFromDB];
    }
    
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

    //icon.image = [[UIImage alloc]initWithData:exhibitor.image];
    name.text = exhibitor.companyName;
    
    
    
    if ( exhibitor.image == nil ){
        
        icon.image = [UIImage imageNamed:@"exhibitorsImage.png"];
        
    }else{
        
        icon.image = [UIImage imageWithData: exhibitor.image  ];
        
    }
    
      return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ExhiptorsDTO * exhibitor = [exibitors objectAtIndex:indexPath.row];
    if(![exhibitor.companyURL isEqualToString: @""]){
    
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: exhibitor.companyURL]];
    }else{
        [self.view makeToast:@"No Avaliable URL"];
    }
    
    
}

-(NSAttributedString*) renderHTML:(NSString*) htmlString{
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    
    return attrStr;
}

/* ============================= Refresh Table =============================*/
-(void) refreshMytableView{
    
    //get Data
    [model getExhibitorsFromNetwork];
    
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


-(void)setAllExhibitors:(NSMutableArray *)exhibitors{

    exibitors = exhibitors;
    [self.tableView reloadData];
    
    //hide progress dialog
    [self.view hideToastActivity];
    [refreshControl endRefreshing];


}




//
//-(void)setImageFromURLString:(NSString *)url intoImageView:(UIImageView *)imageView andSaveObject:(id)object{
//    
//    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    
//    NSURL *URL = [NSURL URLWithString:url];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        
//        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        
//        NSString * simage = @"Exh_";
//        simage = [simage stringByAppendingFormat:@"%d",   ((ExhiptorsDTO *)object).exhiptorId   ];
//        
//        return [documentsDirectoryURL URLByAppendingPathComponent: simage];
//        
//        
//        
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        
//        //Setting ImageView
//        
//        NSData *imageData = [[NSData alloc] initWithContentsOfURL:filePath];
//        UIImage *image = [UIImage imageWithData: imageData];
//        
//        NSData *imgData= UIImageJPEGRepresentation(image,0.1 /*compressionQuality*/);
//        
//        UIImage * compressedImage =[UIImage imageWithData:imgData];
//        
//        imageView.image = compressedImage;
//        
//        
//        
//        
//        //Adding ImageToDb
////        ExhiptorsDTO * exhibitor =  ((ExhiptorsDTO *) object);
////        exhibitor.image = imageData;
////        
////        RLMRealm *realm=[RLMRealm defaultRealm];
////        printf("%s",[realm.configuration.fileURL.absoluteString UTF8String]);
////        ExhiptorsDTO * currExh = [ExhiptorsDTO objectForPrimaryKey:[[NSNumber alloc] initWithInt: exhibitor.exhiptorId ]];
////        [realm beginWriteTransaction];
////        currExh.image=imageData;
////        [realm addOrUpdateObject:currExh];
////        [realm commitWriteTransaction];
////        
////        
////        [self.tableView  reloadData];
//        
//    }];
//    [downloadTask resume];
//    
//    
//}





@end
