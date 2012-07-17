
#import <Foundation/Foundation.h>

/** An expansion of NSString to add URL encoding to the string for usage in URLs*/
@interface NSString (NSString_Escapes)

/** Returns an URL encoded string*/
- (NSString *) URLEncodedString;

@end
