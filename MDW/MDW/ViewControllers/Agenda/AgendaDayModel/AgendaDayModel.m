//
//  AgendaDayModel.m
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "AgendaDayModel.h"

@implementation AgendaDayModel{
    sessionDAO * sessionDao;
    AgendaDay* controller;
}

-(id)initWithController: (AgendaDay*) agendacontroller{
    sessionDao = [sessionDAO new];
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
-(NSMutableArray*) getAllSessionsFromNetwork{
    NSMutableArray * sessions = nil;
    return sessions;
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

-(BOOL)checkInternetConnection{
    return YES;
}@end
