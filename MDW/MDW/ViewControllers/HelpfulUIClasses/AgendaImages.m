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






+(void)setImageFromURLString:(NSString *)url intoImageView:(UIImageView *)imageView andSaveObject:(id)object{
    
    
    printf("___________ setting image:: %s\n", [url UTF8String]);
    
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        //Setting ImageView
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:filePath];
        UIImage *image = [UIImage imageWithData: imageData];
        imageView.image = image;
        
        
        //        //Adding In DB
        //        if([object isKindOfClass:[ExhibitorDTO class]]){
        //            ((ExhibitorDTO *) object).image = imageData;
        //            [[DBHandler getDB] addOrUpdateExhibitor:object];
        //        }else if ([object isKindOfClass:[SpeakerDTO class]]){
        //            ((SpeakerDTO *) object).image = imageData;
        //            [[DBHandler getDB] addOrUpdateSpeaker:object];
        //        }
        //        
        
        
    }];
    [downloadTask resume];
    
    
}






@end
