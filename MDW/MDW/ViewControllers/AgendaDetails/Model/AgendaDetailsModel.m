//
//  AgendaDetailsModel.m
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "AgendaDetailsModel.h"
#import <AFNetworking.h>
#import <AFImageDownloader.h>
#import <UIImageView+AFNetworking.h>
#import "MDWServerURLs.h"
#import "MDW_JsonParser.h"

@implementation AgendaDetailsModel{
    AgendaDetailsViewController* controller;
}

-(id)initWithController: (AgendaDetailsViewController*) agendaCont{
    controller = agendaCont ;
    return [self init];
}

-(void)registerSessionWithSessionObj : (SessionDTO*)session  AndEnforce : (BOOL) enforce{
    
    ///register using network
        //if network returned error show error toast
    
    NSString * username = @"toqa.eid@gmail.com";
    
    NSMutableString * registerUrl = [[NSMutableString alloc] initWithString:[MDWServerURLs getRegisterSessionURL]];
    [registerUrl appendString:username];
//    
    [registerUrl appendString:@"&sessionId="];
    [registerUrl appendString: [NSString stringWithFormat:@"%d", session.sessionId ] ];

    
    [registerUrl appendString:@"&enforce="];
    [registerUrl appendString:[[ NSString alloc] initWithFormat:@"%s", enforce? "true" : "false" ]];
   
    [registerUrl appendString:@"&status="];
    [registerUrl appendString: [NSString stringWithFormat:@"%d", session.status ] ];
    
    printf("\n>> SessionRegister URL is %s\n", [registerUrl UTF8String]);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET: [NSString stringWithString:registerUrl]  parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        printf("SessionResponse recieved ... \n");
        
        
        NSMutableDictionary * result = [MDW_JsonParser getSesstionRegisterationStatus:responseObject];
        
        printf("^^^ old = %d , status = %d\n",  [[result objectForKey:@"oldSession"]intValue], [[result objectForKey:@"status"]intValue] );
        
        [controller setStatusFromServer:result];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        NSString * error1 = @"hello";
        [controller showToast : error1];
        

        
    }];


}


-(void)unregisterSession : (SessionDTO*) session{
    ///register using network
    //if network returned error show error toast
    NSString * error;
    [controller showToast : error];
    //if no error save in db
}

@end
