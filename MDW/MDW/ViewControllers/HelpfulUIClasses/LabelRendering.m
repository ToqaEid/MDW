//
//  LabelRendering.m
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "LabelRendering.h"

@implementation LabelRendering

+(NSAttributedString*) renderHTML:(NSString*) htmlString{
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                                                options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                                documentAttributes:nil
                                                                error:nil];
    
    
    return attrStr;
}


@end
