//
//  LoginViewController.m
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController{
    LoginController *controller;
    
}

-(instancetype)init{
    return self;
}

- (IBAction)loginAction:(id)sender {
    
    if ([controller isEmailValid:_usernameField.text]) {
    if(![controller checkInternetConnection]){
        
        AttendeeDTO * user =[controller checkUserWithUsername:_usernameField.text AndPassword:_passwordFied.text];
        
        if(user == nil){
            
            //save user locally
            //[controller saveUserInfoLocally: user];
            
            //Going to the Home
            SWRevealViewController * home = [self.storyboard instantiateViewControllerWithIdentifier:@"home"];
            [self presentViewController:home animated:YES completion:nil];
            
        
        }else{  //wrong username or password
 
            UIAlertController * alert =[AlertClass infoAlertwithTitle:@"Login Failed" AndMsg:@"Invalid username or password"];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else{  //no internet connection
        
        UIAlertController * alert =[AlertClass infoAlertwithTitle:@"Login Failed" AndMsg:@"Sorry, unable to login. Please check your internet connection."];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    }
    else{
        UIAlertController *notValidEmail=[AlertClass infoAlertwithTitle:@"Login Failed" AndMsg:@"Invalid Email"];
        [self presentViewController:notValidEmail animated:YES completion:nil];
    }
}

- (IBAction)registerAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.mobiledeveloperweekend.net/attendee/registration.htm"]];
}


@end
