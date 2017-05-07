//
//  LabelRendering.m
//  MDW
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "LabelRendering.h"

@implementation LabelRendering

+(NSMutableAttributedString*) renderHTML:(NSString*) htmlString{
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                                documentAttributes:nil
                                                                error:nil];
//    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragrahStyle setLineBreakMode:NSLineBreakByWordWrapping];
//    
//    [paragrahStyle setAlignment:NSTextAlignmentCenter];
    
//    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, [attrStr length])];
    
    printf("\n\n********%lu********\nn", (unsigned long)attrStr.length);
    return attrStr;
}


@end
