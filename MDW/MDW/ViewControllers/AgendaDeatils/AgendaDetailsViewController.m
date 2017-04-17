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
    _titleField.text = _sessionTitle;
    _dateField.text = _sessionDate;
    _timeField.text = _sessionTime;
    _detailsField.text = _sessionDetails;

}

-(void)viewDidLoad{
    model = [[AgendaDetailsModel alloc]initWithController:self];
}

- (IBAction)ratingAction:(id)sender {
    [model registerSession];
}
@end
