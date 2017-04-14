//
//  SpeakerDTO.h
//  REALM
//
//  Created by JETS on 4/12/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Realm/Realm.h>
#import "Mobile.h"
#import "Phone.h"

@interface SpeakerDTO : RLMObject
@property int speakerId;
@property NSString *firstName,*middleName,*lastName,*imageUrl,*companyName,*title,*biography;
@property BOOL gender;
@property RLMArray<Mobile*><Mobile> *mobiles;
@property RLMArray<Phone*><Phone> *phones;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<SpeakerDTO *><SpeakerDTO>
RLM_ARRAY_TYPE(SpeakerDTO)
