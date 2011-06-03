//
//  UINavigationBar+CustomImage.m
//  iCambrian
//
//  Created by Shaun Bentzen on Monday, May 30 2011.
//  Copyright 2011 Cambrian College. All rights reserved.
//

#import "UINavigationBar+CustomImage.h"
// Implement with this
// [[navController navigationBar] performSelectorInBackground:@selector(setBackgroundImage:) withObject:image];

@implementation UINavigationBar (CustomImage)

- (void) setBackgroundImage:(UIImage*)image {
    if (image == NULL) return;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(110,5,100,30);
    [self addSubview:imageView];
    [imageView release];
}

- (void) clearBackgroundImage {
    NSArray *subviews = [self subviews];
    for (int i=0; i<[subviews count]; i++) {
        if ([[subviews objectAtIndex:i]  isMemberOfClass:[UIImageView class]]) {
            [[subviews objectAtIndex:i] removeFromSuperview];
        }
    }    
}

@end
@end
