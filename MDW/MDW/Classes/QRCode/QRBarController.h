//
//  QRBarController.h
//  MDW
//
//  Created by JETS on 4/12/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXMultiFormatWriter.h"
#import "ZXImage.h"


@interface QRBarController : NSObject


-(CGImageRef)encodeQRCode: (NSString*) encodedData;

@end
