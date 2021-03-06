	//
//  MDWServerURLs.m
//  Test_AFNet
//
//  Created by JETS on 4/12/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "MDWServerURLs.h"



//--- static URL values

static NSString * LOGIN_URL =
    @"http://mobiledeveloperweekend.net/service/login?userName=";

static NSString * GET_SESSIONS_URL =
    @"http://mobiledeveloperweekend.net/service/getSessions?userName=";

static NSString * GET_SPEAKERS_URL =
    @"http://mobiledeveloperweekend.net/service/getSpeakers?userName=";

static NSString * GET_ATTENDEE_PROFILE_URL =
    @"http://www.mobiledeveloperweekend.net/service/getAttendeeProfile?userName=";

static NSString * GET_PROFILE_IMAGE_URL =
    @" http://mobiledeveloperweekend.net/service/profileImage?userName=";

static NSString * GET_EXHIBITORS_URL =
    @"http://mobiledeveloperweekend.net/service/getExhibitors?userName=";

static NSString * REGISTER_SESSION_URL =
    @"http://mobiledeveloperweekend.net/service/registerSession?userName=";
   // @"http://mobiledeveloperweekend.net/service/registerSession?userName=toqa.eid@gmail.com&sessionId=69146&enforce=false&status=0";



@implementation MDWServerURLs


//--- getters for URLs
+ (NSString *) getLoginURL{

    return LOGIN_URL;

}

+ (NSString *) getGetSessionsURL{

    return GET_SESSIONS_URL;
    
}

+ (NSString *) getGetSpeakersURL{

    return GET_SPEAKERS_URL;

}

+ (NSString *) getGetAttendeeProfileURL{

    return GET_ATTENDEE_PROFILE_URL;

}

+ (NSString *) getGetProfileImageURL{

    return GET_PROFILE_IMAGE_URL;

}

+ (NSString *) getRegisterSessionURL{

    return REGISTER_SESSION_URL;

}

+ (NSString *) getGetExhibitorsURL{

    return GET_EXHIBITORS_URL;

}


@end
