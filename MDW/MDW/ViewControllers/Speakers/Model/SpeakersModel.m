//
//  SpeakersModel.m
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "SpeakersModel.h"
#import "SpeakerDTO.h"

@implementation SpeakersModel{

    SpeakersViewController *controller;
    speakerDAO *speaker;
}

-(id)initWithController: (SpeakersViewController*) speakersController{
    controller = speakersController ;
    return [self init];
}

-(NSMutableArray*) getSpeakersFromDB{
    NSMutableArray * speakers = (NSMutableArray*) [speaker getAllSpeakers];
    return speakers;
}

-(void) saveSpeakersInDB:(NSMutableArray *)speakers{
    [speaker saveSpeakers:speakers];
}


-(NSMutableArray*) getSpeakersFromNetwork{
    NSMutableArray * speakers = [NSMutableArray new];
    SpeakerDTO * speakerdto = [SpeakerDTO new];
    speakerdto.firstName = @"t";
    speakerdto.middleName = @"e";
    speakerdto.lastName = @"s";
    speakerdto.companyName = @"jets";
    speakerdto.title = @"student";
    [speakers addObject:speakerdto];
    
    [self saveSpeakersInDB:speakers];
    
    
    return speakers;
}


@end
