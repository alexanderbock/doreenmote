//
//  IntVec2PropertyViewController.h
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntVec2Property.h"

@interface IntVec2PropertyViewController : UIViewController

- (id)initWithProperty:(Property*)property;
- (IBAction)valueChanged:(id)sender;

@property (retain, nonatomic) IntVec2Property* property;
@property (retain, nonatomic) IBOutlet UILabel* titleLabel;
@property (retain, nonatomic) IBOutlet UITextField *value00;
@property (retain, nonatomic) IBOutlet UITextField *value01;

@end
