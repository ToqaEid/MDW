//
//  sessionDAO.m
//  REALM
//
//  Created by JETS on 4/13/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "sessionDAO.h"

@implementation sessionDAO
static sessionDAO* session=nil;
+(sessionDAO *)sharedInstance{
    if (session==nil) {
        session=[sessionDAO new];
    }
    return session;
}
-(BOOL)saveSessions:(NSMutableArray *)sessions{
    RLMRealm *realm=[RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObjects:sessions];
    [realm commitWriteTransaction];
    return YES;
}
-(RLMResults *)getAllSessions{
    RLMResults<SessionDTO*> *sessions=[SessionDTO allObjects];
    return sessions;
}
-(BOOL)clearAllDB{
    RLMRealm *realm=[RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
    return YES;
}

-(RLMResults *)getMySessions{
    RLMResults<SessionDTO*> *sessions=[SessionDTO objectsWhere:@"status==2"];
    return sessions;
}
-(RLMResults *)day1Sessions{
    
    RLMResults<SessionDTO*> *sessions=[SessionDTO objectsWhere:@"startDate >1492642800000 AND endDate <1492729200000"];
    return sessions;
}
-(RLMResults *)day2Sessions{
    
    RLMResults<SessionDTO*> *sessions=[SessionDTO objectsWhere:@"startDate >1492729200000 AND endDate <1492815600000"];
    return sessions;
}
-(RLMResults *)day3Sessions{
    
    RLMResults<SessionDTO*> *sessions=[SessionDTO objectsWhere:@"startDate >1492815600000 AND endDate <1492902000000"];
    return sessions;
}

@end
