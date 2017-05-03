//
//  MDW_JsonParser.h
//  Test_AFNet
//
//  Created by JETS on 4/13/17.
//  Copyright © 2017 JETS. All rights reserved.
//





///// This class is used to implement methods
///// with the next Signature
///// (NSMutableArray *) getSessions : (id) JsonObject




#import <Foundation/Foundation.h>

#import "AttendeeDTO.h"
#import "SessionDTO.h"
#import "ExhiptorsDTO.h"
#import "sessionDAO.h"

@interface MDW_JsonParser : NSObject


+ (NSMutableArray *) getSessions_v2 : (id) JsonObj;
+ (SessionDTO *) parseToSessionObj : (NSDictionary *) sessionJson;

+ (NSMutableArray *) getExhibitors_v2 : (id) JsonObj;
+ (ExhiptorsDTO *) parseToExhibitorObj : (NSDictionary *) exhibitorJson;

+ (NSMutableArray *) getSpeakers_v2 : (id) JsonObj;
+ (SpeakerDTO *) parseToSpeakerObj : (NSDictionary *) speakerJson;

+ (AttendeeDTO *) parseToAttendeeObj : (NSDictionary *) attendeeJson;

+ (NSMutableDictionary *) getSesstionRegisterationStatus : (id) JsonObj;

+(void)downloadImages:(NSString *)url forObjCode: (NSString *)code  andObjectId: (int)oid;

+ (BOOL)connected;



@end
