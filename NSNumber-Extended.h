/*!
@category Random_Numbers
@abstract A convinience category for random numbers from NSNumber.
@discussion Made because I was lazy and wanted an easy Obj-C way to get random numbers.
@author Shaun Bentzen
	
*/
#import <UIKit/UIKit.h>

@interface NSNumber (Random_Numbers) 

+ (long) randomNumber;
+ (long) randomNumberBetween:(NSInteger)firstNumber andThisNumber:(NSInteger)lastNumber;

@end
