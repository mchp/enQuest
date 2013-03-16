//
//  EQloginViewController.h
//  enQuest
//
//  Created by Leo on 03/13/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginTurtle.h"

@interface EQloginViewController : UIViewController <LoginTurtleDelegate>

- (IBAction)login:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *username_field;
@property (strong, nonatomic) IBOutlet UITextField *password_field;

@end
