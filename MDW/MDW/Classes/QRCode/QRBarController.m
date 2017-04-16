//
//  QRBarController.m
//  MDW
//
//  Created by JETS on 4/12/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "QRBarController.h"

@implementation QRBarController

-(CGImageRef)encodeQRCode: (NSString*) encodedData{
    
    
    NSError *error = nil;
    CGImageRef image = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:encodedData
                                  format:kBarcodeFormatQRCode
                                   width:500
                                  height:500
                                   error:&error];
    if (result) {
         image = [[ZXImage imageWithMatrix:result] cgimage];
        
        // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
    }
    return image;
}

@end
