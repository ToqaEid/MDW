//
//  AgendaImages.h
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionDTO.h"

@interface AgendaImages : UIView

+(UIImage*)getSessionImage :(SessionDTO *)session;
@end
