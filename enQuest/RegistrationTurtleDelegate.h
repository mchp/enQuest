//
//  RegistrationTurtleDelegate.h
//  enQuest
//
//  Created by Leo on 03/14/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RegistrationTurtle;

@protocol RegistrationTurtleDelegate <NSObject>
@optional
- (void)registrationTurtleDidFinishRegister:(RegistrationTurtle *)turtle;
- (void)registrationTurtleDidFailRegister:(RegistrationTurtle *)turtle withError:(NSError*)error;

@end
