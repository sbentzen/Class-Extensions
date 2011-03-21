//
//  Cropping.h
//  MySudbury
//
//  Created by Shaun on Wednesday, March 9 2011.
//  Copyright 2011 Cambrian College. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (Cropping)
- (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect;
@end