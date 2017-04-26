//
//  MyContactModel.h
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttendeeDTO.h"
#import "NSUserDefaultForObject.h"


static AttendeeDTO * user ;

@interface MyContactModel : NSObject


-(void)getUserInfoFromUserDefault;
+(AttendeeDTO * )getUser;


@end
