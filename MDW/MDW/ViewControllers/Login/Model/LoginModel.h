//
//  LoginModel.h
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttendeeDTO.h"

@interface LoginModel : NSObject

-(AttendeeDTO*)checkUser:(NSString*)username :(NSString*)password;
-(BOOL)checkInternetConnection;
-(void)saveUserLocally: (AttendeeDTO*)user;
-(BOOL)isEmailValid:(NSString*)email;

@end
