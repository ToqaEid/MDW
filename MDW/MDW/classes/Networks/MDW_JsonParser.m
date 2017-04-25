//
//  MDW_JsonParser.m
//  Test_AFNet
//
//  Created by JETS on 4/13/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Realm/Realm.h>
#import "MDW_JsonParser.h"
#import "SpeakerDTO.h"
#import "SessionDTO.h"
#import "ExhiptorsDTO.h"
#import "Mobile.h"
#import "Phone.h"


@implementation MDW_JsonParser




+ (NSMutableArray *) getSpeakers : (id) responseObject{

    
    printf(">>>>> Inside PARSER >> \n");
    
    NSMutableArray * speakers = [NSMutableArray new];
    
    
    /////// 1. get json object from server
    
    if ([responseObject isKindOfClass:[NSArray class]])
    {
        printf("Response is NSArray ... \n");
        
    } else  if ([responseObject isKindOfClass:[NSDictionary class]])
    {
        /////// 2. convert to NSDictionary & check Status
        
        NSDictionary * rootJson = responseObject;
        NSString  * responseStatus = [rootJson objectForKey:@"status"];
        
        if (  [responseStatus isEqualToString:@"view.success"]  )
        {
            /////3.  extract speakers jsonObj
            
            NSArray * speakersJson = [rootJson objectForKey:@"result"];
            
            
            for(int i=0; i< [speakersJson count]; i++){
                
                SpeakerDTO * speakerObj = [SpeakerDTO new];
                
                NSDictionary * currentObj = [speakersJson objectAtIndex:i];
                
                speakerObj.firstName = [currentObj objectForKey:@"firstName"];
                speakerObj.middleName = [currentObj objectForKey:@"middleName"];
                speakerObj.lastName = [currentObj objectForKey:@"lastName"];
                speakerObj.gender = [currentObj objectForKey:@"gender"];
                
                speakerObj.biography = [currentObj objectForKey:@"biography"];
                speakerObj.imageURL = [currentObj objectForKey:@"imageURL"];
                speakerObj.title = [currentObj objectForKey:@"title"];
                speakerObj.companyName = [currentObj objectForKey:@"companyName"];
                
                
                //speakerObj.phones = [currentObj objectForKey:@"mobiles"];
                //speakerObj.phones = [currentObj objectForKey:@"phones"];
                
                speakerObj.speakerId = [[currentObj objectForKey:@"id"] intValue];
                
                printf(">>>>>> Speakers is %d\n", speakerObj.speakerId );
                
                [speakers addObject:speakerObj];
                
            }
            
            
        }else{
            printf(">>>> ERROR\n ");
            
        }
        
        
        
    }
    
    
    printf("ARRAY SIZE IS %lu", (unsigned long)[speakers count]);
    
    return speakers;
    
}








