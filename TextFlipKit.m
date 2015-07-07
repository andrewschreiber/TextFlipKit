//
//  TextFlipKit.m
//
//  Created by Andrew Schreiber on 6/30/15.
//  Copyright (c) 2015 Andrew Schreiber. All rights reserved.
//

#import "TextFlipKit.h"
#import <QuartzCore/QuartzCore.h>


@interface TFK : NSObject
@end

@implementation TFK

+ (NSString *) upsideDownStringForCharacter: (NSString *)character
{
    if (character.length != 1) return character;
    
    // It turns out unicode has a bunch of characters that look like normal characters flipped upside down.
    
    static NSDictionary *characterKey = nil;
    static dispatch_once_t characterKeyToken;
    dispatch_once(&characterKeyToken, ^{
        // If you know of more characters that are upside-down-able please add them here and submit a pull request!
        characterKey =
        @{
          @"a": @"ɐ",
          @"b": @"q",
          @"c": @"ɔ",
          @"d": @"p",
          @"e": @"ǝ",
          @"f": @"ɟ",
          @"g": @"ƃ",
          @"h": @"ɥ",
          @"i": @"ᴉ",
          @"j": @"ɾ",
          @"k": @"ʞ",
          @"l": @"ʃ",
          @"m": @"ɯ",
          @"n": @"u",
          @"o": @"o",
          @"p": @"d",
          @"q": @"b",
          @"r": @"ɹ",
          @"s": @"s",
          @"t": @"ʇ",
          @"u": @"n",
          @"v": @"ʌ",
          @"w": @"ʍ",
          @"x": @"x",
          @"y": @"ʎ",
          @"z": @"z",
          
          @"A": @"∀",
          @"B": @"𐐒",
          @"C": @"Ↄ",
          @"D": @"ᗡ",
          @"E": @"Ǝ",
          @"F": @"Ⅎ",
          @"G": @"⅁",
          @"H": @"H",
          @"I": @"I",
          @"J": @"ſ",
          @"K": @"ʞ",
          @"L": @"⅂",
          @"M": @"W",
          @"N": @"ᴎ",
          @"O": @"O",
          @"P": @"Ԁ",
          @"Q": @"Ό",
          @"R": @"ᴚ",
          @"S": @"S",
          @"T": @"⊥",
          @"U": @"∩",
          @"V": @"ᴧ",
          @"W": @"M",
          @"X": @"X",
          @"Y": @"⅄",
          @"Z": @"Z",
          
          @"1": @"Ɩ",
          @"2": @"ᄅ",
          @"3": @"Ɛ",
          @"4": @"ᔭ",
          @"5": @"ϛ",
          @"6": @"9",
          @"7": @"ㄥ",
          @"8": @"8",
          @"9": @"6",
          @"0": @"0",
          
          @",": @"'",
          @".": @"˙",
          @"?": @"¿",
          @"!": @"¡",
          @"\"": @",,",
          @"'": @",",
          @"(": @")",
          @")": @"(",
          @"[": @"]",
          @"]": @"[",
          @"{": @"}",
          @"}": @"{",
          @"<": @">",
          @">": @"<",
          @"&": @"⅋",
          @"_": @"‾"

          };
    });
    
    // Returns character from character key if one exists, otherwise return original character
    return characterKey[character] ?: character;
    
}

+ (NSString *) enumerateString: (NSString*)string
                     withBlock: (void(^)(NSString *character, NSMutableString *newString))stringBlock
{
    NSUInteger length = string.length;
    
    // Will add new characters here
    NSMutableString *chars = [[NSMutableString alloc] initWithCapacity:length];
    
    // Gets each character, such that even characters that are composed as multiple unicode characters are reduced to a single element
    [string enumerateSubstringsInRange: NSMakeRange(0, string.length)
                               options: NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *character, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                
                                // Do processing on character and block
                              stringBlock(character,chars);
                              
                          }];
    
    return chars.copy;
}

+(NSAttributedString *)enumerateAttributedString: (NSAttributedString *)attributedString
                                 withStringBlock: (void(^)(NSString *character, NSMutableString *newString)) stringBlock
                             withAttributedBlock: (void(^)(NSAttributedString *attributedSubstring, NSMutableAttributedString *newAttributedString)) attributedBlock
{
    // Will hold a substring of the passed NSAttributedString composed of characters of the same attributed type. Needed since NSAttributedString doesn't have a method to enumerate over it's substrings.
    __block NSMutableString *chars = [NSMutableString new];
    
    // Will add new characters here
    NSMutableAttributedString *attributedChars = [NSMutableAttributedString new];
    
    // Get each substring with the same attributes
    [attributedString enumerateAttributesInRange:NSMakeRange(0, attributedString.length)
                                         options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                                      usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop)
     {
         
         NSString *text = attributedString.string;
         
         //Break down substring into individual characters
         [text enumerateSubstringsInRange:range options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {

             
             //Process characters
             stringBlock(substring,chars);
         }];
         
         
         // Convert string back to attributed
         NSAttributedString *postProcessAttributed = [[NSAttributedString alloc]initWithString:chars attributes:attrs];
         
         // Do attributed string processing
         attributedBlock(postProcessAttributed, attributedChars);
         
         // Reset chars for next substring from passed NSAttributedString
         chars = [NSMutableString new];
     }];
    
    return attributedChars.copy;
}

