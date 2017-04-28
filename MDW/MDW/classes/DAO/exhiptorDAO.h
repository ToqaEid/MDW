//
//  exhiptorDAO.h
//  REALM
//
//  Created by JETS on 4/13/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "ExhiptorsDTO.h"

@interface exhiptorDAO : NSObject
+(exhiptorDAO *)sharedInstance;
-(BOOL)saveExhiptors:(NSMutableArray*) exhiptors;
-(RLMResults*)getAllExhiptors;
-(BOOL)updateImage:(ExhiptorsDTO*)ex;
-(BOOL)addExhiptor:(ExhiptorsDTO*)ex;
@end
