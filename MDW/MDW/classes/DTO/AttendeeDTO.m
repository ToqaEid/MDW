//
//  AttendeeDTO.m
//  REALM
//
//  Created by JETS on 4/12/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "AttendeeDTO.h"

@implementation AttendeeDTO

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_code forKey:@"code"];
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_cityName forKey:@"cityName"];
    [aCoder encodeObject:_lastName forKey:@"lastName"];
    [aCoder encodeObject:_middleName forKey:@"middleName"];
    [aCoder encodeObject:_firstName forKey:@"firstName"];
    [aCoder encodeObject:_imageURL forKey:@"imageURL"];
    [aCoder encodeObject:_companyName forKey:@"companyName"];
    [aCoder encodeObject:_countryName forKey:@"countryName"];
    [aCoder encodeObject:_birthDate forKey:@"birthDate"];
    [aCoder encodeObject:_phones forKey:@"phones"];
    [aCoder encodeObject:_mobiles forKey:@"mobiles"];
    [aCoder encodeInt:_attendeeId forKey:@"attendeeId"];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    _code=[aDecoder decodeObjectForKey:@"code"];
    _email=[aDecoder decodeObjectForKey:@"email"];
    _title=[aDecoder decodeObjectForKey:@"title"];
    _cityName=[aDecoder decodeObjectForKey:@"cityName"];
    _lastName=[aDecoder decodeObjectForKey:@"lastName"];
    _middleName=[aDecoder decodeObjectForKey:@"middleName"];
    _firstName=[aDecoder decodeObjectForKey:@"firstName"];
    _imageURL=[aDecoder decodeObjectForKey:@"imageURL"];
    _companyName=[aDecoder decodeObjectForKey:@"companyName"];
    _countryName=[aDecoder decodeObjectForKey:@"countryName"];
    _birthDate=[aDecoder decodeObjectForKey:@"birthDate"];
    _phones=[aDecoder decodeObjectForKey:@"phones"];
    _mobiles=[aDecoder decodeObjectForKey:@"mobiles"];
    _attendeeId=[aDecoder decodeIntForKey:@"attendeeId"];
    return self;
}

@end
