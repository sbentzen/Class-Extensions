/**
A convinience category for random numbers from NSNumber. Made because I was lazy and wanted an easy Obj-C way to get random numbers.
*/
#import <UIKit/UIKit.h>

@interface NSNumber (Random_Numbers) 
/** makes a random number in an objective c manner */
+ (long) randomNumber;
/** Same as above in some manner, just limits the scope of the number generated
 * @param firstNumber the starting number for the range
 * @param lastNumber the ending number in the range
*/
+ (long) randomNumberBetween:(NSInteger)firstNumber andThisNumber:(NSInteger)lastNumber;

@end
