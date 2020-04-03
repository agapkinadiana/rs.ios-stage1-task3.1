#import "Combinator.h"

@implementation Combinator

- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    
    NSInteger m = [array[0] intValue];
    NSInteger n = [array[1] intValue];
    
    if ([array count] != 2 || !array || m < 0 || n <= 0) return nil;
    
    for (int i = 0; i < n; i++) {
        NSInteger c = [self factorial:n] / ([self factorial:i] * [self factorial:n - i]);
        
        if (c == m) return @(i);
    }
    
    return nil;
}

- (NSInteger)factorial:(NSInteger)number {
    
    if (number == 0) return 1;
    
    return number * [self factorial:number - 1];
}

@end