@end


@implementation NSString (TextFlipKit)


-(NSString *)tfk_reversed
{
    return [TFK enumerateString:self
                      withBlock:^(NSString *character, NSMutableString *newString)
            { // Last character in from passed string ends up at the front
                [newString insertString:character atIndex:0];
            }];
}

-(NSString *)tfk_upsideDown
{
    return [TFK enumerateString:self
                      withBlock:^(NSString *character, NSMutableString *newString)
            { // Preserves order of passed string, swaps characters
                [newString appendString:[TFK upsideDownStringForCharacter:character]];
            }];
}

-(NSString *)tfk_upsideDownAndReversed
{
    return [TFK enumerateString:self
                      withBlock:^(NSString *character, NSMutableString *newString)
            {
                // Last character winds up in front, and swaps characters
                [newString insertString: [TFK upsideDownStringForCharacter:character] atIndex:0];
            }];
}

-(void)tfk_reverseWithCompletionBlock:(void(^)(NSString * reversed))completion
{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
       
        NSString *reverse = self.tfk_reversed;
        completion(reverse);
        
    });
}

-(void)tfk_upsideDownWithCompletionBlock:(void(^)(NSString * upsideDown))completion
{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
       
        NSString *upsideDown = self.tfk_upsideDown;
        completion(upsideDown);
        
    });
}

-(void)tfk_upsideDownAndReverseWithCompletionBlock:(void(^)(NSString * upsideDownAndReversed))completion
{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
       
        NSString *upsideDownAndReversed = self.tfk_upsideDownAndReversed;
        completion(upsideDownAndReversed);
        
    });
}


@end

@implementation NSAttributedString (TextFlipKit)

-(NSAttributedString *)tfk_reversed
{
    return [TFK enumerateAttributedString:self
                          withStringBlock:^(NSString *character, NSMutableString *newString)
            {
                // Same as tfk_reversed for NSString
                [newString insertString:character atIndex:0];
                
            } withAttributedBlock:^(NSAttributedString *attributedSubstring, NSMutableAttributedString *newAttributedString) {
                
                //Received a substring of reversed characters all with the same attributes. Adding them at index 0 so the entire attributed string is reversed, not just individual substrings.
                [newAttributedString insertAttributedString:attributedSubstring atIndex:0];
                
            }];
}

-(NSAttributedString *)tfk_upsideDown
{
    // Read comments above to clarify how this works
    return [TFK enumerateAttributedString:self
                          withStringBlock:^(NSString *character, NSMutableString *newString)
            {
                
                [newString appendString:[TFK upsideDownStringForCharacter:character]];
                
            } withAttributedBlock:^(NSAttributedString *attributedSubstring, NSMutableAttributedString *newAttributedString) {
                
                [newAttributedString appendAttributedString:attributedSubstring];
                
            }];
    
}

-(NSAttributedString *)tfk_upsideDownAndReversed
{
    // Read comments above to clarify how this works
    return [TFK enumerateAttributedString:self
                          withStringBlock:^(NSString *character, NSMutableString *newString)
            {
                
                [newString insertString: [TFK upsideDownStringForCharacter:character] atIndex:0];
                
            } withAttributedBlock:^(NSAttributedString *attributedSubstring, NSMutableAttributedString *newAttributedString) {
                
                [newAttributedString insertAttributedString:attributedSubstring atIndex:0];
                
            }];
}
-(void)tfk_reverseWithCompletionBlock:(void(^)(NSAttributedString * reversed))completion
{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
       
        NSAttributedString *reverse = self.tfk_reversed;
        completion(reverse);
        
    });
}

-(void)tfk_upsideDownWithCompletionBlock:(void(^)(NSAttributedString * upsideDown))completion
{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
       
        NSAttributedString *upsideDown = self.tfk_upsideDown;
        completion(upsideDown);
        
    });
}

-(void)tfk_upsideDownAndReverseWithCompletionBlock:(void(^)(NSAttributedString * upsideDownAndReversed))completion
{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
       
        NSAttributedString *upsideDownAndReversed = self.tfk_upsideDownAndReversed;
        completion(upsideDownAndReversed);
        
    });
}

@end
