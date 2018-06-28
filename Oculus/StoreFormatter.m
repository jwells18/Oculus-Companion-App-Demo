//
//  StoreFormatter.m
//  Oculus
//
//  Created by Justin Wells on 6/27/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "StoreFormatter.h"

@implementation StoreFormatter

- (NSAttributedString *)stringPriceFromApp:(OCApp *)app{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    NSString *text;
    NSString *priceString = [formatter stringFromNumber:app.price];
    NSString *salePriceString = [formatter stringFromNumber:app.salePrice];
    if (app.salePrice != nil && ![app.salePrice isEqual:[NSNull null]]){
        text = [NSString stringWithFormat:@"%@ %@", priceString, salePriceString];
    }
    else{
        if([app.price isEqual: @0]){
            text = NSLocalizedString(@"free", nil);
        }
        else{
            text = priceString;
        }
    }
    NSMutableAttributedString *attributedString =[[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, text.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, text.length)];
    if (app.salePrice != nil && ![app.salePrice isEqual:[NSNull null]]){
        NSRange priceStringRange = [text rangeOfString:priceString];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:priceStringRange];
        [attributedString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:priceStringRange];
    }
    return attributedString;
}

@end
