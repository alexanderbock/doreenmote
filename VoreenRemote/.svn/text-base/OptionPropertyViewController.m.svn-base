//
//  OptionPropertyViewController.m
//  Doreemote
//
//  Created by Alexander Bock.
//  Copyright (c) 2012. All rights reserved.
//

#import "OptionPropertyViewController.h"
#import "NSLogAddition.h"
#import "common.h"

@implementation OptionPropertyViewController

@synthesize property = _property;
@synthesize titleLabel;
@synthesize valuePicker;

- (id)initWithProperty:(Property*)property {
    self = [super initWithNibName:@"OptionPropertyViewController" bundle:nil];
    
    if (![property isKindOfClass:[OptionProperty class]])
        ULog(@"Property is not of Class OptionProperty");

    self.property = (OptionProperty*)property;
    return self;        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = [self.property name];
    NSInteger current = [self.property.possibleValues indexOfObject:[self.property currentValue]];
    [self.valuePicker selectRow:current inComponent:0 animated:NO];
}

- (void)dealloc {
    [titleLabel release];
    [valuePicker release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setValuePicker:nil];
    [super viewDidUnload];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.property.possibleValues count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.property.possibleValues objectAtIndex:row];
}

- (IBAction)valueChanged {
    NSInteger currentRow = [self.valuePicker selectedRowInComponent:0];
    [self.property setCurrentValue:[self.property.possibleValues objectAtIndex:currentRow]];
    [[NSNotificationCenter defaultCenter] postNotificationName:PropertyValueChangedNotification object:self.property];
}

@end
