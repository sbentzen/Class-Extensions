/*!
@category NSDate_Season
@abstract An extension on NSDate to answer as to what season a particular date is in.
@discussion I didn't make this particular header file, I just found it and included it in here, I wish I could remember where I found it.
@author Shaun Bentzen
@updated 2011-03-09

*/

#import <Foundation/Foundation.h>


@interface NSDate (NSDate_Season)


+(NSString *) whatSeasonIsThisDateIn:(NSDate *)date;

@end
