//
//  ExtendedScanning.m
//  MySudbury
//
//  Created by Shaun on Wednesday, March 9 2011.
//  Copyright 2011 Cambrian College. All rights reserved.
//

#import "ExtendedScanning.h"


@implementation NSScanner (ExtendedScanning)

+(BOOL)scanForFiletype:(NSString *)filetype inString:(NSString *)data{
    
    if ([data rangeOfString:filetype].location != NSNotFound)
        return YES;
    else    
        return NO;
}

+(NSString *)scanForURLWithImageExtension:(NSString *)fileExtension inString:(NSString *)data{
    
    NSString *stringToAnalyze = @"";
    BOOL exitCondition = FALSE;
    NSScanner *mainScanner = [[NSScanner alloc] initWithString:data];
    while (exitCondition == false){
        stringToAnalyze = @"";
        [mainScanner scanUpToString:@"http://" intoString:nil];
        [mainScanner scanString:@"http://" intoString:&stringToAnalyze];
        [mainScanner scanUpToString:@"\"" intoString:&stringToAnalyze];
        if ([NSScanner scanForFiletype:fileExtension inString:stringToAnalyze] == TRUE){
            exitCondition = TRUE;
        }
        //        NSLog(@"%@",stringToAnalyze);
    }
    return stringToAnalyze;
    
    [mainScanner release];
}
@end
