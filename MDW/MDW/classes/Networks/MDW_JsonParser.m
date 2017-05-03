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
#import <AFNetworking.h>
#import <AFImageDownloader.h>
#import <UIImageView+AFNetworking.h>
#import "speakerDAO.h"
#import "exhiptorDAO.h"
#import <Realm/Realm.h>


@implementation MDW_JsonParser


+ (BOOL)connected {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}


///////////// --1-- Parsing SessionJson ---------------------

+ (NSMutableArray *) getSessions_v2 : (id) JsonObj{


    NSMutableArray * allSessions = [NSMutableArray new];

    
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
    sessionObj.startDate = [[sessionJson objectForKey:@"startDate"] longLongValue];
    sessionObj.endDate = [[sessionJson objectForKey:@"endDate"] longLongValue];
    sessionObj.tags = [sessionJson objectForKey:@"sessionTags"];
    
    ///////// speakers not parsed yet
    
    if ( [sessionJson objectForKey:@"speakers"] ==  (id)[NSNull null] ){
    
        printf("Speakers = NIL \n");
        sessionObj.speakers = nil;
        
    }else{
        
        NSArray * speakersJson = [sessionJson objectForKey:@"speakers"];
        
        for (int i=0; i < [speakersJson count]; i++){
            
            NSDictionary * currObjJson = [speakersJson objectAtIndex:i];
            
            SpeakerDTO * speakerObj = [self parseToSpeakerObj:currObjJson];
            
            //sessionDAO *sessiondao=[sessionDAO sharedInstance ];

            //[sessiondao addSpeaker:speakerObj];
            
            [sessionObj.speakers addObject:speakerObj];
            ////// download speaker image
            
            [self downloadImages:speakerObj.imageURL forObjCode:@"S" andObjectId:speakerObj.speakerId];
            
        }
        
    }
    
    return sessionObj;
}





///////////// --2-- Parsing ExhibitorJson ---------------------


+ (NSMutableArray *) getExhibitors_v2 : (id) JsonObj{

    NSMutableArray * allExhibitors = [NSMutableArray new];
    
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
                
                [allExhibitors addObject:exhibitorObj];
                
                exhiptorDAO * exhibitorD=[exhiptorDAO sharedInstance ];
    
                [exhibitorD addExhiptor:exhibitorObj];
                
                ////// download exhibitor image
                
                [self downloadImages:exhibitorObj.imageURL forObjCode:@"E" andObjectId:exhibitorObj.exhiptorId];
                
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
    
    if([exhibitorObj.companyURL rangeOfString:@"http://"].location == NSNotFound){
        
        exhibitorObj.companyURL = [NSString stringWithFormat:@"http://%@", exhibitorObj.companyURL];
    }
    
    exhibitorObj.fax = [exhibitorJson objectForKey:@"fax"];
    exhibitorObj.companyName = [exhibitorJson objectForKey:@"companyName"];
    exhibitorObj.companyAbout = [exhibitorJson objectForKey:@"companyAbout"];
    exhibitorObj.companyAddress = [exhibitorJson objectForKey:@"companyAddress"];
    exhibitorObj.imageURL = [exhibitorJson objectForKey:@"imageURL"];
    exhibitorObj.countryName = [exhibitorJson objectForKey:@"countryName"];
    exhibitorObj.cityName = [exhibitorJson objectForKey:@"cityName"];
    exhibitorObj.email = [exhibitorJson objectForKey:@"email"];
    
    ///// parsing mobiles and phones "Array of Objects"
    
    NSArray * mobiles = [exhibitorJson objectForKey:@"mobiles"];
    
    NSArray * phones= [exhibitorJson objectForKey:@"phones"];
    
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
    
    NSString * tempURL = [speakerJson objectForKey:@"imageURL"];
    speakerObj.imageURL = [tempURL stringByReplacingOccurrencesOfString:@"www."    withString:@""];
    
    speakerObj.title = [speakerJson objectForKey:@"title"];
    speakerObj.companyName = [speakerJson objectForKey:@"companyName"];
    
    NSArray * mobiles = [speakerJson objectForKey:@"mobiles"];
    NSArray * phones= [speakerJson objectForKey:@"phones"];
    
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
    
    attendeeObj.gender = [attendeeJson objectForKey:@"gender"];
    
    if ( [attendeeJson objectForKey:@"birthDate"] != (id)[NSNull null]  )
    {
        attendeeObj.birthDate = [[attendeeJson objectForKey:@"birthDate"] longValue];
    }
    

    return attendeeObj;
}



///////////// --5-- Parsing Session_Registeration_Status ---------------------



+ (NSMutableDictionary *) getSesstionRegisterationStatus : (id) JsonObj{

    NSMutableDictionary * result = [NSMutableDictionary new];
    int status = 0;

    
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
            [result setValue: [[NSNumber alloc] initWithInt:oldsession] forKey:@"oldSession"];
            
            if(oldsession != 0)
            {
                ////// Already registered in another session at the same time
            
                status = -1;
                [result setValue: [[NSNumber alloc] initWithInt:status] forKey:@"status"];
                
                
            }else{
                /////// Registration Status is
                
                status = [[resultJson objectForKey:@"status"] intValue];
                [result setValue: [[NSNumber alloc] initWithInt:status] forKey:@"status"];
                
            }
            
        }
    }

    
    
    
    return result;
}





+(void)downloadImages:(NSString *)url forObjCode: (NSString *)code  andObjectId: (int)oid{

    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        if( [code isEqualToString:@"S"] )
        {
            
            NSString * simage = @"Speaker_";
            simage = [simage stringByAppendingFormat:@"%d",   oid  ];
            return [documentsDirectoryURL URLByAppendingPathComponent: simage];
            
        }else{
            
            NSString * eimage = @"Exhibitor_";
            eimage = [eimage stringByAppendingFormat:@"%d",   oid  ];
            return [documentsDirectoryURL URLByAppendingPathComponent: eimage];
            
        }
        
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        ///// compressing images
        
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:filePath];
        
        UIImage *image = [UIImage imageWithData: imageData];
        
        NSData *compressedData= UIImageJPEGRepresentation(image,0.1 );
        
        
        //Adding ImageToDb
        
        RLMRealm *realm=[RLMRealm defaultRealm];
       // printf("%s",[realm.configuration.fileURL.absoluteString UTF8String]);
        
        
        if( [code isEqualToString:@"S"] )
        {
            
            SpeakerDTO *myspeaker=[SpeakerDTO objectForPrimaryKey:[[NSNumber alloc] initWithInt: oid ]];
            [realm beginWriteTransaction];
            myspeaker.image=compressedData;
            [realm addOrUpdateObject:myspeaker];
            [realm commitWriteTransaction];
           // printf("SpeakerImage Downloaded Successcfully ...  \n");
            
        }else{
            
            ExhiptorsDTO * exhibitor =[ExhiptorsDTO objectForPrimaryKey:[[NSNumber alloc] initWithInt: oid ]];
            
            [realm beginWriteTransaction];
            exhibitor.image=compressedData;
            [realm addOrUpdateObject:exhibitor];
            [realm commitWriteTransaction];
          //  printf("ExhibitorImage Downloaded Successcfully ...  \n");
            
        }
        
    }];
    [downloadTask resume];


}


@end