+ (NSMutableArray *) getExhibitors : (id) responseObject{
    
    NSMutableArray * allExhibitors = [NSMutableArray new];
    
    
    
    /////// 1. get json object from server
    
    if ([responseObject isKindOfClass:[NSArray class]])
    {
        printf("Response is NSArray ... \n");
        
    } else  if ([responseObject isKindOfClass:[NSDictionary class]])
    {
        /////// 2. convert to NSDictionary & check Status
        
        NSDictionary * rootJson = responseObject;
        NSString  * responseStatus = [rootJson objectForKey:@"status"];
        
        if (  [responseStatus isEqualToString:@"view.success"]  )
        {
            /////3.  extract speakers jsonObj
            
            NSArray * exhibitorsJson = [rootJson objectForKey:@"result"];
            
            
            for(int i=0; i< [exhibitorsJson count]; i++){
            
                ExhiptorsDTO * exhibitorObj = [ExhiptorsDTO new];
                
                NSDictionary * currentObj = [exhibitorsJson objectAtIndex:i];
                
                
                exhibitorObj.contactName = [currentObj objectForKey:@"contactName"];
                exhibitorObj.contactTitle = [currentObj objectForKey:@"contactTitle"];
                exhibitorObj.companyURL = [currentObj objectForKey:@"companyUrl"];
                
                exhibitorObj.fax = [currentObj objectForKey:@"fax"];
                exhibitorObj.companyName = [currentObj objectForKey:@"companyName"];
                exhibitorObj.companyAbout = [currentObj objectForKey:@"companyAbout"];
                exhibitorObj.companyAddress = [currentObj objectForKey:@"companyAddress"];
                //exhibitorObj.imageUrl = [currentObj objectForKey:@"imageURL"];
                
                exhibitorObj.countryName = [currentObj objectForKey:@"countryName"];
                exhibitorObj.cityName = [currentObj objectForKey:@"cityName"];
                exhibitorObj.email = [currentObj objectForKey:@"email"];
                exhibitorObj.exhiptorId = [[currentObj objectForKey:@"id"] intValue];
                
                exhibitorObj.phones = [currentObj objectForKey:@"phones"];
                exhibitorObj.mobiles = [currentObj objectForKey:@"mobiles"];
                
                
                
                printf("Exhibitors ID = %d\n",  exhibitorObj.exhiptorId );
                
                [allExhibitors addObject:exhibitorObj];
                
            }
            
            
        }else{
            printf(">>>> ERROR\n ");
            
        }
        
        
        
    }
    
    
    printf("ARRAY SIZE IS %lu", (unsigned long)[allExhibitors count]);
    
    
    
    
    
    
    
    return allExhibitors;
}








