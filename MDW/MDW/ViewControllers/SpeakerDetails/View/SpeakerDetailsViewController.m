//
//  SpeakerDetailsViewController.m
//  MDW
//
//  Created by JETS on 4/15/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "SpeakerDetailsViewController.h"

@implementation SpeakerDetailsViewController

-(void)viewWillAppear:(BOOL)animated{
    _name.text =[NSString stringWithFormat:@"%@ %@ %@",_speaker.firstName ,_speaker.middleName,  _speaker.lastName] ;
    _jobTitle.text = _speaker.title;
    _details.text = _speaker.description;
    _company.text = _speaker.companyName;
    _image.image = [UIImage imageWithData:_speaker.image ];
    
    printf("SpeakerDetailsViewController view :viewWillAppear\n");
    
    
    

}




@end
