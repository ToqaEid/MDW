//
//  LoginController.h
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
#import "AttendeeDTO.h"

@interface LoginController : NSObject

-(AttendeeDTO*)checkUserWithUsername:(NSString*)username AndPassword:(NSString*)password;
-(BOOL)checkInternetConnection;
-(void)saveUserInfoLocally: (AttendeeDTO*)user;
@end
