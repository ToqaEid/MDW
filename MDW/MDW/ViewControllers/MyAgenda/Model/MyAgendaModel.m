//
//  MyAgendaModel.m
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "MyAgendaModel.h"

static NSMutableArray * dayAgenda;

@implementation MyAgendaModel{
    sessionDAO * sessionDao;
    MyAgenda* controller;
}

-(id)initWithController: (MyAgenda*) agendacontroller{
    sessionDao = [sessionDAO sharedInstance];
    controller = agendacontroller;
    dayAgenda = [NSMutableArray new];
    return [self init];
}

/*=======================Sessions from DB ========================*/
-(NSMutableArray*) getDay1SessionsFromDB{
    NSMutableArray * sessions = (NSMutableArray *)[sessionDao getMySessionsDay1];
    return sessions;
}
-(NSMutableArray*) getDay2SessionsFromDB{
    NSMutableArray * sessions = (NSMutableArray *)[sessionDao getMySessionsDay2];
    return sessions;
}
-(NSMutableArray*) getDay3SessionsFromDB{
    NSMutableArray * sessions = (NSMutableArray *)[sessionDao getMySessionsDay3];
    return sessions;
}
-(NSMutableArray*) getAllSessionsFromDB{
    NSMutableArray * sessions = (NSMutableArray *)[sessionDao getMySessions];
    return sessions;
    
}
-(void) saveAllSessionsInDB:(NSMutableArray *)sessions{
    
}
-(void) getAllSessionsFromNetwork{
    //////// GET ALL SESSTION FROM BACKEND
    
    AttendeeDTO * user = [NSUserDefaultForObject getObjectForKey:@"user"];
    
    NSString * sessionsURL =  [[MDWServerURLs getGetSessionsURL]  stringByAppendingString: user.email  ];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET: sessionsURL  parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
        //NSLog(@"JSON: %@", responseObject);
        
        [sessionDao clearAllDB];
        
        NSMutableArray *allSessions=[MDW_JsonParser getSessions_v2:responseObject];
        
        dayAgenda = allSessions;
        
        ///save into db
        [self saveAllSessionsInDB:dayAgenda];
        
        [controller setAllSessionsArray:allSessions];
        
        //
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        [controller showErrorToast : @"Please Check Network Connection"];
        
    }];
}

-(NSMutableArray*) getDay1SessionsFromNetwork{
    NSMutableArray * sessions = nil;
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
