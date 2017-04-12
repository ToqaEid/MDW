//
//  JETSSideMenu.m
//  MDW
//
//  Created by JETS on 4/10/17.
//  Copyright © 2017 JETS. All rights reserved.
//

#import "JETSSideMenu.h"

@implementation JETSSideMenu



-(void)viewDidLoad{
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 1){
        return 2;
    }else if (section == 2){
        return 3;
    }
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"Cell";
    

}
@end
