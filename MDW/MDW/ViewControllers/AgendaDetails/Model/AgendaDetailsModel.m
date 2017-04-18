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

-(int)registerSession : (SessionDTO*) session{
    
    ///register using network
        //if network returned error show error toast
    NSString * error = @"hello";
    [controller showToast : error];
        //if no error save in db
    
    return 1;
}


-(void)unregisterSession : (SessionDTO*) session{
    ///register using network
    //if network returned error show error toast
    NSString * error;
    [controller showToast : error];
    //if no error save in db
}

@end
