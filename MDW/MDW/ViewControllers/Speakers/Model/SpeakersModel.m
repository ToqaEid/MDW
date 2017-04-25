//
//  SpeakersModel.m
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "SpeakersModel.h"
#import "SpeakerDTO.h"


#import <AFNetworking.h>
#import <AFImageDownloader.h>
#import <UIImageView+AFNetworking.h>
#import "MDWServerURLs.h"
#import "MDW_JsonParser.h"

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


-(void) getSpeakersFromNetwork{
    
    
    AttendeeDTO * user = [NSUserDefaultForObject getObjectForKey:@"user"];

    NSString * speakersURL =  [[MDWServerURLs getGetSpeakersURL]  stringByAppendingString: user.email  ];
    
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET: speakersURL  parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
    
    
            NSLog(@"JSON: %@", responseObject);
            printf("Speakers Response recieved ... \n");
    
    
            NSMutableArray * allSpeakers  =  [MDW_JsonParser getSpeakers_v2:responseObject];
    
            
            [controller setAllSpeakers:allSpeakers];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
            
        }];
    

    
    
}


@end
