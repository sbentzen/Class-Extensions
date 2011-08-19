//
//  Cropping.h
//  Sambaworks
//
//  Created by Shaun on Wednesday, March 9 2011.
//  Copyright 2011 Sambaworks. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImage (Cropping)
@end
- (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect;
