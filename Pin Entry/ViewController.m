//
//  ViewController.m
//  Pin Entry
//
//  Created by Richard Stockdale on 12/04/2017.
//  Copyright © 2017 JSD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) JSDPinEntryViewController *pinPad;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showPinEntry:(id)sender {
    if (!self.pinPad) {
        self.pinPad = [[JSDPinEntryViewController alloc] init];
        self.pinPad.delegate = self;
    }
    
    [self presentViewController:self.pinPad animated:YES completion:nil];
}

- (void) pinEntryCompleted: (BOOL) success {
    NSLog(@"%@", success ? @"Pin entered correctly" : @"Pin cancelled");
}

@end
