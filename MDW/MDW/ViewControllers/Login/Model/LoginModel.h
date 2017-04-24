//
//  LoginModel.h
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

@class LoginViewController;

#import <Foundation/Foundation.h>
#import "AttendeeDTO.h"
#import "LoginViewController.h"
#import "MDWServerURLs.h"
#import <AFNetworking.h>
#import "MDW_JsonParser.h"
#import "NSUserDefaultForObject.h"

@interface LoginModel : NSObject

-(AttendeeDTO*)checkUserWithUsername:(NSString*)username AndPassword:(NSString*)password;
-(BOOL)checkInternetConnection;
-(void)saveUserLocally: (AttendeeDTO*)user;
-(BOOL)isEmailValid:(NSString*)email;
-(id)initWithController: (LoginViewController*) loginController;

@end
