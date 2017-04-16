//
//  speakerDAO.h
//  REALM
//
//  Created by JETS on 4/13/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "SpeakerDTO.h"

@interface speakerDAO : NSObject
+(speakerDAO *)sharedInstance;
-(BOOL)saveSpeakers:(NSMutableArray*) speakers;
-(RLMResults*)getAllSpeakers;
@end
