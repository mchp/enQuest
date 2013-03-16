//
//  RegistrationTurtle.h
//  enQuest
//
//  Created by Leo on 03/14/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import "Turtle.h"

@protocol RegistrationTurtleDelegate;

@interface RegistrationTurtle : Turtle

@property BOOL success;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, weak) id<RegistrationTurtleDelegate> delegate;

- (void)registerWithUsername:(NSString*)username password:(NSString*)password email:(NSString*)email;

@end
