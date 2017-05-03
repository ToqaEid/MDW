//
//  MyInfoViewController.m
//  MDW
//
//  Created by JETS on 4/15/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "MyInfoViewController.h"

#import <AFNetworking.h>
#import <AFImageDownloader.h>
#import <UIImageView+AFNetworking.h>
#import "MDWServerURLs.h"

@implementation MyInfoViewController{
    MyContactModel * model;
    AttendeeDTO *user;
}


-(void)viewDidLoad{
    
    
    
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
    
    model = [MyContactModel new];
    
    [model getUserInfoFromUserDefault];
    
    user = [MyContactModel getUser];
    
    _myName.text = [NSString stringWithFormat:@"%@ %@ %@", user.firstName, user.middleName, user.lastName];
    _myTitle.text = user.title;
    _myCompany.text = user.companyName;
    
    printf("--- UserImageURL -- %s\n",  [user.imageURL UTF8String] );
    
    [self setImageFromURLString:  user.imageURL  intoImageView:_myImage];
    
    
}



-(void)setImageFromURLString:(NSString *)url intoImageView:(UIImageView *)imageView {
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        printf("Downloading profile Image 1.. \n");
        
        
        return [documentsDirectoryURL URLByAppendingPathComponent: @"profile"];
        
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        //Setting ImageView
        
        printf("Downloading profile Image 2.. \n");
        
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:filePath];
        UIImage *image = [UIImage imageWithData: imageData];
        
        NSData *imgData= UIImageJPEGRepresentation(image,0.1 );
        
        UIImage * compressedImage =[UIImage imageWithData:imgData];
        
        
        
        if(compressedImage == nil){
            imageView.image = [UIImage imageNamed:@"profile.png"];
        }else{
            imageView.image = compressedImage;
        }
        
    }];
    [downloadTask resume];
    
    
}







@end
