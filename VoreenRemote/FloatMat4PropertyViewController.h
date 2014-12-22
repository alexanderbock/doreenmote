//
//  FloatMat4PropertyViewController.h
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloatMat4Property.h"

@interface FloatMat4PropertyViewController : UIViewController

- (id)initWithProperty:(Property*)property;
- (IBAction)valueChanged:(id)sender;

@property (retain, nonatomic) FloatMat4Property* property;
@property (retain, nonatomic) IBOutlet UILabel* titleLabel;
@property (retain, nonatomic) IBOutlet UITextField *value00;
@property (retain, nonatomic) IBOutlet UITextField *value01;
@property (retain, nonatomic) IBOutlet UITextField *value10;
@property (retain, nonatomic) IBOutlet UITextField *value11;
@property (retain, nonatomic) IBOutlet UITextField *value02;
@property (retain, nonatomic) IBOutlet UITextField *value12;
@property (retain, nonatomic) IBOutlet UITextField *value20;
@property (retain, nonatomic) IBOutlet UITextField *value21;
@property (retain, nonatomic) IBOutlet UITextField *value22;
@property (retain, nonatomic) IBOutlet UITextField *value03;
@property (retain, nonatomic) IBOutlet UITextField *value13;
@property (retain, nonatomic) IBOutlet UITextField *value23;
@property (retain, nonatomic) IBOutlet UITextField *value30;
@property (retain, nonatomic) IBOutlet UITextField *value31;
@property (retain, nonatomic) IBOutlet UITextField *value32;
@property (retain, nonatomic) IBOutlet UITextField *value33;

@end
