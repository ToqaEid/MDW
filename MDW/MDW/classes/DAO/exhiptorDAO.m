//
//  exhiptorDAO.m
//  REALM
//
//  Created by JETS on 4/13/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "exhiptorDAO.h"

@implementation exhiptorDAO
static exhiptorDAO* exhiptor=nil;
+(exhiptorDAO *)sharedInstance{
    if (exhiptor==nil) {
        exhiptor=[exhiptorDAO new];
    }
    return exhiptor;
}
-(BOOL)saveExhiptors:(NSMutableArray *)exhiptors{
    RLMRealm *realm=[RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObjects:exhiptors];
    [realm commitWriteTransaction];
    return YES;
}
-(RLMResults *)getAllExhiptors{
    RLMResults<ExhiptorsDTO*> *exhiptors=[ExhiptorsDTO allObjects];
    return exhiptors;
}

-(BOOL)updateImage:(ExhiptorsDTO *)ex{
    RLMRealm *realm=[RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:ex];
    [realm commitWriteTransaction];
    return YES;
}
@end
