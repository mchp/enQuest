//
//  MasterQueueManager.h
//  enQuest

@interface MasterQueueManager : NSObject

@property (nonatomic, strong) NSOperationQueue *mainQueue;

+ (MasterQueueManager *)sharedQueueManager;

@end
