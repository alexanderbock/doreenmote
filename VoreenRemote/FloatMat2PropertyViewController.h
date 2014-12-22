//
//  FloatMat2PropertyViewController.h
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloatMat2Property.h"

@interface FloatMat2PropertyViewController : UIViewController

- (id)initWithProperty:(Property*)property;
- (IBAction)valueChanged:(id)sender;

@property (retain, nonatomic) FloatMat2Property* property;
@property (retain, nonatomic) IBOutlet UILabel* titleLabel;
@property (retain, nonatomic) IBOutlet UITextField *value00;
@property (retain, nonatomic) IBOutlet UITextField *value01;
@property (retain, nonatomic) IBOutlet UITextField *value10;
@property (retain, nonatomic) IBOutlet UITextField *value11;

@end
