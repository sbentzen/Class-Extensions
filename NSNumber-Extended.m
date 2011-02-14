#import "NSNumber-Extended.h"
@implementation NSNumber (Random_Numbers)

+(long) randomNumber{

    return arc4random();
}

+ (long) randomNumberBetween:(NSInteger)firstNumber andThisNumber:(NSInteger)lastNumber{
    long rand = arc4random();
    if (rand < 0) {
        rand = rand * -1;
    }
    rand = rand % lastNumber;
    rand = rand + firstNumber;
    
    return rand;
}

@end