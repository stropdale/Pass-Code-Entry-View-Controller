//
//  JSDPinEntryViewController.h
//  Pin Entry
//
//  Created by Richard Stockdale on 12/04/2017.
//  Copyright © 2017 JSD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JSPPinEntryDelegate <NSObject>


/**
 The pin entry completed

 @param success NO - User tapped cancel. YES - The correct pin was entered
 */
- (void) pinEntryCompleted: (BOOL) success;

@end

@interface JSDPinEntryViewController : UIViewController

@property (nonatomic, weak) NSObject <JSPPinEntryDelegate> *delegate;

@end
