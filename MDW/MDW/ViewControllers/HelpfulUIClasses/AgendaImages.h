//
//  AgendaImages.h
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionDTO.h"


#import <AFNetworking.h>
#import <AFImageDownloader.h>
#import <UIImageView+AFNetworking.h>


@interface AgendaImages : UIView

+(UIImage*)getSessionImage :(SessionDTO *)session;



+(void)setImageFromURLString:(NSString *)url intoImageView:(UIImageView *)imageView andSaveObject: (id)object;


@end
