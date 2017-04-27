//
//  AgendaDetailsModel.h
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//
@class AgendaDetailsViewController;

#import <Foundation/Foundation.h>
#import "AgendaDetailsViewController.h"
#import "SessionDTO.h"

//typedef enum {ACCEPTED, WAITING} SessionStatus;

@interface AgendaDetailsModel : NSObject

-(id)initWithController: (AgendaDetailsViewController*) agendaCont;

-(void)registerSessionWithSessionObj : (SessionDTO*)session  AndEnforce : (BOOL) enforce;

-(void)unregisterSession : (SessionDTO*) session;
@end
