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
-(BOOL)updateSession:(SessionDTO *)session{
    RLMRealm *realm=[RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:session];
    [realm commitWriteTransaction];
    return YES;
}
-(BOOL)saveSessions:(NSMutableArray *)sessions{
    RLMRealm *realm=[RLMRealm defaultRealm];
    printf("%s",[realm.configuration.fileURL.absoluteString UTF8String]);
    [realm beginWriteTransaction];
    [realm addOrUpdateObjectsFromArray:sessions];
    [realm commitWriteTransaction];
    return YES;
}
-(RLMResults *)getAllSessions{
    RLMResults<SessionDTO*> *sessions=[SessionDTO allObjects];
    return sessions;
}
-(BOOL)addSpeaker:(SpeakerDTO *)speaker{
    RLMRealm *realm=[RLMRealm defaultRealm];
    printf("%s",[realm.configuration.fileURL.absoluteString UTF8String]);
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:speaker];
    [realm commitWriteTransaction];
    return YES;
}
-(BOOL)clearAllDB{
    RLMRealm *realm=[RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
    return YES;
}

-(RLMResults *)getMySessionsDay1{
    RLMResults<SessionDTO*> *sessions=[SessionDTO objectsWhere:@"startDate >1492642800000 AND endDate <1492729200000 AND (status==2 OR status==1) "];
    return sessions;
}
-(RLMResults *)getMySessionsDay2{
    RLMResults<SessionDTO*> *sessions=[SessionDTO objectsWhere:@"startDate >1492729200000 AND endDate <1492815600000 AND (status==2 OR status==1) "];
    return sessions;
}
-(RLMResults *)getMySessionsDay3{
    RLMResults<SessionDTO*> *sessions=[SessionDTO objectsWhere:@" startDate >1492815600000 AND endDate <1492902000000 AND (status==2 OR status==1) "];
    return sessions;
}
-(RLMResults *)getMySessions{
    RLMResults<SessionDTO*> *sessions=[SessionDTO objectsWhere:@"status==2 OR status==1"];
    return sessions;

}
-(RLMResults *)day1Sessions{
    
    RLMResults<SessionDTO*> *sessions=[SessionDTO objectsWhere:@"startDate >1492642800000 AND endDate <1492729200000"];
    printf("%lu",(unsigned long)sessions.count);
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
