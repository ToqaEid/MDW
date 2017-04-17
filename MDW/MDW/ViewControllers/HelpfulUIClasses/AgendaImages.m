//
//  AgendaImages.m
//  MDW
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "AgendaImages.h"

@implementation AgendaImages

+(UIImage*)getSessionImage :(SessionDTO *)session{
    UIImage * image;
    //image
    if([session.sessionType isEqualToString:@"Break"]){
        image =[UIImage imageNamed:@"breakicon.png"];
    }else if ([session.sessionType isEqualToString:@"Hackathon"]){
        image = [UIImage imageNamed:@"hacathon.png"];
    }else if ([session.sessionType isEqualToString:@"Session"]){
        image = [UIImage imageNamed:@"session.png"];
    }else if ([session.sessionType isEqualToString:@"Workshop"]){
        image = [UIImage imageNamed:@"workshop.png"];
    }
    return image;

}

@end
