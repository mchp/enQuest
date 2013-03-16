//
//  SYNTHESIZE_GOD.h
//  CocoaWithLove
//
//  Created by Matt Gallagher on 20/10/08.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#define SYNTHESIZE_GOD(classname,sharedname) \
 \
static classname * sharedname = nil; \
 \
+ (classname *)sharedname \
{ \
	@synchronized(self) \
	{ \
		if (sharedname == nil) \
		{ \
			sharedname = [[self alloc] init]; \
		} \
	} \
	 \
	return sharedname; \
}
