//
//  sessionDAO.h
//  REALM
//
//  Created by JETS on 4/13/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "SessionDTO.h"

@interface sessionDAO : NSObject
+(sessionDAO *)sharedInstance;
-(BOOL)saveSessions:(NSMutableArray*) sessions;
-(RLMResults*)getAllSessions;
-(BOOL)clearAllDB;
-(RLMResults*)getMySessionsDay1;
-(RLMResults*)getMySessionsDay2;
-(RLMResults*)getMySessionsDay3;
-(RLMResults*)getMySessions;
-(RLMResults*)day1Sessions;
-(RLMResults*)day2Sessions;
-(RLMResults*)day3Sessions;
-(BOOL)addSpeaker:(SpeakerDTO*)speaker;
-(BOOL)updateSession:(SessionDTO*)session;
@end
