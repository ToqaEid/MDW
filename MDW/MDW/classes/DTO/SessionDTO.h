//
//  SessionDTO.h
//  REALM
//
//  Created by JETS on 4/12/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Realm/Realm.h>
#import "SpeakerDTO.h"

@interface SessionDTO : RLMObject
@property int sessionId,status;
@property long startDate,endDate;
@property BOOL liked;
@property NSString *sessionType,*name,*SessionDescription,*location, *tags;
@property RLMArray<SpeakerDTO *><SpeakerDTO> *speakers;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<SessionDTO *><SessionDTO>
RLM_ARRAY_TYPE(SessionDTO)
