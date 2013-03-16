//
//  LogoutTurtleDelegate.h
//  enQuest
//
//  Created by Leo on 03/15/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LogoutTurtle;

@protocol LogoutTurtleDelegate <NSObject>
@optional
- (void)logoutTurtleDidFinishLogout:(LogoutTurtle *)turtle;
- (void)logoutTurtleDidFailLogout:(LogoutTurtle *)turtle withError:(NSError*)error;

@end
