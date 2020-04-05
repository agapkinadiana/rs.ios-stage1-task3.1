#import "PolynomialConverter.h"

@implementation PolynomialConverter
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {

    
    NSMutableString *result = [[NSMutableString alloc] init];
    NSUInteger countNumbers = [numbers count];
    BOOL skipElement = NO;

    if (countNumbers == 0) return nil;
    else {
        for (int i = 0; i < [numbers count]; i++) {
            NSInteger number = abs([numbers[i] intValue]);
            countNumbers--;
            
            if (skipElement) skipElement = NO;
            else {
                switch (countNumbers) {
                    case 0:
                        [result appendString:[NSString stringWithFormat:@"%ld", (long)number]];
                        break;
                    case 1:
                        if (number == 1) [result appendString:[NSString stringWithFormat:@"%@", @"x"]];
                        else [result appendString:[NSString stringWithFormat:@"%ld%@", (long)number, @"x"]];
                        break;

                    default:
                        if (number == 1) [result appendString:[NSString stringWithFormat:@"%@%ld", @"x^", countNumbers]];
                        else [result appendString:[NSString stringWithFormat:@"%ld%@%ld", (long)number, @"x^", countNumbers]];
                        break;
                }
            }
            
            if (countNumbers > 0) {
                NSInteger nextNumber = [numbers[i + 1] intValue];
                
                if (nextNumber > 0) [result appendString:[NSString stringWithFormat:@" + "]];
                else if (nextNumber < 0) [result appendString:[NSString stringWithFormat:@" - "]];
                else skipElement = YES;
            }
        }
    }
    return result;
}
@end
