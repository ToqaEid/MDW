//
//  MyContactModel.m
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "MyContactModel.h"

@implementation MyContactModel

-(void)getUserInfoFromUserDefault{
    user = [NSUserDefaultForObject getObjectForKey:@"user"];
    
    printf("firstName : %s\n", [user.firstName UTF8String]);
}

+(AttendeeDTO * )getUser{
    return user;
}


@end
