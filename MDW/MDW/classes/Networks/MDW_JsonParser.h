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

@interface MDW_JsonParser : NSObject


+ (NSMutableArray *) getSpeakers : (id) JsonObj;
+ (NSMutableArray *) getSessions : (id) JsonObj;
+ (NSMutableArray *) getExhibitors : (id) JsonObj;
+ (AttendeeDTO *) getAttendee : (id) JsonObj;



////////// ---- optimized methods -----
+ (NSMutableArray *) getSessions_v2 : (id) JsonObj;
+ (SessionDTO *) parseToSessionObj : (NSDictionary *) sessionJson;

+ (NSMutableArray *) getExhibitors_v2 : (id) JsonObj;
+ (ExhiptorsDTO *) parseToExhibitorObj : (NSDictionary *) exhibitorJson;

+ (AttendeeDTO *) parseToAttendeeObj : (NSDictionary *) attendeeJson;




@end
