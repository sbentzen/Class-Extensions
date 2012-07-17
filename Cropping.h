/*!
@category Cropping
@abstract An extension upon UIImage to provide a cropped image
@discussion Pretty easy to figure out.
@author Shaun Bentzen
@updated 2011-03-09
*/


#import <Foundation/Foundation.h>


@interface UIImage (Cropping)
@end
	
/*!
@param imageToCrop
An image provided to crop to the next parameter.

@param rect
the rectangle to crop the image to.
eg. 10 is the X inset, 20 is the Y inset and 100 is the image width and height
CGRectMake(10,20,100,100)

@discussion This method crops from a specified point, to a specified width and height, with the point being the top left corner of the cropped image.

*/
- (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect;
