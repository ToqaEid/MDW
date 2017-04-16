//
//  LoginModel.m
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "LoginModel.h"


@implementation LoginModel


-(AttendeeDTO*)checkUser:(NSString*)username :(NSString*)password{
    AttendeeDTO * user = nil;
    return user;
}

-(BOOL)checkInternetConnection{
    return YES;
}

-(void)saveUserLocally: (AttendeeDTO*)user{
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:user];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:@"user"];
    [defaults synchronize];
}
@end
