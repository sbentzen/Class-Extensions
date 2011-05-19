//
//  UIWebView-Extended.m
//  MySudbury
//
//  Created by Shaun on Wednesday, May 18 2011.
//  Copyright 2011 Cambrian College. All rights reserved.
//

#import "UIWebView-Extended.h"


@implementation UIWebView (UIWebView_Extended)


-(UIWebView *)initWithWebsite:(NSURL *)website andTitle:(NSString *)title{
    
    self = [super init];
    [self loadRequest:[NSURLRequest requestWithURL:website]];
    return self;
}

@end