+ (NSMutableArray *) getSessions : (id) responseObject{

    
    printf(">>>>> Inside PARSER >> \n");
    
    NSMutableArray * allSessions = [NSMutableArray new];
    
    /////// 1. get json object from server
    
    if ([responseObject isKindOfClass:[NSArray class]])
    {
        printf("Response is NSArray ... \n");
        
    }///end of isKindOf NSArray
    else  if ([responseObject isKindOfClass:[NSDictionary class]])
    {
        /////// 2. convert to NSDictionary & check Status
        
        NSDictionary * rootJson = responseObject;
        NSString  * responseStatus = [rootJson objectForKey:@"status"];
        
        if (  [responseStatus isEqualToString:@"view.success"]  )
        {
            
            /////3.  extract agendas jsonObj
            
            NSDictionary * resultJson = [rootJson objectForKey:@"result"];
            
            NSArray * agendasJson = [resultJson objectForKey:@"agendas"];
            
            for(int i=0; i< [agendasJson count]; i++)
            {
                ////////// SIZE = 3 >> why? >> 3 days MDW Event
                
                //////////// get sessions for every day and append to allSessionsArray
                
                NSArray * specificDayJson = [[ agendasJson objectAtIndex:i ] objectForKey:@"sessions"];
                
                printf(">>>> Day # %d >>>>   %lu  Session\n",  i   , (unsigned long)[specificDayJson count]);

                printf("----------------------------\n");
                
                SessionDTO  * sessionObj = [SessionDTO new];
                
                
                for (int j=0; j< 2; j++ )
                {
                   // printf(">>>> Day # %d >>>>   %lu  Session\n",  i   , (unsigned long)[specificDayJson count]);

                    NSDictionary * sessionJson = [  specificDayJson objectAtIndex:j  ];
                
                    sessionObj.name = [sessionJson objectForKey:@"name"];
                    sessionObj.location = [sessionJson objectForKey:@"location"];
                    sessionObj.SessionDescription = [sessionJson objectForKey:@"description"];
                    sessionObj.sessionType = [sessionJson objectForKey:@"sessionType"];
                    
                    sessionObj.sessionId = [[sessionJson objectForKey:@"id"] intValue];
                    sessionObj.status = [[sessionJson objectForKey:@"status"] intValue];
                    sessionObj.liked = [sessionJson objectForKey:@"liked"];
                    
                    sessionObj.startDate = [[sessionJson objectForKey:@"startDate"] longValue];
                    sessionObj.endDate = [[sessionJson objectForKey:@"endDate"] longValue];
                    sessionObj.tags = [sessionJson objectForKey:@"sessionTags"];
                   

                    printf("$$$ Sesseion StartDate >> %ld\n", sessionObj.startDate);
                    
                    //// get session speakers
                    
                    
                        if ( [sessionJson objectForKey:@"speakers"] == (id)[NSNull null]  )
                        {
                        
                            sessionObj.speakers = nil;
                        
                           // printf("#of Speakers >> 0\n");
                        
                        }else{
                    
                        
                            NSArray * sessionSpeakers = [sessionJson objectForKey:@"speakers"];
                        
                            //sessionObj.speakers = [NSMutableArray new];
                            //NSMutableArray * mySpeakers = [NSMutableArray new];
                        
                            for (int s=0; s<[sessionSpeakers count]; s++)
                            {
                                SpeakerDTO * speakerObj = [SpeakerDTO new];
                            
                                NSDictionary * currentObj = [sessionSpeakers objectAtIndex:s];
                            
                                speakerObj.firstName = [currentObj objectForKey:@"firstName"];
                                speakerObj.middleName = [currentObj objectForKey:@"middleName"];
                                speakerObj.lastName = [currentObj objectForKey:@"lastName"];
                                speakerObj.gender = [currentObj objectForKey:@"gender"];
                            
                                speakerObj.biography = [currentObj objectForKey:@"biography"];
                                speakerObj.imageURL = [currentObj objectForKey:@"imageURL"];
                                speakerObj.title = [currentObj objectForKey:@"title"];
                                speakerObj.companyName = [currentObj objectForKey:@"companyName"];
                                NSArray *mobiles=[currentObj objectForKey:@"mobiles"];
                                NSArray *phones=[currentObj objectForKey:@"phones"];
                                for(int m = 0; m< [mobiles count]; m++){
                                    
                                    Mobile * mobileObj = [Mobile new];
                                    mobileObj.mobile = [mobiles objectAtIndex:m];
                                    [speakerObj.mobiles addObject:mobileObj];
                                }
                                
                                for(int p = 0; p< [phones count]; p++){
                                    
                                    Phone * phoneObj = [Phone new];
                                    phoneObj.phone = [phones objectAtIndex:p];
                                    [speakerObj.phones addObject:phoneObj];
                                }
                                speakerObj.speakerId = [[currentObj objectForKey:@"id"] intValue];
                            
                                //[mySpeakers addObject:speakerObj];
                                
                                [sessionObj.speakers addObject:speakerObj];
                            
                            }//// end of sessionSpeakers looop
                        
                          //  printf("Session name is %s AND #of Speakers >> %lu\n", [sessionObj.name UTF8String]  , (unsigned long)[sessionObj.speakers count] );
                        
                            //sessionObj.speakers = mySpeakers;
                        
                    } //// end of session have speakers if condition
                    printf(" - - - \n");
                    [allSessions addObject:sessionObj];
                    //printf(" - - - Session %s is Added Successfully\n", [sessionObj.name UTF8String]);
                    
                }//////// end of specifc day sessions
                
                
            }////// end of 3 days agenda
            
            
        
        }///// end of response SUCCESS
        else{
            printf(">>>> ERROR\n ");
            
        }//// end of response ERROR
        
        
        
    }/// end of isKindOf NSDict
    
    
    //printf("\n\n ????? ARRAY SIZE IS %lu\n\n", (unsigned long)[allSessions count]);
    
    for (int i=0; i< [allSessions count]; i++){
        
        //printf("%s\n",  [[[allSessions objectAtIndex:i] name] UTF8String] );
    
    }
    
    
    
    
    
    return allSessions;
}


