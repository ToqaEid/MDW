//
//  AgendaDetailsViewController.m
//  MDW
//
//  Created by JETS on 4/15/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "AgendaDetailsViewController.h"


@implementation AgendaDetailsViewController{
    AgendaDetailsModel * model;
}


-(void)viewWillAppear:(BOOL)animated{
    _titleField.text = _session.name;
    _titleField.numberOfLines = 0;
    _titleField.adjustsFontSizeToFitWidth = YES;
    
    _dateField.text = [DateConverter dateStringFromDate: _session.startDate];
    
    _timeField.text = [NSString stringWithFormat:@"%@ - %@", [DateConverter stringFromDate: _session.startDate] , [DateConverter stringFromDate: _session.endDate]];
    
    _detailsField.text = _session.SessionDescription;
    _detailsField.numberOfLines = 0;
    _detailsField.adjustsFontSizeToFitWidth = YES;
    
    _locationField.text = _session.location;
    [_starButton setBackgroundImage:[self getSessionStatusImage] forState:UIControlStateNormal];


}

-(void)viewDidLoad{
    model = [[AgendaDetailsModel alloc]initWithController:self];
    
    
    printf(" +++ SessionDetails is Loaded .... \n");
    
    printf("\nsession details %d\n", _session.status);
}

- (IBAction)ratingAction:(id)sender {
    
    printf("SessionStatus is %d\n", _session.status);

    if(_session.status == 0){
        
        //register session
        [self.view makeToast:@"Registering Session"
                    duration:2.0
                    position:CSToastPositionCenter
                    title:nil
                    image:nil
                    style:nil
                    completion:^(BOOL didTap) {
                      [self.view makeToastActivity:CSToastPositionCenter];
                  }];
        
        [model registerSession:_session];
        
        //change star image
        [sender setBackgroundImage:[self getSessionStatusImage] forState:UIControlStateNormal];
        
        
        
        
    }else{
        
        //unregister session
        [model unregisterSession:_session];
        _session.status = 0;
        
        //change star image
        
        UIImage *registerStar = [UIImage imageNamed:@"sessionnotadded.png"];
        [sender setBackgroundImage:registerStar forState:UIControlStateNormal];
    }
    
}

-(UIImage*)getSessionStatusImage{
    UIImage *registerStar;
    if(_session.status == 1){
        registerStar = [UIImage imageNamed:@"sessionpending.png"];
    }else if(_session.status == 2){
        registerStar = [UIImage imageNamed:@"sessionapproved.png"];
    }else {
        registerStar = [UIImage imageNamed:@"sessionnotadded.png"];
    }
    return registerStar;

}

-(void) showToast : (NSString *) msg{
    [self.view makeToast:msg];
}

@end
