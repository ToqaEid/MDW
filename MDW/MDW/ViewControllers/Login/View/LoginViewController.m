//
//  LoginViewController.m
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "LoginViewController.h"
#import "MDWServerURLs.h"
#import <AFNetworking.h>
#import "MDW_JsonParser.h"


@implementation LoginViewController{
    LoginModel *model;
    
}

-(instancetype)init{
    return self;
}

- (IBAction)loginAction:(id)sender {
    
    
    
      NSMutableString * loginUrl = [[NSMutableString alloc] initWithString:[MDWServerURLs getLoginURL]];
    [loginUrl appendString: _usernameField.text];
    [loginUrl appendString:@"&password="];
    [loginUrl appendString: _passwordFied.text];
    
    printf("\n>> LoginURL is %s\n", [loginUrl UTF8String]);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET: [NSString stringWithString:loginUrl]  parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        printf("Login Response recieved ... \n");
        
        NSDictionary * rootJson = responseObject;
        NSString  * responseStatus = [rootJson objectForKey:@"status"];
        
        if (  [responseStatus isEqualToString:@"view.success"]  )
        {
            ///////// login Success
            ///////// Going to the Home
            
            SWRevealViewController * home = [self.storyboard instantiateViewControllerWithIdentifier:@"home"];
         
            [self presentViewController:home animated:YES completion:nil];
            
        
        }else{
            //////// login Failed
            //////// check failure reason
            
            NSString * failureStr = [rootJson objectForKey:@"result"];
            
            if ([failureStr isEqualToString:@"Invalid User Name"]){   ///// Email does not exists
            
                UIAlertController * alert =[AlertClass infoAlertwithTitle:@"Login Failed" AndMsg:@"Sorry! Email does not exists!"];
                
                [self presentViewController:alert animated:YES completion:nil];
                
                _usernameField.text = @"";
                _passwordFied.text = @"";
            
            
            }else{  /////// password is not correct "Invalid authentication"
                
                UIAlertController * alert =[AlertClass infoAlertwithTitle:@"Login Failed" AndMsg:@"Sorry! Password is not correct"];
                
                [self presentViewController:alert animated:YES completion:nil];
                
                _passwordFied.text = @"";
                
            }
            
            
        }
        
        
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        
        UIAlertController * alert =[AlertClass infoAlertwithTitle:@"Login Failed" AndMsg:@"Check your internat connection!"];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        _usernameField.text = @"";
        _passwordFied.text = @"";
        

        
    }];

//    
//    
//    
//    AttendeeDTO * user =[LoginModel checkUserWithUsername:_usernameField.text AndPassword:_passwordFied.text];
//    
//    if( user == nil )
//    {
//        UIAlertController * alert =[AlertClass infoAlertwithTitle:@"Login Failed" AndMsg:@"Invalid username or password"];
//        
//        [self presentViewController:alert animated:YES completion:nil];
//        
//        _usernameField.text = @"";
//        _passwordFied.text = @"";
//        
//    
//    }else{
//    
//       // Going to the Home
//        
//        SWRevealViewController * home = [self.storyboard instantiateViewControllerWithIdentifier:@"home"];
//        
//        [self presentViewController:home animated:YES completion:nil];
//        
//        
//    
//    }
//    
    
    
////////------------------------------
    
//    if([Connection checkInternetConnection]){
//      //  if ([model isEmailValid:_usernameField.text]) {
//            
//            AttendeeDTO * user =[model checkUserWithUsername:_usernameField.text AndPassword:_passwordFied.text];
//        
//            if(user == nil){
//            
//                //save user locally
//                //[controller saveUserInfoLocally: user];
//            
//                //Going to the Home
//                SWRevealViewController * home = [self.storyboard instantiateViewControllerWithIdentifier:@"home"];
//               // [self presentViewController:home animated:YES completion:nil];
//            
//        
//            }else{  //wrong username or password
// 
//                UIAlertController * alert =[AlertClass infoAlertwithTitle:@"Login Failed" AndMsg:@"Invalid username or password"];
//            
//                [self presentViewController:alert animated:YES completion:nil];
//                _usernameField.text = @"";
//                _passwordFied.text = @"";
//            }
//        }else{  //wrong email
//            
//            UIAlertController *notValidEmail=[AlertClass infoAlertwithTitle:@"Login Failed" AndMsg:@"Invalid Email"];
//            [self presentViewController:notValidEmail animated:YES completion:nil];
//        }
//    
//    }else{  //no internet connection
//        
//        UIAlertController * alert =[AlertClass infoAlertwithTitle:@"Login Failed" AndMsg:@"Sorry, unable to login. Please check your internet connection."];
//        
//        [self presentViewController:alert animated:YES completion:nil];
//    
//    }

}

- (IBAction)registerAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.mobiledeveloperweekend.net/attendee/registration.htm"]];
}


@end
