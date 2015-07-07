//
//  TextFlipKit.h
//
//  Created by Andrew Schreiber on 6/30/15.
//  Copyright (c) 2015 Andrew Schreiber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (TextFlipKit)

/**
 * Returns the string with text reversed
 * @return For example:
 * @return :elpmaxe roF
 **/
-(NSString *)tfk_reversed;

/**
 * Returns the string using upside down unicode characters. Characters without upside down analogues are left unchanged.
 * @return For example:
 * @return Ⅎoɹ ǝxɐɯdlǝ
 **/
-(NSString *)tfk_upsideDown;


/** Returns the string using upside down unicode characters with text reversed. If you want the text to appear normal when you rotate the screen 180 degrees, USE THIS.
 * @return For example:
 * @return :ǝldɯɐxǝ ɹoℲ
 **/
-(NSString *)tfk_upsideDownAndReversed;


/** Same as tfk_reversed, but wont block the main thred.
 **/

-(void)tfk_reverseWithCompletionBlock:(void(^)(NSString * reversed))completion;

/** Same as tfk_upsideDown, but wont block the main thred
 **/

-(void)tfk_upsideDownWithCompletionBlock:(void(^)(NSString * upsideDown))completion;

/** Same as tfk_upsideDownAndReverse, but wont block the main thred
 **/
-(void)tfk_upsideDownAndReverseWithCompletionBlock:(void(^)(NSString * upsideDownAndReversed))completion;

@end


@interface NSAttributedString (TextFlipKit)
/**
 * Returns the attributed string with text reversed
 * @return For example:
 * @return :elpmaxe roF
 * Preserves attributions by character
 **/
-(NSAttributedString *)tfk_reversed;


/**
 * Returns the attributed string using upside down unicode characters. Characters without upside down analogues are left unchanged.
 * @return For example:
 * @return Ⅎoɹ ǝxɐɯdlǝ:
 * Preserves attributions by character
 **/
-(NSAttributedString *)tfk_upsideDown;


/** Returns the attributed string using upside down unicode characters with text reversed
 *
 * @return For example:
 *
 * @return :ǝldɯɐxǝ ɹoℲ
 *
 * Preserves attributions by character
 * If you want the text to appear normal when you rotate the screen 180 degrees, USE THIS.
 **/
-(NSAttributedString *)tfk_upsideDownAndReversed;


/** Same as tfk_reversed, but wont block the main thred.
 **/

-(void)tfk_reverseWithCompletionBlock:(void(^)(NSAttributedString * reversed))completion;

/** Same as tfk_upsideDown, but wont block the main thred
 **/

-(void)tfk_upsideDownWithCompletionBlock:(void(^)(NSAttributedString * upsideDown))completion;

/** Same as tfk_upsideDownAndReverse, but wont block the main thred
 **/
-(void)tfk_upsideDownAndReverseWithCompletionBlock:(void(^)(NSAttributedString * upsideDownAndReversed))completion;

@end
