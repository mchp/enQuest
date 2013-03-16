//
//  AppDelegate.h
//  enQuest
//
//  Created by Leo on 03/13/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginManagerDelegate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, LoginManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
