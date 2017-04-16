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
@end
