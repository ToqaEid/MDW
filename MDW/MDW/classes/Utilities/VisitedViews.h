//
//  VisitedViews.h
//  MDW
//
//  Created by JETS on 4/25/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VisitedViews : NSObject


+(BOOL) getAgenda;
+(BOOL) getMyAgenda;
+(BOOL) getSpeakers;
+(BOOL) getExhibitors;

-(void) setAgenda: (BOOL) _agenda;
-(void) setMyAgenda: (BOOL) _myAgenda;
-(void) setSpeakers: (BOOL) _speakers	;
-(void) setExhibitors: (BOOL) _exhibitors;

@end
