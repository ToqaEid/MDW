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
    speaker = [speakerDAO sharedInstance];
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
    
    
    
    return [self getSpeakersFromDB];
}


@end
