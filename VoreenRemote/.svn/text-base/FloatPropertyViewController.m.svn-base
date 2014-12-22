//
//  FloatPropertyViewController.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "FloatPropertyViewController.h"
#import "NSLogAddition.h"
#import "common.h"

@implementation FloatPropertyViewController

@synthesize property = _property;
@synthesize titleLabel;
@synthesize valueSlider;
@synthesize valueField;

- (id)initWithProperty:(Property*)property {
    self = [super initWithNibName:@"FloatPropertyViewController" bundle:nil];
    
    if (![property isKindOfClass:[FloatProperty class]])
        ULog(@"Property is not of Class FloatProperty");

    self.property = (FloatProperty*)property;
    return self;        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.property.name;
    self.valueSlider.minimumValue = [self.property minimumValue];
    self.valueSlider.maximumValue = [self.property maximumValue];
    self.valueSlider.value = [self.property currentValue];
    self.valueField.text = [NSString stringWithFormat:@"%f", self.valueSlider.value];
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
    float value;
    if ([sender isKindOfClass:[UISlider class]])
        value = [(UISlider*)sender value];
    else
        [[(UITextField*)sender text] floatValue];
    
    
    self.valueField.text = [NSString stringWithFormat:@"%f", value];
    self.valueSlider.value = value;
    [self.property setCurrentValue:value];
    [[NSNotificationCenter defaultCenter] postNotificationName:PropertyValueChangedNotification object:self.property];
}
@end
