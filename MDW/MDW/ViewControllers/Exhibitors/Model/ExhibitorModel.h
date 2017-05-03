//
//  ExhibitorModel.h
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//


@class ExhibitorsViewController;

#import <Foundation/Foundation.h>
#import "ExhibitorsViewController.h"
#import "NSUserDefaultForObject.h"
#import "ExhiptorsDTO.h"
#import "exhiptorDAO.h"

@interface ExhibitorModel : NSObject

-(id)initWithController: (ExhibitorsViewController*) exhibitorController;

-(void) getExhibitorsFromNetwork;

-(NSMutableArray *) getExhibitorsFromDB;


-(BOOL)isConnected;


@end
