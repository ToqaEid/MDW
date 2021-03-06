//
//  SpeakersModel.h
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//
@class SpeakersViewController;

#import <Foundation/Foundation.h>
#import "SpeakersViewController.h"
#import "Connection.h"
#import "speakerDAO.h"
#import "NSUserDefaultForObject.h"


@interface SpeakersModel : NSObject

-(id)initWithController: (SpeakersViewController*) controller;

-(NSMutableArray*) getSpeakersFromDB;

-(void) getSpeakersFromNetwork ;


@end
