/*!
@category URL-File-Scanner
@abstract An extension upon NSScanner to scan an URL or whatever for a certain extension, or an image extension.
@discussion Could definitely use some refactoring.
@author Shaun Bentzen
@updated 2011-03-09
*/


#import <Foundation/Foundation.h>


@interface NSScanner (URL-File-Scanner)
+(BOOL)scanForFiletype:(NSString *)filetype inString:(NSString *)data;

+(NSString *)scanForURLWithImageExtension:(NSString *)fileExtension inString:(NSString *)data;
@end

