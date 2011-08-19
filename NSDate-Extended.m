//
//  NSDate-Extended.m
//  Sambaworks
//
//  Created by Shaun on Wednesday, March 9 2011.
//  Copyright 2011 Sambaworks. All rights reserved.
//

#import "NSDate-Extended.h"
#import "Definitions.h"

const int zenithDate = 21;
const int march = 3;
const int june = 6;
const int september = 9;
const int december = 12;


@implementation NSDate (NSDate_Extended)


+(NSString *) whatSeasonIsThisDateIn:(NSDate *)date{
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *comps = [cal components:unitFlags fromDate:date];
    int day = [comps day];
    int month = [comps month];
    int year = [comps year];
    NSString *retVal;
    NSLog(@"%d, %d %d",day, month, year);
    if (month <= march OR month == december) {
        NSLog(@"%@, %@",month,day);
        if (month == march AND day < zenithDate) {
            retVal = @"Winter";
        }
        else if (month == december AND day > zenithDate) {
            retVal = @"Winter";
        }
        else{
            retVal = @"Winter";
        }
        
    }
    else if(month >= march AND month <= june){
        if (month == march AND day > zenithDate) {
            retVal = @"Spring";
        }
        if (month == june AND day < zenithDate) {
            retVal = @"Spring";
        }
        else{
            retVal = @"Spring";
        }
    }
    else if(month >= june AND month <= september){
        if (month == june AND day > zenithDate) {
            retVal = @"Summer";
        }
        else if (month == september AND day < zenithDate){
            retVal = @"Summer";
        }
        else {
            retVal = @"Summer";
        }
    }
    else if (month >= september AND month <= december){
        if (month == september AND day > zenithDate) {
            retVal = @"Autumn";
        }
        else if (month == december AND day < zenithDate){
            retVal = @"Autumn";
        }
        else{
            retVal = @"Autumn";
        }
    }
    return retVal;
}


@end