+ (AttendeeDTO *) getAttendee : (id) responseObject{
    
    AttendeeDTO * attendeeObj = [AttendeeDTO new];
    
    
    
    printf(">>>>> Inside PARSER >> \n");
    
    
    /////// 1. get json object from server
    
    if ([responseObject isKindOfClass:[NSArray class]])
    {
        printf("Response is NSArray ... \n");
        
    } else  if ([responseObject isKindOfClass:[NSDictionary class]])
    {
        printf("Response is NSDictionary ... \n");
        
        
        /////// 2. convert to NSDictionary & check Status
        
        NSDictionary * rootJson = responseObject;
        NSString  * responseStatus = [rootJson objectForKey:@"status"];
        
        if (  [responseStatus isEqualToString:@"view.success"]  )
        {
            /////3.  extract speakers jsonObj
            
            NSDictionary * attendeeJson = [rootJson objectForKey:@"result"];
            
            
            attendeeObj.firstName = [attendeeJson objectForKey:@"firstName"];
            attendeeObj.middleName = [attendeeJson objectForKey:@"middleName"];
            attendeeObj.lastName = [attendeeJson objectForKey:@"lastName"];
            attendeeObj.title = [attendeeJson objectForKey:@"title"];
            attendeeObj.companyName = [attendeeJson objectForKey:@"companyName"];
            
            attendeeObj.countryName = [attendeeJson objectForKey:@"countryName"];
            attendeeObj.cityName = [attendeeJson objectForKey:@"cityName"];
            
            attendeeObj.email = [attendeeJson objectForKey:@"email"];
            //attendeeObj.imageUrl = [attendeeJson objectForKey:@"imageURL"];
            attendeeObj.code = [attendeeJson objectForKey:@"code"];

            attendeeObj.attendeeId = [[attendeeJson objectForKey:@"id"] intValue];
            attendeeObj.mobiles = [attendeeJson objectForKey:@"mobiles"];
            attendeeObj.phones = [attendeeJson objectForKey:@"phones"];
            
            attendeeObj.gender = [attendeeJson objectForKey:@"gender"];
            
            if ( [attendeeJson objectForKey:@"birthDate"] != (id)[NSNull null]  )
            {
                attendeeObj.birthDate = [[attendeeJson objectForKey:@"birthDate"] longValue];
            }
            
            //printf(">>>> attendee >>> %s\n",    [attendeeObj.firstName UTF8String]  );
            
            
        }else{
            printf(">>>> ERROR\n ");
            
        }
        
        
        
    }
    
    
    
    return attendeeObj;
}






///////////// -- ---- ------ --- Optimized Methods ----- ---   ------- -- ------- ----- -----


///////////// --1-- Parsing SessionJson ---------------------

+ (NSMutableArray *) getSessions_v2 : (id) JsonObj{


    NSMutableArray * allSessions = [NSMutableArray new];

    
    printf(">>>>> Inside new Sessions PARSER >> \n");
    
    if ([JsonObj isKindOfClass:[NSArray class]])
    {
        printf("Response is NSArray ... \n");
        
    }///end of isKindOf NSArray
    else  if ([JsonObj isKindOfClass:[NSDictionary class]])
    {
        /////// 2. convert to NSDictionary & check Status
        
        NSDictionary * rootJson = JsonObj;
        NSString  * responseStatus = [rootJson objectForKey:@"status"];
        
        if (  [responseStatus isEqualToString:@"view.success"]  )
        {
            /////3.  extract agendas jsonObj
            
            NSDictionary * resultJson = [rootJson objectForKey:@"result"];
            NSArray * agendasJson = [resultJson objectForKey:@"agendas"];
            
            
            ////// get session for the three agendas = 3 days
            
            for (int day=0; day < [agendasJson count]; day++)
            {
                ///// get sessions for specific day
            
                NSDictionary * oneAgenda = [agendasJson objectAtIndex:day];
                NSArray * sessionsForOneAgenda = [oneAgenda objectForKey:@"sessions"];
                
                //printf("#### Total Sessions at Day # %d   are  %lu\n", day+1, (unsigned long)[sessionsForOneAgenda count]);
                
                
                for (int s=0; s<[sessionsForOneAgenda count]; s++ )
                {
                    NSDictionary * oneSession = [ sessionsForOneAgenda objectAtIndex:s ];
                    
                    SessionDTO * sessionObj = [self parseToSessionObj:oneSession];
                    
                    //printf("-- %s\n", [sessionObj.name UTF8String]);
                    
                    [allSessions addObject:sessionObj];
                    
                }
                
                
            }
        }
    }

    return allSessions;

}

