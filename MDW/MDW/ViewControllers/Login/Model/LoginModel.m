//
//  LoginModel.m
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "LoginModel.h"
#import "MDWServerURLs.h"
#import "MDW_JsonParser.h"

@implementation LoginModel{
    LoginViewController * controller;
}


-(id)initWithController: (LoginViewController*) loginController{
    
    controller = loginController;
    return [self init];
}

-(AttendeeDTO*)checkUserWithUsername:(NSString*)username AndPassword:(NSString*)password{
    AttendeeDTO * user = nil;
    
    
    NSMutableString * loginUrl = [[NSMutableString alloc] initWithString:[MDWServerURLs getLoginURL]];
    [loginUrl appendString:username];
    [loginUrl appendString:@"&password="];
    [loginUrl appendString:password];
    
    //printf("\n>> LoginURL is %s\n", [loginUrl UTF8String]);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET: [NSString stringWithString:loginUrl]  parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
        //NSLog(@"JSON: %@", responseObject);
       // printf("Login Response recieved ... \n");
        
        NSDictionary * rootJson = responseObject;
        NSString  * responseStatus = [rootJson objectForKey:@"status"];
        
        if (  [responseStatus isEqualToString:@"view.success"]  )
        {
            ///////// login Success
            
            /////////save in user default
            
            NSDictionary * attendeeJson = [rootJson objectForKey:@"result"];
            AttendeeDTO * attendeeObj = [MDW_JsonParser parseToAttendeeObj:attendeeJson];
        
            
            //// set attendee to NSUserDefaults
            [NSUserDefaultForObject saveObjectWithObject:attendeeObj key:@"user"];

            ///////// Going to the Home
            
            [controller goToNextView];
            
            
        }else{
            //////// login Failed
            //////// check failure reason
            
            printf("***************Login: login failed********************\n");
            
            NSString * failureStr = [rootJson objectForKey:@"result"];
            
            if ([failureStr isEqualToString:@"Invalid User Name"]){   ///// Email does not exists
                
                [controller showErrorMsgWithMsg:failureStr usernameError: YES];
                
                
            }else{  /////// password is not correct "Invalid authentication"
                
                [controller showErrorMsgWithMsg:failureStr usernameError: NO];
            }
            
            
        }
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        
        [controller showErrorMsgWithMsg:@"Sorry, unable to login. Please check your internet connection." usernameError: YES];
        
        
    }];
 
    
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
