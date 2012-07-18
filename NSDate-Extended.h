/**
 * An extension on NSDate to answer as to what season a particular date is in.
*/

#import <Foundation/Foundation.h>


@interface NSDate (NSDate_Season)

/** Quick and easy answer as to what season the current date is in… doesn't use any outside APIs and uses statically coded dates.
 * @param date the date that you want to ask the question about.
*/
+(NSString *) whatSeasonIsThisDateIn:(NSDate *)date;

@end