////////////// ----- Parsing only one session object

+ (SessionDTO *) parseToSessionObj : (NSDictionary *) sessionJson{

    SessionDTO * sessionObj = [SessionDTO new];


    sessionObj.name = [sessionJson objectForKey:@"name"];
    sessionObj.location = [sessionJson objectForKey:@"location"];
    sessionObj.SessionDescription = [sessionJson objectForKey:@"description"];
    sessionObj.sessionType = [sessionJson objectForKey:@"sessionType"];
    
    sessionObj.sessionId = [[sessionJson objectForKey:@"id"] intValue];
    sessionObj.status = [[sessionJson objectForKey:@"status"] intValue];
    sessionObj.liked = [sessionJson objectForKey:@"liked"];
    
    sessionObj.startDate = [[sessionJson objectForKey:@"startDate"] longValue];
    sessionObj.endDate = [[sessionJson objectForKey:@"endDate"] longValue];
    sessionObj.tags = [sessionJson objectForKey:@"sessionTags"];

    
    printf("SessionId  =  %d\n", sessionObj.sessionId);
    
    
    ///////// speakers not parsed yet

    
    if ( [sessionJson objectForKey:@"speakers"] ==  (id)[NSNull null] ){
    
        printf("Speakers = NIL \n");
        sessionObj.speakers = nil;
        
    }else{
        
        NSArray * speakersJson = [sessionJson objectForKey:@"speakers"];
        
        for (int i=0; i < [speakersJson count]; i++){
            
            NSDictionary * currObjJson = [speakersJson objectAtIndex:i];
            
            SpeakerDTO * speakerObj = [self parseToSpeakerObj:currObjJson];
            
            printf("Speaket is >> %s\n",  [speakerObj.firstName UTF8String] );
            
            [sessionObj.speakers addObject:speakerObj];
            
        }
        
    }
    
    
    
    return sessionObj;
}





///////////// --2-- Parsing ExhibitorJson ---------------------


+ (NSMutableArray *) getExhibitors_v2 : (id) JsonObj{

    NSMutableArray * allExhibitors = [NSMutableArray new];
    
    
    printf(">>>>> Inside new Exhibitors PARSER >> \n");
    
    if ([JsonObj isKindOfClass:[NSArray class]])
    {
        printf("Response is NSArray ... \n");
        
    }///end of isKindOf NSArray
    else  if ([JsonObj isKindOfClass:[NSDictionary class]])
    {
        /////// 2. convert to NSDictionary & check Status
        
        NSDictionary * rootJson = JsonObj;
        NSString  * responseStatus = [rootJson objectForKey:@"status"];
        
        if (  [responseStatus isEqualToString:@"view.success"]  )
        {
            /////3.  extract exhibitors jsonObj
            
            NSArray * ExsJson = [rootJson objectForKey:@"result"];
            
            
            ////// get exhibitors
            
            for (int ex=0; ex < [ExsJson count]; ex++)
            {
                ///// get exhibitorObj
                
                NSDictionary * oneExhibitor = [ ExsJson objectAtIndex:ex ];
                
                ExhiptorsDTO * exhibitorObj = [self parseToExhibitorObj:oneExhibitor];
                
                printf("-- exh --  %s\n", [exhibitorObj.companyName UTF8String]);
                
                [allExhibitors addObject:exhibitorObj];
                
            }
        }
    }

    return allExhibitors;
}

