//
//  MyContactModel.m
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "MyContactModel.h"

@implementation MyContactModel

-(AttendeeDTO *)getUserInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:@"user"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
}


@end
