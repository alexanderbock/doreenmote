//
//  IntegerPropertyViewController.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "IntegerPropertyViewController.h"
#import "NSLogAddition.h"
#import "common.h"

@implementation IntegerPropertyViewController

@synthesize property = _property;
@synthesize titleLabel;
@synthesize valueSlider;
@synthesize valueField;

- (id)initWithProperty:(Property*)property {
    self = [super initWithNibName:@"IntegerPropertyViewController" bundle:nil];
    
    if (![property isKindOfClass:[IntegerProperty class]])
        ULog(@"Property is not of Class IntegerProperty");

    self.property = (IntegerProperty*)property;
    return self;        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = [self.property name];
    self.valueSlider.minimumValue = [self.property minimumValue];
    self.valueSlider.maximumValue = [self.property maximumValue];
    self.valueSlider.value = [self.property currentValue];
    self.valueField.text = [NSString stringWithFormat:@"%i", (int)self.valueSlider.value];
}

- (void)dealloc {
    [titleLabel release];
    [valueSlider release];
    [valueField release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setValueSlider:nil];
    [self setValueField:nil];
    [super viewDidUnload];
}
- (IBAction)valueChanged:(id)sender {
    int value;
    if ([sender isKindOfClass:[UISlider class]])
        value = roundl([(UISlider*)sender value]);
    else
        value = [[(UITextField*)sender text] intValue];
        
    self.valueField.text = [NSString stringWithFormat:@"%i", value];
    self.valueSlider.value = value;
    [self.property setCurrentValue:value];
    [[NSNotificationCenter defaultCenter] postNotificationName:PropertyValueChangedNotification object:self.property];
}
@end
