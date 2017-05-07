//
//  MyAgendaModel.h
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//

@class MyAgenda;

#import <Foundation/Foundation.h>
#import "sessionDAO.h"
#import "MyAgenda.h"
#import "AttendeeDTO.h"
#import "NSUserDefaultForObject.h"
#import "MDWServerURLs.h"
#import "MDW_JsonParser.h"

@interface MyAgendaModel : NSObject


-(id)initWithController: (MyAgenda*) agendacontroller;
//Sessions from DB
-(NSMutableArray*) getAllSessionsFromDB;
-(NSMutableArray*) getDay1SessionsFromDB;
-(NSMutableArray*) getDay2SessionsFromDB;
-(NSMutableArray*) getDay3SessionsFromDB;
-(void) saveAllSessionsInDB:(NSMutableArray *)sessions;
//Sessions from Network
-(NSMutableArray*) getAllSessionsFromNetwork;
-(NSMutableArray*) getDay1SessionsFromNetwork;
-(NSMutableArray*) getDay2SessionsFromNetwork;
-(NSMutableArray*) getDay3SessionsFromNetwork;


-(void) getAllSessions;

@end
