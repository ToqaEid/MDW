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
    _name.text = _speakerName;
    _jobTitle.text = _speakerJob;
    //_details.text = _speakerDetails;
    _company.text = _speakerCompany;
    //_image.image = _speakerImage;
    
    printf("SpeakerDetailsViewController view :viewWillAppear\n");
    
    
    

}




@end
