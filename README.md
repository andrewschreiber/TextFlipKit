![alt tag](http://i.imgur.com/YgHTge5.png)

![language](https://img.shields.io/badge/Language-Objective--C-8E44AD.svg)
![Version](https://img.shields.io/badge/Pod-%20v0.1.0%20-96281B.svg)
![MIT License](https://img.shields.io/github/license/mashape/apistatus.svg)
![Platform](https://img.shields.io/badge/platform-%20iOS%20-lightgrey.svg)

An NSString and NSAttributedString category that makes it easy to flip and reverse text. Text can be added to text messages, emails, etc.

##Usage
```objective-c
#import TextFlipKit.h;

-(void)foo
{
NSString *example = @"Example String";
NSLog(@"'%@'", example.tfk_upsideDownAndReversed);
//Prints 'ƃuᴉɹʇS ǝldɯɐxƎ'
}
```
