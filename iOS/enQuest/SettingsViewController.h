//
//  SettingsViewController.h
//  enQuest
//
//  Created by Leo on 03/14/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController


@property(nonatomic, strong) IBOutlet UILabel *loginStatus;

- (IBAction)logout:(id)sender;

@end
