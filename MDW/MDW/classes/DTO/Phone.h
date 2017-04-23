//
//  Phone.h
//  REALM
//
//  Created by JETS on 4/12/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Realm/Realm.h>

@interface Phone : RLMObject
@property NSString *phone;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Phone *><Phone>
RLM_ARRAY_TYPE(Phone)
