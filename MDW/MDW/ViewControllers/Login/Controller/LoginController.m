//
//  LoginController.m
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "LoginController.h"

@implementation LoginController{
    LoginModel* model;
}

-(instancetype)init{
    model = [[LoginModel alloc]init];
    return self;
}


-(AttendeeDTO*)checkUserWithUsername:(NSString*)username AndPassword:(NSString*)password{
    return [model checkUser:username:password];
}

-(BOOL)checkInternetConnection{
    return [model checkInternetConnection];
}


-(void)saveUserInfoLocally: (AttendeeDTO*)user{

    [model saveUserLocally:user];
}
@end
