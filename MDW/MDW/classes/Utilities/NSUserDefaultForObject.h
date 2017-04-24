//
//  NSUserDefaultForObject.h
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaultForObject : NSObject

+(void)saveObjectWithObject: (NSObject *)object key:(NSString *)key;
@end
