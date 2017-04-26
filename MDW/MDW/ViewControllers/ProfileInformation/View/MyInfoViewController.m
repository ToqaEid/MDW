//
//  MyInfoViewController.m
//  MDW
//
//  Created by JETS on 4/15/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "MyInfoViewController.h"

@implementation MyInfoViewController{
    MyContactModel * model;
    AttendeeDTO *user;
}


-(void)viewDidLoad{
    
    
    
    //side menu
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:revealViewController
                                                                            action:@selector(revealToggle:)];
        
        
        self.navigationItem.leftBarButtonItem = revealButtonItem;
        
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    model = [MyContactModel new];
    
    [model getUserInfoFromUserDefault];
    
    user = [MyContactModel getUser];
    
    _myName.text = [NSString stringWithFormat:@"%@ %@ %@", user.firstName, user.middleName, user.lastName];
    _myTitle.text = user.title;
    _myCompany.text = user.companyName;
    
}
@end