+ (ExhiptorsDTO *) parseToExhibitorObj : (NSDictionary *) exhibitorJson{

    ExhiptorsDTO * exhibitorObj = [ExhiptorsDTO new];
    
    
    exhibitorObj.exhiptorId = [[exhibitorJson objectForKey:@"id"] intValue];
    exhibitorObj.contactName = [exhibitorJson objectForKey:@"contactName"];
    exhibitorObj.contactTitle = [exhibitorJson objectForKey:@"contactTitle"];
    exhibitorObj.companyURL = [exhibitorJson objectForKey:@"companyUrl"];
    
    exhibitorObj.fax = [exhibitorJson objectForKey:@"fax"];
    exhibitorObj.companyName = [exhibitorJson objectForKey:@"companyName"];
    exhibitorObj.companyAbout = [exhibitorJson objectForKey:@"companyAbout"];
    exhibitorObj.companyAddress = [exhibitorJson objectForKey:@"companyAddress"];
    
    exhibitorObj.imageURL = [exhibitorJson objectForKey:@"imageURL"];
    
    exhibitorObj.countryName = [exhibitorJson objectForKey:@"countryName"];
    exhibitorObj.cityName = [exhibitorJson objectForKey:@"cityName"];
    exhibitorObj.email = [exhibitorJson objectForKey:@"email"];
    
   
    
    NSArray * mobiles = [exhibitorJson objectForKey:@"mobiles"];
    NSArray * phones= [exhibitorJson objectForKey:@"phones"];
    
    printf("^^^ Mobiles = %lu & Phones = %lu \n",  (unsigned long)[mobiles count], (unsigned long)[phones count] );
    
    
    for(int m = 0; m< [mobiles count]; m++){
        
        Mobile * mobileObj = [Mobile new];
        mobileObj.mobile = [mobiles objectAtIndex:m];
        [exhibitorObj.mobiles addObject:mobileObj];
    }
    
    for(int p = 0; p< [phones count]; p++){
        
        Phone * phoneObj = [Phone new];
        phoneObj.phone = [phones objectAtIndex:p];
        [exhibitorObj.phones addObject:phoneObj];
    }
    

    
    
    
    return exhibitorObj;
}



///////////// --3-- Parsing Speaker ---------------------


+ (NSMutableArray *) getSpeakers_v2 : (id) JsonObj{

    NSMutableArray * allSpeakers = [NSMutableArray new];


    /////// 1. get json object from server
    
    if ([JsonObj isKindOfClass:[NSArray class]])
    {
        printf("Response is NSArray ... \n");
        
    } else  if ([JsonObj isKindOfClass:[NSDictionary class]])
    {
        /////// 2. convert to NSDictionary & check Status
        
        NSDictionary * rootJson = JsonObj;
        NSString  * responseStatus = [rootJson objectForKey:@"status"];
        
        if (  [responseStatus isEqualToString:@"view.success"]  )
        {
            /////3.  extract speakers jsonObj
            
            NSArray * speakersJson = [rootJson objectForKey:@"result"];
            
            
            for(int i=0; i< [speakersJson count]; i++){
                
                NSDictionary * currentObj = [speakersJson objectAtIndex:i];
                
                SpeakerDTO * speakerObj = [self parseToSpeakerObj:currentObj];
                
                [allSpeakers addObject:speakerObj];
                
            }
            
            
        }else{
            printf(">>>> ERROR\n ");
            
        }
        
    }
    
    return allSpeakers;
}



