//
//  BoolPropertyViewController.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "BoolPropertyViewController.h"
#import "NSLogAddition.h"
#import "common.h"

@implementation BoolPropertyViewController

@synthesize property = _property;
@synthesize titleLabel;
@synthesize valueButton;

- (id)initWithProperty:(Property*)property {
    self = [super initWithNibName:@"BoolPropertyViewController" bundle:nil];
    
    if (![property isKindOfClass:[BoolProperty class]])
        ULog(@"Property is not of Class BoolProperty");

    self.property = (BoolProperty*)property;
    return self;        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = [self.property name];
    self.valueButton.on = [self.property currentValue];
}

- (void)dealloc {
    [titleLabel release];
    [valueButton release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setValueButton:nil];
    [super viewDidUnload];
}
- (IBAction)valueChanged:(id)sender {
    BOOL value = self.valueButton.on;
    [self.property setCurrentValue:value];
    [[NSNotificationCenter defaultCenter] postNotificationName:PropertyValueChangedNotification object:self.property];
}
@end
