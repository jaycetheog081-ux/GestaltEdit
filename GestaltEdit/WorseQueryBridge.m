#import "WorseQueryBridge.h"
#import <Foundation/Foundation.h>

@implementation WorseQueryBridge

- (BOOL)writeExploitData:(NSDictionary *)plistDictionary toPath:(NSString *)targetPath {
    NSURL *targetURL = [NSURL fileURLWithPath:targetPath];
    NSError *error = nil;
    
    // Convert dictionary variables directly into raw XML property list data blocks
    NSData *serializedData = [NSPropertyListSerialization dataWithPropertyList:plistDictionary
                                                                        format:NSPropertyListXMLFormat_v1_0
                                                                       options:0
                                                                         error:&error];
    if (!serializedData) {
        NSLog(@"[WorseQueryBridge] Serialization Failure: %@", error.localizedDescription);
        return NO;
    }
    
    // Explicitly bypass atomic protection flags (NSDataWritingAtomic) to prevent Error -255 on iOS 27 partitions
    BOOL writeSuccess = [serializedData writeToURL:targetURL 
                                           options:NSDataWritingWithoutOverwriting 
                                             error:&error];
    if (!writeSuccess) {
        NSLog(@"[WorseQueryBridge] Direct file write block failed: %@", error.localizedDescription);
        return NO;
    }
    
    NSLog(@"[WorseQueryBridge] Success: Properties successfully committed to path: %@", targetPath);
    return YES;
}

@end
