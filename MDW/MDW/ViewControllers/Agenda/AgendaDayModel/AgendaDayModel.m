//
//  AgendaDayModel.m
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "AgendaDayModel.h"

#import <AFNetworking.h>
#import <AFImageDownloader.h>
#import <UIImageView+AFNetworking.h>
#import "MDWServerURLs.h"
#import "MDW_JsonParser.h"
#import "SessionDTO.h"

@implementation AgendaDayModel{
    sessionDAO * sessionDao;
    AgendaDay* controller;
}

-(id)initWithController: (AgendaDay*) agendacontroller{
    sessionDao = [sessionDAO sharedInstance];
    controller = agendacontroller;
    return [self init];
}

/*=======================Sessions from DB ========================*/
-(NSMutableArray*) getDay1SessionsFromDB{
    NSMutableArray * sessions = (NSMutableArray *)[sessionDao getAllSessions];
    return sessions;
}
-(NSMutableArray*) getDay2SessionsFromDB{
    NSMutableArray * sessions = nil;
    return sessions;
}
-(NSMutableArray*) getDay3SessionsFromDB{
    NSMutableArray * sessions = nil;
    return sessions;
}
-(NSMutableArray*) getAllSessionsFromDB{
    NSMutableArray * sessions = nil;
    return sessions;

}
-(void) saveAllSessionsInDB:(NSMutableArray *)sessions{
    
}






-(void) getAllSessions : (NSString *) username{

    //////// GET ALL SESSTION FROM BACKEND

    NSString * sessionsURL =  [[MDWServerURLs getGetSessionsURL]  stringByAppendingString: username  ];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET: sessionsURL  parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
    
        
        //NSLog(@"JSON: %@", responseObject);
        printf("Response recieved ... \n");
        
        NSMutableArray * allSessions  =  [MDW_JsonParser getSessions_v2 : responseObject];
        
        [controller setAllSessionsArray:allSessions];
//        
//        printf(">>>---- AllSessions are ====== %lu",  (unsigned long)[allSessions count] );
//        for (int i=0; i<[allSessions count]; i++){
//            
//                SessionDTO * sessionObj = [allSessions objectAtIndex:i];
//               printf("***  %s\n", [sessionObj.name UTF8String]);
//            
//            }
    
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
            
        }];
    
    

}







-(NSMutableArray*) getAllSessionsFromNetwork{
    NSMutableArray * sessions = nil; //(NSMutableArray *)[sessionDao getAllSessions];
//    return sessions;
//    [sessionDao clearAllDB];
//    NSMutableArray * sessions = [NSMutableArray new];
//    SessionDTO * session = [SessionDTO new];
//    session.sessionId = 2;
//    session.name = @"session1";
//    session.sessionType = @"Break";
//    session.SessionDescription = @"sdfg";
//    [sessions addObject:session];
//    [sessionDao saveSessions:sessions];
    return sessions;
}

-(NSMutableArray*) getDay1SessionsFromNetwork{
    NSMutableArray * sessions = (NSMutableArray *)[sessionDao getAllSessions];
    return sessions;
}

-(NSMutableArray*) getDay2SessionsFromNetwork{
    NSMutableArray * sessions = nil;
    return sessions;
}

-(NSMutableArray*) getDay3SessionsFromNetwork{
    NSMutableArray * sessions = nil;
    return sessions;
}

@end
