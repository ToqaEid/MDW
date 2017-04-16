//
//  AttendeeDTO.h
//  REALM
//
//  Created by JETS on 4/12/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Realm/Realm.h>
#import "Mobile.h"
#import "Phone.h"

@interface AttendeeDTO : NSObject <NSCoding>
@property int attendeeId;
@property NSString *firstName,*middleName,*lastName,*email,*countryName,*cityName,*code,*companyName,*title,*imageURL;
@property BOOL gender;
@property NSDate *birthDate;
@property NSMutableArray *mobiles,*phones;
@end
