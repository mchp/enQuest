#import "SYNTHESIZE_GOD.h"

#import "MasterQueueManager.h"


@implementation MasterQueueManager

SYNTHESIZE_GOD(MasterQueueManager, sharedQueueManager);

@synthesize mainQueue;

- (id)init {
	if ((self = [super init])) {
		mainQueue = [[NSOperationQueue alloc] init];
	}
	return self;
}

@end
