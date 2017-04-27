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
    exhiptorDAO * exhibitor;
    
}

-(id)initWithController: (ExhibitorsViewController*) exhibitorController{
    
    controller = exhibitorController;
    exhibitor = [exhiptorDAO sharedInstance];
    return [self init];
}

-(void) getExhibitorsFromNetwork{

    AttendeeDTO * user = [NSUserDefaultForObject getObjectForKey:@"user"];
    NSString * exhibitorssURL =  [[MDWServerURLs getGetExhibitorsURL]  stringByAppendingString: user.email  ];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET: exhibitorssURL  parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        printf("Exhibitors Response recieved ... \n");
        
        NSMutableArray * allExhibitors  =  [MDW_JsonParser getExhibitors_v2:responseObject];
        
        [controller setAllExhibitors: allExhibitors];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
    
    
    
}
-(NSMutableArray *) getExhibitorsFromDB{
    return (NSMutableArray*)[exhibitor getAllExhiptors];
}

@end
