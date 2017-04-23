//
//  MDWServerURLs.h
//  Test_AFNet
//
//  Created by JETS on 4/12/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDWServerURLs : NSObject


+ (NSString *) getLoginURL;
+ (NSString *) getGetSessionsURL;
+ (NSString *) getGetSpeakersURL;
+ (NSString *) getGetAttendeeProfileURL;
+ (NSString *) getGetProfileImageURL;
+ (NSString *) getRegisterSessionURL;
+ (NSString *) getGetExhibitorsURL;

@end
