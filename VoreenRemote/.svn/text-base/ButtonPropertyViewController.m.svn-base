//
//  ButtonPropertyViewController.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "ButtonPropertyViewController.h"
#import "NSLogAddition.h"
#import "common.h"

@implementation ButtonPropertyViewController

@synthesize property = _property;
@synthesize titleLabel;

- (id)initWithProperty:(Property*)property {
    self = [super initWithNibName:@"ButtonPropertyViewController" bundle:nil];
    
    if (![property isKindOfClass:[ButtonProperty class]])
        ULog(@"Property is not of Class ButtonProperty");

    self.property = (ButtonProperty*)property;
    return self;        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = [self.property name];
}

- (void)dealloc {
    [titleLabel release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [super viewDidUnload];
}
- (IBAction)valueChanged:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:PropertyValueChangedNotification object:self.property];
}
@end
