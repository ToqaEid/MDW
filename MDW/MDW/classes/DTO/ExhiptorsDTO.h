//
//  ExhiptorsDTO.h
//  REALM
//
//  Created by JETS on 4/13/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Realm/Realm.h>
#import "Mobile.h"
#import "Phone.h"

@interface ExhiptorsDTO : RLMObject
@property int exhiptorId;
@property NSString *email,*countryName,*cityName,*companyName,*companyAbout,*fax,*contactName,*contactTitle,*companyURL,*companyAddress, *imageURL;
@property NSData *image;
@property RLMArray<Mobile*><Mobile> *mobiles;
@property RLMArray<Phone*><Phone> *phones;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<ExhiptorsDTO *><ExhiptorsDTO>
RLM_ARRAY_TYPE(ExhiptorsDTO)
