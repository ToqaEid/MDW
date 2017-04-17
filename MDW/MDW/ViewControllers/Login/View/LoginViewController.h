//
//  LoginViewController.h
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginController.h"
#import "AlertClass.h"
#import "AttendeeDTO.h"
#import "SWRevealViewController.h"

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordFied;
- (IBAction)loginAction:(id)sender;
- (IBAction)registerAction:(id)sender;
@end
