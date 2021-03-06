//
//  FloatVec3PropertyViewController.h
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloatVec3Property.h"

@interface FloatVec3PropertyViewController : UIViewController

- (id)initWithProperty:(Property*)property;
- (IBAction)valueChanged:(id)sender;

@property (retain, nonatomic) FloatVec3Property* property;
@property (retain, nonatomic) IBOutlet UILabel* titleLabel;
@property (retain, nonatomic) IBOutlet UITextField *value00;
@property (retain, nonatomic) IBOutlet UITextField *value01;
@property (retain, nonatomic) IBOutlet UITextField *value02;

@end
