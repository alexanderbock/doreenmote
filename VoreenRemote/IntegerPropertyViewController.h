//
//  IntegerPropertyViewController.h
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntegerProperty.h"

@interface IntegerPropertyViewController : UIViewController

- (id)initWithProperty:(Property*)property;
- (IBAction)valueChanged:(id)sender;

@property (retain, nonatomic) IntegerProperty* property;
@property (retain, nonatomic) IBOutlet UILabel* titleLabel;
@property (retain, nonatomic) IBOutlet UISlider* valueSlider;
@property (retain, nonatomic) IBOutlet UITextField* valueField;

@end
