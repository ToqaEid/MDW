//
//  LoginModel.m
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "LoginModel.h"
#import "MDWServerURLs.h"

@implementation LoginModel


+(AttendeeDTO*)checkUserWithUsername:(NSString*)username AndPassword:(NSString*)password{
    AttendeeDTO * user = nil;
    
    
    NSMutableString * loginUrl = [[NSMutableString alloc] initWithString:[MDWServerURLs getLoginURL]];
    [loginUrl appendString:username];
    [loginUrl appendString:@"&password="];
    [loginUrl appendString:password];
    
    printf("\n>> LoginURL is %s\n", [loginUrl UTF8String]);
    
    
    
    
    
    
    
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
-(BOOL) isEmailValid:(NSString *)email
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
@end
