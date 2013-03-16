//
//  SearchingTurtleDelegate.h
//  Risotto
//
//  Created by Leo Hsu on 07/24/10.
//  Copyright 2010 Ting Chen Leo Hsu. All rights reserved.
//

@class LoginTurtle;

@protocol LoginTurtleDelegate <NSObject>
@optional
- (void)loginTurtleDidFinishLogin:(LoginTurtle *)turtle;
- (void)loginTurtleDidFailLogin:(LoginTurtle *)turtle withError:(NSError*)error;

@end
