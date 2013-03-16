//
//  LogoutTurtle.h
//  enQuest
//
//  Created by Leo on 03/15/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import "Turtle.h"

@protocol LogoutTurtleDelegate;

@interface LogoutTurtle : Turtle

@property (nonatomic, weak) id<LogoutTurtleDelegate> delegate;

- (void)logout;


@end
