//
//  NSUserDefaultForObject.h
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttendeeDTO.h"

@interface NSUserDefaultForObject : NSObject

+(void)saveObjectWithObject: (AttendeeDTO *)object key:(NSString *)key;
+(void) removeObjectWithKey :(NSString *) key;
+(BOOL)checkObjectExistanceWithKey: (NSString*)key;
+(AttendeeDTO*) getObjectForKey : (NSString *) key;
@end
