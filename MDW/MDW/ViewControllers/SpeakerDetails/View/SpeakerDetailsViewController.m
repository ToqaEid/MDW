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
    _name.numberOfLines = 0;
    _name.adjustsFontSizeToFitWidth = YES;
    
    _jobTitle.numberOfLines = 0;
    _jobTitle.adjustsFontSizeToFitWidth = YES;
    _jobTitle.text = _speaker.title;
    
    _detailsField.attributedText = [LabelRendering renderHTML:_speaker.biography];
     CGSize sizeThatFitsTextView = [_detailsField sizeThatFits:_detailsField.frame.size];
    _heightDetails.constant = sizeThatFitsTextView.height;

    
    _company.numberOfLines = 0;
    _company.adjustsFontSizeToFitWidth = YES;
    _company.text = _speaker.companyName;
    
    

    
    if ( _speaker.image == nil ){
        
        // [self setImageFromURLString: speakerDTO.imageURL  intoImageView:icon andSaveObject:speakerDTO];
        _image.image = [UIImage imageNamed:@"speaker.png"];
        
    }else{
        
        _image.image = [UIImage imageWithData:_speaker.image ];
        
    }
    printf("SpeakerDetailsViewController view :viewWillAppear\n");
    
    
    printf(">>> %s", [_speaker.description UTF8String] );

}




@end
