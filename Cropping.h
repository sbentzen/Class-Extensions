/** 
 * An extension on UIImage that crops images.
*/
#import <Foundation/Foundation.h>


@interface UIImage (Cropping)
@end
	
/**
 * This method crops from a specified point, to a specified width and height, with the point being the top left corner of the cropped image.
 * @param imageToCrop An image provided to crop to the next parameter.
 * 
 * @param rect the rectangle to crop the image to. eg. 10 is the X inset, 20 is the Y inset and 100 is the image width and height CGRectMake(10,20,100,100)
*/
- (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect;