+ (SpeakerDTO *) parseToSpeakerObj : (NSDictionary *) speakerJson{

    SpeakerDTO * speakerObj = [SpeakerDTO new];

    
    speakerObj.speakerId = [[speakerJson objectForKey:@"id"] intValue];

    speakerObj.firstName = [speakerJson objectForKey:@"firstName"];
    speakerObj.middleName = [speakerJson objectForKey:@"middleName"];
    speakerObj.lastName = [speakerJson objectForKey:@"lastName"];
    speakerObj.gender = [speakerJson objectForKey:@"gender"];
    
    speakerObj.biography = [speakerJson objectForKey:@"biography"];
    speakerObj.imageURL = [speakerJson objectForKey:@"imageURL"];
    speakerObj.title = [speakerJson objectForKey:@"title"];
    speakerObj.companyName = [speakerJson objectForKey:@"companyName"];
    
    NSArray * mobiles = [speakerJson objectForKey:@"mobiles"];
    NSArray * phones= [speakerJson objectForKey:@"phones"];
    
    printf("^^^ Mobiles = %lu & Phones = %lu \n",  (unsigned long)[mobiles count], (unsigned long)[phones count] );
    
    
    for(int m = 0; m< [mobiles count]; m++){
        
        Mobile * mobileObj = [Mobile new];
        mobileObj.mobile = [mobiles objectAtIndex:m];
        [speakerObj.mobiles addObject:mobileObj];
    }
    
    for(int p = 0; p< [phones count]; p++){
        
        Phone * phoneObj = [Phone new];
        phoneObj.phone = [phones objectAtIndex:p];
        [speakerObj.phones addObject:phoneObj];
    }


    return speakerObj;
}




///////////// --4-- Parsing Attendee "AppUser" ---------------------

+ (AttendeeDTO *) parseToAttendeeObj : (NSDictionary *) attendeeJson{

    AttendeeDTO * attendeeObj = [AttendeeDTO new];

    
    attendeeObj.firstName = [attendeeJson objectForKey:@"firstName"];
    attendeeObj.middleName = [attendeeJson objectForKey:@"middleName"];
    attendeeObj.lastName = [attendeeJson objectForKey:@"lastName"];
    attendeeObj.title = [attendeeJson objectForKey:@"title"];
    attendeeObj.companyName = [attendeeJson objectForKey:@"companyName"];
    
    attendeeObj.countryName = [attendeeJson objectForKey:@"countryName"];
    attendeeObj.cityName = [attendeeJson objectForKey:@"cityName"];
    
    attendeeObj.email = [attendeeJson objectForKey:@"email"];
    attendeeObj.imageURL = [attendeeJson objectForKey:@"imageURL"];
    attendeeObj.code = [attendeeJson objectForKey:@"code"];
    
    attendeeObj.attendeeId = [[attendeeJson objectForKey:@"id"] intValue];
    //attendeeObj.mobiles = [attendeeJson objectForKey:@"mobiles"];
    //attendeeObj.phones = [attendeeJson objectForKey:@"phones"];
    
    attendeeObj.gender = [attendeeJson objectForKey:@"gender"];
    
    if ( [attendeeJson objectForKey:@"birthDate"] != (id)[NSNull null]  )
    {
        attendeeObj.birthDate = [[attendeeJson objectForKey:@"birthDate"] longValue];
    }
    

    return attendeeObj;
}



///////////// --5-- Parsing Session_Registeration_Status ---------------------



+ (int) getSesstionRegisterationStatus : (id) JsonObj{

    int status = 0;

    
    printf(">>>>> Inside sessionRegisteration PARSER >> \n");
    
    if ([JsonObj isKindOfClass:[NSArray class]])
    {
        printf("Response is NSArray ... \n");
        
    }///end of isKindOf NSArray
    else  if ([JsonObj isKindOfClass:[NSDictionary class]])
    {
        /////// 2. convert to NSDictionary & check Status
        
        NSDictionary * rootJson = JsonObj;
        NSString  * responseStatus = [rootJson objectForKey:@"status"];
        
        if (  [responseStatus isEqualToString:@"view.success"]  )
        {
            /////3.  extract result jsonObj
            
            NSDictionary * resultJson = [rootJson objectForKey:@"result"];
            
            int oldsession = [[resultJson objectForKey:@"oldSessionId"] intValue];
            if(oldsession != 0)
            {
                ////// Already registered in another session at the same time
            
                
                status = -1;
                
                
            }else{
                /////// Registration Status is
                
                  status = [[resultJson objectForKey:@"status"] intValue];
            
            }
            
        }
    }

    
    
    
    return status;
}

@end
