//
// GestaltAccess.m
// GestaltEdit
//
// Safe jailed-build implementation.
//

#import "GestaltAccess.h"

static NSError *GestaltAccessUnavailableError(void) {
    return [NSError errorWithDomain:@"com.gestaltedit.access"
                               code:1001
                           userInfo:@{
        NSLocalizedDescriptionKey:
            @"Live MobileGestalt access is disabled in this jailed build."
    }];
}

@implementation GestaltAccess

+ (instancetype)shared {
    static GestaltAccess *instance;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        instance = [GestaltAccess new];
    });

    return instance;
}

+ (BOOL)isRunningSupportedOS {
    return YES;
}

+ (NSString *)currentOSBuild {
    return NSProcessInfo.processInfo.operatingSystemVersionString ?: @"";
}

- (BOOL)connectWithError:(NSError **)error {
    if (error) {
        *error = GestaltAccessUnavailableError();
    }

    return NO;
}

- (NSData *)readGestaltDataWithError:(NSError **)error {
    if (error) {
        *error = GestaltAccessUnavailableError();
    }

    return nil;
}

- (NSDictionary *)readGestaltWithError:(NSError **)error {
    if (error) {
        *error = GestaltAccessUnavailableError();
    }

    return nil;
}

- (BOOL)saveGestalt:(NSDictionary *)plist error:(NSError **)error {
    if (error) {
        *error = GestaltAccessUnavailableError();
    }

    return NO;
}

@end
