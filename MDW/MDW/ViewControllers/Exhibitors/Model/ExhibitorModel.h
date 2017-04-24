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

@interface ExhibitorModel : NSObject

-(id)initWithController: (ExhibitorsViewController*) exhibitorController;

-(void) getExhibitorsFromNetwork : (NSString *) username;


@end
