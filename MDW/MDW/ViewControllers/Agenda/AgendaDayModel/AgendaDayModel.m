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

static NSMutableArray * dayAgenda;

@implementation AgendaDayModel{
    sessionDAO * sessionDao;
    AgendaDay* controller;
    
    
}

-(id)initWithController: (AgendaDay*) agendacontroller{
    sessionDao = [sessionDAO sharedInstance];
    controller = agendacontroller;
    dayAgenda = [NSMutableArray new];
    return [self init];
}

/*=======================Sessions from DB ========================*/
-(NSMutableArray*) getDay1SessionsFromDB{
    NSMutableArray * sessions = (NSMutableArray *)[sessionDao day1Sessions];
    NSLog(@"sessions : %lu\n", (unsigned long)sessions.count);
    return sessions;
}
-(NSMutableArray*) getDay2SessionsFromDB{
    NSMutableArray * sessions = (NSMutableArray *)[sessionDao day2Sessions];
    NSLog(@"sessions : %lu\n", (unsigned long)sessions.count);
    return sessions;
}
-(NSMutableArray*) getDay3SessionsFromDB{
    NSMutableArray * sessions = (NSMutableArray *)[sessionDao day3Sessions];
    NSLog(@"sessions : %lu\n", (unsigned long)sessions.count);
    return sessions;
}
-(NSMutableArray*) getAllSessionsFromDB{
    NSMutableArray * sessions = (NSMutableArray *)[sessionDao getAllSessions];
    NSLog(@"sessions : %lu\n", (unsigned long)sessions.count);
    return sessions;

}
-(void) saveAllSessionsInDB:(NSMutableArray *)sessions{
    [sessionDao saveSessions:sessions];
}


-(void) getAllSessions : (BOOL)refresh : (NSString *) viewID{

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
        if(!refresh){
           [controller setAllSessionsArray:dayAgenda];

        }else{
           [controller endRefresh:dayAgenda : viewID];
        }
        
//        [controller setAllSessionsArray:allSessions];

//
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
            [controller showErrorToast : @"Please Check Network Connection"];
            
        }];

}


-(NSMutableArray*) filterArrayAccordingToDate : (long) date{
    NSPredicate * sessionDatePredicate = [NSPredicate predicateWithFormat:@"SELF.startDate == %ll", date];
    NSMutableArray * filteredArr = (NSMutableArray*) [dayAgenda filteredArrayUsingPredicate : sessionDatePredicate];
    return filteredArr;
}
@end
