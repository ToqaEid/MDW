//
//  AgendaDetailsModel.m
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "AgendaDetailsModel.h"


@implementation AgendaDetailsModel{
    AgendaDetailsViewController* controller;
}

-(id)initWithController: (AgendaDetailsViewController*) agendaCont{
    controller = agendaCont ;
    return [self init];
}

-(SessionStatus)registerSession{
    return ACCEPTED;
}


@end
