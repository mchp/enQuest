//
//  SettingsViewController.h
//  enQuest
//
//  Created by Leo on 03/14/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginManagerDelegate.h"

@interface SettingsViewController : UITableViewController <LoginManagerDelegate>


@property(nonatomic, strong) IBOutlet UILabel *loginStatus;
@property(nonatomic, strong) IBOutlet UIButton *logoutButton;

- (IBAction)logout:(id)sender;

@end
