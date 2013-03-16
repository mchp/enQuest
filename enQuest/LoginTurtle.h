//
//  SearchingTurtle.h
//  Risotto
//
//  Created by Leo Hsu on 07/07/10.
//  Copyright 2010 Ting Chen Leo Hsu. All rights reserved.
//

#import "Turtle.h"

@protocol LoginTurtleDelegate;

@interface LoginTurtle : Turtle

@property BOOL success;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, weak) id<LoginTurtleDelegate> delegate;

- (id)initWithUsername:(NSString*)username password:(NSString*)password;
- (void)login;

@end
