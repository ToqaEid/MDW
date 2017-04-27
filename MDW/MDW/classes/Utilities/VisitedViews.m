//
//  VisitedViews.m
//  MDW
//
//  Created by JETS on 4/25/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "VisitedViews.h"

static BOOL Agenda = NO;
static BOOL MyAgenda = NO;
static BOOL Speakers = NO;
static BOOL Exhibitors = NO;


@implementation VisitedViews


+(BOOL) getAgenda{
    return Agenda;
}
+(BOOL) getMyAgenda{
    return MyAgenda;
}
+(BOOL) getSpeakers{
    return Speakers;
}
+(BOOL) getExhibitors{
    return Exhibitors;
}

+(void) setAgenda: (BOOL) _agenda{
    Agenda = _agenda;
}
+(void) setMyAgenda: (BOOL) _myAgenda{
    MyAgenda = _myAgenda;
}

+(void) setSpeakers: (BOOL) _speakers{
    Speakers = _speakers;
}

+(void) setExhibitors: (BOOL) _exhibitors{
    Exhibitors = _exhibitors;
}

+(void) setAllViewsAsUnVisited {
    Agenda = NO;
    MyAgenda = NO;
    Speakers = NO;
    Exhibitors = NO;
}

@end
