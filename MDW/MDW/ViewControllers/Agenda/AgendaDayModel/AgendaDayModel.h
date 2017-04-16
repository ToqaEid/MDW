//
//  AgendaDayModel.h
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sessionDAO.h"
#import "AgendaDayController.h"

@class AgendaDayController;

@interface AgendaDayModel : NSObject

-(id)initWithController: (AgendaDayController*) agendacontroller;
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
-(BOOL)checkInternetConnection;

@end
