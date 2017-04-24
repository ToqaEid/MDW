//
//  ExhibitorModel.m
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "ExhibitorModel.h"
#import <AFNetworking.h>
#import <AFImageDownloader.h>
#import <UIImageView+AFNetworking.h>
#import "MDWServerURLs.h"
#import "MDW_JsonParser.h"

@implementation ExhibitorModel{

     ExhibitorsViewController * controller;
    
}

-(id)initWithController: (ExhibitorsViewController*) exhibitorController{
    
    controller = exhibitorController;
    return [self init];
}

-(void) getExhibitorsFromNetwork : (NSString *) username{


    NSString * exhibitorssURL =  [[MDWServerURLs getGetExhibitorsURL]  stringByAppendingString: username  ];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET: exhibitorssURL  parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        printf("Exhibitors Response recieved ... \n");
        
        NSMutableArray * allExhibitors  =  [MDW_JsonParser getExhibitors_v2:responseObject];
        
       // [controller setAllSpeakers:allSpeakers];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
    
    
    
}


@end
