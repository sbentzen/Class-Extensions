//
//  ExtendedScanning.h
//  MySudbury
//
//  Created by Shaun on Wednesday, March 9 2011.
//  Copyright 2011 Cambrian College. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSScanner (ExtendedScanning)
+(BOOL)scanForFiletype:(NSString *)filetype inString:(NSString *)data;

+(NSString *)scanForURLWithImageExtension:(NSString *)fileExtension inString:(NSString *)data;
@end

