//
//  LoginViewController.h
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

@class LoginModel;

#import <UIKit/UIKit.h>
#import "LoginModel.h"
#import "AlertClass.h"
#import "AttendeeDTO.h"
#import "SWRevealViewController.h"
#import "Connection.h"

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordFied;
- (IBAction)loginAction:(id)sender;
- (IBAction)registerAction:(id)sender;
-(void) goToNextView;
-(void) showErrorMsgWithMsg:(NSString *)msg usernameError:(BOOL) errorCheck;
@end
