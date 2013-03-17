//
//  CSRFTurtle.h
//  enQuest
//
//  Created by Leo on 03/17/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import "Turtle.h"

@protocol CSRFTurtleDelegate;

@interface CSRFTurtle : Turtle

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) id<CSRFTurtleDelegate> delegate;

- (void)getToken;

@end
