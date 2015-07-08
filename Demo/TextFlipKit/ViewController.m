//
//  ViewController.m
//  TextFlipKit
//
//  Created by Andrew Schreiber on 7/3/15.
//  Copyright (c) 2015 Andrew Schreiber. All rights reserved.
//

#import "ViewController.h"
#import "TextFlipKit.h"

@interface ViewController ()
{
    BOOL flipping;
    BOOL reversing;
}
@property (weak, nonatomic) IBOutlet UITextView *topTextField;
@property (weak, nonatomic) IBOutlet UITextView *bottomTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.bottomTextField becomeFirstResponder];
//    [self reverseAndFlipTheCompletedWorksOfShakespeare];
}

- (IBAction)flipButtonPress:(id)sender {
    flipping = !flipping;
    [self updateText];
}

- (IBAction)reverseButtonPress:(id)sender {
    reversing = !reversing;
    [self updateText];
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView ==self.bottomTextField)
    {
        [self updateText];
    }
}

-(void)updateText
{
    if (flipping && reversing)
    {
        self.topTextField.attributedText = self.bottomTextField.attributedText.tfk_upsideDownAndReversed;
    }
    else if (flipping)
    {
        self.topTextField.attributedText = self.bottomTextField.attributedText.tfk_upsideDown; }
    else if (reversing)
    {
        self.topTextField.attributedText = self.bottomTextField.attributedText.tfk_reversed;
    }
    else
    {
        self.topTextField.attributedText = self.bottomTextField.attributedText;
    }
    NSLog(@"New text: %@", self.topTextField.attributedText.string);
}

-(void)reverseAndFlipTheCompletedWorksOfShakespeare
{
    NSString *originalFile = [[NSBundle mainBundle] pathForResource: @"CompletedWorksOfShakespeare" ofType: @"txt"];
    
    NSString *toBe = @"To be, or not to be: that is the question";
    NSLog(@"%@",toBe.tfk_upsideDownAndReversed);
    
    NSString *willyShakes = [NSString stringWithContentsOfFile:originalFile encoding:NSASCIIStringEncoding error:nil];
    
    NSLog(@"The completed works of shakespeare is %i characters long. Processing...", (int)willyShakes.length,NSMaximumStringLength);
    [willyShakes tfk_upsideDownAndReverseWithCompletionBlock:^(NSString *upsideDownAndReversed) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
        
        NSError *error;
        
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"ǝɹɐǝdsǝʞɐɥS‾ɟO‾sʞɹoM‾pǝʇǝldɯoƆ.txt"];
        
        BOOL succeed=  [upsideDownAndReversed writeToFile:filePath atomically:NO encoding:NSUTF8StringEncoding error:&error];
        
        if (!succeed)
        {
            NSLog(@"Could not write file with error :%@",[error localizedDescription]);
        }
        else
        {
            NSLog(@"Successfully saved flipped text to filepath: %@",filePath);
        }
    }];
}


@end