//
//  LoginViewController.m
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "LoginViewController.h"


@implementation LoginViewController{
    LoginModel *model;
    
}

-(void)viewDidLoad{
    model = [[LoginModel alloc]initWithController:self];
}

-(void) goToNextView{
    printf("***************************\nLogin: login success\n***************************\n");
    
    SWRevealViewController * home = [self.storyboard instantiateViewControllerWithIdentifier:@"home"];
    [self dismissViewControllerAnimated:NO completion:nil];
    [self presentViewController:home animated:YES completion:nil];
}


-(void) showErrorMsgWithMsg:(NSString *)msg usernameError:(BOOL) errorCheck{
    UIAlertController * alert =[AlertClass infoAlertwithTitle:@"Login Failed" AndMsg:msg];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    _passwordFied.text = @"";
    
    if(errorCheck){
        _usernameField.text = @"";
    }

}

- (IBAction)loginAction:(id)sender {
    
    AttendeeDTO * user =[model checkUserWithUsername:_usernameField.text AndPassword:_passwordFied.text];
    

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
