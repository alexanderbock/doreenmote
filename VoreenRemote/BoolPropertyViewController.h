//
//  BoolPropertyViewController.h
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoolProperty.h"

@interface BoolPropertyViewController : UIViewController

- (id)initWithProperty:(Property*)property;
- (IBAction)valueChanged:(id)sender;

@property (retain, nonatomic) BoolProperty* property;
@property (retain, nonatomic) IBOutlet UILabel* titleLabel;
@property (retain, nonatomic) IBOutlet UISwitch* valueButton;

@end
