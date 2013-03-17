//
//  CSRFTurtleDelegate.h
//  enQuest
//
//  Created by Leo on 03/17/13.
//  Copyright (c) 2013 iteloolab. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CSRFTurtle;

@protocol CSRFTurtleDelegate <NSObject>
@optional
- (void)CSRFTurtle:(CSRFTurtle *)turtle didGetToken:(NSString *)token;
- (void)CSRFTurtleDidFailGetToken:(CSRFTurtle *)turtle withError:(NSError*)error;

@end
