//
//  JSDPinEntryViewController.m
//  Pin Entry
//
//  Created by Richard Stockdale on 12/04/2017.
//  Copyright © 2017 JSD. All rights reserved.
//

#import "JSDPinEntryViewController.h"

@interface JSDPinEntryViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonCollection;
@property (strong, nonatomic) NSMutableString *pinString;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *pinEntryLabel;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@end

@implementation JSDPinEntryViewController

static NSInteger pinMaxLength = 4;

#pragma mark - Pin Pad

- (IBAction)numberButtonTapped:(UIButton *)sender {
    NSString *character = sender.titleLabel.text;
    [self updateThePinString:character];
    [self updateThePinDisplayString];
}

- (void) updateThePinString: (NSString *) newEntry {
    if (self.pinString.length == pinMaxLength) { // Remove all items from the string and add this char
        self.pinString = [[NSMutableString alloc] initWithString:newEntry];
    }
    else { // Append the string
        [self.pinString appendString:newEntry];
    }
    
    [self updateOkButtonState];
}

- (void) updateThePinDisplayString {
    
    // Set up an appropriatly sized placeholder
    NSMutableString *placeholder = [[NSMutableString alloc] init];
    for (int i = 0; i < pinMaxLength; i++) {
        [placeholder appendString:@"-"];
    }
    
    for (int i = 0; i < self.pinString.length; i++) {
        NSRange replaceRange = NSMakeRange(i, 1);
        [placeholder replaceCharactersInRange:replaceRange withString:@"*"];
    }
    
    self.pinEntryLabel.text = placeholder;
}

- (void) updateOkButtonState {
    BOOL completeEntry = self.pinString.length == pinMaxLength;
    self.okButton.enabled = completeEntry;
    self.okButton.alpha = completeEntry ? 1.0 : 0.4;
}

- (IBAction)cancelTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    self.pinString = nil;
}

- (IBAction)okTapped:(id)sender {
    if ([[self getPin] isEqualToString:self.pinString]) {
        self.infoLabel.text = @"Correct";
        self.infoLabel.textColor = [UIColor greenColor];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }
    else {
        self.infoLabel.text = @"Incorrect. Try again";
        self.infoLabel.textColor = [UIColor redColor];
        [self shakeTheView];
    }
}

- (void) shakeTheView {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.6;
    animation.values = @[ @(-20), @(20), @(-20), @(20), @(-10), @(10), @(-5), @(5), @(0) ];
    [self.infoLabel.layer addAnimation:animation forKey:@"shake"];
    [self.pinEntryLabel.layer addAnimation:animation forKey:@"shake"];
}

#pragma mark - PIN Entry

- (NSString *) getPin {
    
    // TODO: Code to get the pin. 
    
    return @"1234";
}


#pragma mark - Object Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *noTouchColour = [self imageFromColor:[UIColor colorWithRed:242.0 / 255.0 green:242.0 / 255.0 blue:242.0 / 255.0 alpha:1.0]];
    UIImage *touchDownColour = [self imageFromColor:[UIColor colorWithRed:110.0 / 255.0 green:110.0 / 255.0 blue:110.0 / 255.0 alpha:1.0]];
    
    for (UIButton *button in self.buttonCollection) {
        [button setBackgroundImage:noTouchColour forState:UIControlStateNormal];
        [button setBackgroundImage:touchDownColour forState:UIControlStateSelected];
    }
}

- (void) viewWillAppear:(BOOL)animated {
    self.pinEntryLabel.text = @"----";
    self.infoLabel.text = @"Enter 4 digit access code";
    self.infoLabel.textColor = [UIColor blackColor];
    self.pinString = nil;
    [self updateOkButtonState];
}

- (NSMutableString *) pinString {
    if (!_pinString) {
        _pinString = [[NSMutableString alloc] init];
    }
    
    return _pinString;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFormSheet;
        self.preferredContentSize = CGSizeMake(300, 242);
    }
    
    return self;
}

#pragma mark - Helpers

- (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
