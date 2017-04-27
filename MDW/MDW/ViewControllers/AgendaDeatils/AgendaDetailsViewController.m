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
    _dateField.text = [DateConverter dayStringFromDate: _session.startDate];
    _timeField.text = [NSString stringWithFormat:@"%@ - %@", [DateConverter stringFromDate: _session.startDate] , [DateConverter stringFromDate: _session.endDate]];
    _detailsField.text = _session.SessionDescription;
    
    
    /////// Rating btn color?? ya toqa
    

}

-(void)viewDidLoad{
    model = [[AgendaDetailsModel alloc]initWithController:self];
    
    
    printf(" +++ SessionDetails is Loaded .... \n");
    
    
}

- (IBAction)ratingAction:(id)sender {
    
    
    if(_session.status == 0){
        
        //register session
        [model registerSessionWithSessionObj:_session AndEnforce:false];
        
        //change star image
       // [sender setBackgroundImage:[self getSessionStatusImage] forState:UIControlStateNormal];
        
    }else{
        
        //unregister session
        [model unregisterSession:_session];
      //  _session.status = 0;
        
        //change star image
        //UIImage *registerStar = [UIImage imageNamed:@"sessionnotadded.png"];
        //[sender setBackgroundImage:registerStar forState:UIControlStateNormal];
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




-(void) setStatusFromServer : (NSMutableDictionary*) dict{

    printf("### old = %d , status = %d\n",  [[dict objectForKey:@"oldSession"]intValue], [[dict objectForKey:@"status"]intValue] );
    
    int oldSession =  [[dict objectForKey:@"oldSession"]intValue];
    int status =  [[dict objectForKey:@"status"]intValue];
    
    
    if(oldSession == 0){
        
        ///1. register session
       // _session.status = status;
        
        ///2. change star image
        //[sender setBackgroundImage:[self getSessionStatusImage] forState:UIControlStateNormal];
        
        ///
        
    }else{
        
        //// alert dialoge
        
        
        
        
        
        /// Replace or Cancel
        
        ///// replace >>> req ::: enforce = true
                
        
        ////// cancel >> do nothing
        
        //        //unregister session
        //        [model unregisterSession:_session];
        //        _session.status = 0;
        //
        //        //change star image
        //        UIImage *registerStar = [UIImage imageNamed:@"sessionnotadded.png"];
        //        [sender setBackgroundImage:registerStar forState:UIControlStateNormal];
                
                
            }

    
    

}




@end
