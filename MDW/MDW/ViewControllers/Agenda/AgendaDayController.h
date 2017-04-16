//
//  AgendaDayController.h
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AgendaDay.h"
#import "AgendaDayModel.h"

@class AgendaDay;
@class AgendaDayModel;

@interface AgendaDayController : NSObject{
    AgendaDay * view;
    AgendaDayModel * model;
}


-(id)initWithView :(AgendaDay *) agendaView;
//Sessions From DB
-(NSMutableArray*) getAllSessionsFromDBFromModel;
-(NSMutableArray*) getDay1SessionsFromDBFromModel;
-(NSMutableArray*) getDay2SessionsFromDBFromModel;
-(NSMutableArray*) getDay3SessionsFromDBFromModel;

-(void) saveAllSessionsInDBFromModel:(NSMutableArray *)sessions;

//Sessions From Network
-(NSMutableArray*) getAllSessionsFromNetworkFromModel;
-(NSMutableArray*) getDay1SessionsFromNetworkFromModel;
-(NSMutableArray*) getDay2SessionsFromNetworkFromModel;
-(NSMutableArray*) getDay3SessionsFromNetworkFromModel;
-(BOOL)checkInternetConnection;

@end
