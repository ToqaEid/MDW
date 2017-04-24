//
//  NSUserDefaultForObject.m
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "NSUserDefaultForObject.h"

@implementation NSUserDefaultForObject

+(void)saveObjectWithObject: (NSObject *)object key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
}

+(BOOL)checkObjectExistanceWithKey: (NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSObject * object = [defaults objectForKey:key];
    if(object != nil){
        return YES;
    }
    return NO;
}

+(void) removeObjectWithKey :(NSString *) key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}
@end
