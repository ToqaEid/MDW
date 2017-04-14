//
//  speakerDAO.m
//  REALM
//
//  Created by JETS on 4/13/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "speakerDAO.h"

@implementation speakerDAO
static speakerDAO* speaker=nil;
+(speakerDAO *)sharedInstance{
    if (speaker==nil) {
        speaker=[speakerDAO new];
    }
    return speaker;
}
-(BOOL)saveSpeakers:(NSMutableArray *)speakers{
    RLMRealm *realm=[RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObjects:speakers];
    [realm commitWriteTransaction];
    return YES;
}
-(RLMResults *)getAllSpeakers{
    RLMResults<SpeakerDTO*> *speakers=[SpeakerDTO allObjects];
    return speakers;
}

@end
