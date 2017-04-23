//
//  Mobile.h
//  REALM
//
//  Created by JETS on 4/12/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Realm/Realm.h>

@interface Mobile : RLMObject
@property NSString *mobile;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Mobile *><Mobile>
RLM_ARRAY_TYPE(Mobile)
