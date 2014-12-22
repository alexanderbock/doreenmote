//
//  CameraPropertyViewController.h
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraProperty.h"
#import <GLKit/GLKit.h>

@interface CameraPropertyViewController : UIViewController <UIGestureRecognizerDelegate, GLKViewDelegate>

- (id)initWithProperty:(Property*)property;
- (IBAction)handleSinglePan:(UIGestureRecognizer*)recognizer;
- (IBAction)handleDoublePan:(UIGestureRecognizer*)recognizer;
- (IBAction)handlePinch:(UIGestureRecognizer*)recognizer;
- (IBAction)handleRotate:(UIGestureRecognizer*)recognizer;


@property (nonatomic, retain) CameraProperty* property;

@end
