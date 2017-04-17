//
//  AgendaDayController.m
//  MDW
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "AgendaDayController.h"

@implementation AgendaDayController

-(id)initWithView :(AgendaDay *)AgendaView{
    
    view = AgendaView;
    model = [[AgendaDayModel alloc ]initWithController: self];
    return [self init];
}

/*=======================Sessions from DB ========================*/
-(NSMutableArray*) getAllSessionsFromDBFromModel{
    return [model getAllSessionsFromDB];
}
-(NSMutableArray*) getDay1SessionsFromDBFromModel{
    return [model getDay1SessionsFromDB];
}
-(NSMutableArray*) getDay2SessionsFromDBFromModel{
    return [model getDay2SessionsFromDB];
}
-(NSMutableArray*) getDay3SessionsFromDBFromModel{
    return [model getDay3SessionsFromDB];
}
/*=======================Save Sessions into DB ========================*/

-(void) saveAllSessionsInDBFromModel:(NSMutableArray *)sessions{
}

/*=======================Sessions from Network ========================*/
-(NSMutableArray*) getAllSessionsFromNetworkFromModel{
    return [model getAllSessionsFromNetwork];
}
-(NSMutableArray*) getDay1SessionsFromNetworkFromModel{
    return [model getDay1SessionsFromNetwork];
}

-(NSMutableArray*) getDay2SessionsFromNetworkFromModel{
    return [model getDay2SessionsFromNetwork];
}

-(NSMutableArray*) getDay3SessionsFromNetworkFromModel{
    return [model getDay3SessionsFromNetwork];
}
/*==============================================*/
-(BOOL)checkInternetConnection{
    return [model checkInternetConnection];
}
@end
