//
//  OptionPropertyViewController.h
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionProperty.h"

@interface OptionPropertyViewController : UIViewController

- (id)initWithProperty:(Property*)property;
- (IBAction)valueChanged;

@property (retain, nonatomic) OptionProperty* property;
@property (retain, nonatomic) IBOutlet UILabel* titleLabel;
@property (retain, nonatomic) IBOutlet UIPickerView* valuePicker;

@end
