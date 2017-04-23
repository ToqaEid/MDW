//
//  AgendaDayModel.h
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

@class AgendaDay;

#import <Foundation/Foundation.h>
#import "sessionDAO.h"
#import "SessionDTO.h"
#import "AgendaDay.h"

@interface AgendaDayModel : NSObject

-(id)initWithController: (AgendaDay*) agendacontroller;
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


-(void) getAllSessions : (NSString *) username;


@end
