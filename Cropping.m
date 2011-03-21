//
//  Cropping.m
//  MySudbury
//
//  Created by Shaun on Wednesday, March 9 2011.
//  Copyright 2011 Cambrian College. All rights reserved.
//

#import "Cropping.h"


@implementation UIImage (Cropping)

- (UIImage *)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    
    return cropped;
    
}
@end