//
//  FloatMat3PropertyViewController.h
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloatMat3Property.h"

@interface FloatMat3PropertyViewController : UIViewController

- (id)initWithProperty:(Property*)property;
- (IBAction)valueChanged:(id)sender;

@property (retain, nonatomic) FloatMat3Property* property;
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

@end
