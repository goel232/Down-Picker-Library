//
//  DropDownPicker.m
//  basic3
//
//  Created by Aethon Technologies on 10/10/16.
//  Copyright © 2016 Aethon Technologies. All rights reserved.
//

#import "DropDownPicker.h"

@implementation DropDownPicker
{
    NSString* _previousSelectedString;
}
-(id)initWithTextField:(UITextField *)textFeild
{
    return [self initWithTextFeild:pickerTextFeild withData:nil];
}
-(id)initWithTextFeild:(UITextField *)textFeild withData:(NSArray *)data{
    self=[super init];
    if(self){
        pickerTextFeild=textFeild;
        pickerTextFeild.delegate=self;
        //Stops cursor's Blinking
        [[pickerTextFeild valueForKey:@"textInputTraits"]
                             setValue:[UIColor clearColor]
                               forKey:@"insertionPointColor"];
        NSLog(@"%@",data);
        if (data != nil) {
            [self setData: data];
        }
        self.shouldDisplayCancelButton = YES;
    }
    return self;
}
-(void)setPlaceHolder:(NSString *)string{
    placeholder=string;
    NSLog(@"%@",placeholder);
    pickerTextFeild.placeholder=placeholder;
    }
-(void)setData:(NSArray *)data{
    dataArrayForPicker=data;
    NSLog(@"%@",dataArrayForPicker);
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([[dataArrayForPicker objectAtIndex:row] isKindOfClass:[NSString class]])
        self->pickerTextFeild.text = [dataArrayForPicker objectAtIndex:row];
    else self->pickerTextFeild.text = [dataArrayForPicker objectAtIndex:row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [dataArrayForPicker count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    if ([[dataArrayForPicker objectAtIndex:row] isKindOfClass:[NSString class]]) return [dataArrayForPicker objectAtIndex:row];
    return [dataArrayForPicker objectAtIndex:row] ;
}

- (IBAction)showPicker:(id)sender
{
    _previousSelectedString = self->pickerTextFeild.text;
    
    universalPickerView = [[UIPickerView alloc] init];
    universalPickerView.showsSelectionIndicator = YES;
    universalPickerView.dataSource = self;
    universalPickerView.delegate = self;
    
    UIToolbar* toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleDefault;
    [toolbar sizeToFit];
    
    //space between buttons
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil
                                                                                   action:nil];
    
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done"
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(doneClicked:)];
    
    if (self.shouldDisplayCancelButton) {
        UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc]
                                         initWithTitle:@"Cancel"
                                         style:UIBarButtonItemStylePlain
                                         target:self
                                         action:@selector(cancelClicked:)];
        
        [toolbar setItems:[NSArray arrayWithObjects:cancelButton, flexibleSpace, doneButton, nil]];
    } else {
        [toolbar setItems:[NSArray arrayWithObjects:flexibleSpace, doneButton, nil]];
    }
    
    
    //custom input view
    pickerTextFeild.inputView = universalPickerView;
    pickerTextFeild.inputAccessoryView = toolbar;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)aTextField
{
    if ([self->dataArrayForPicker count] > 0) {
        [self showPicker:aTextField];
        return YES;
    }
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)aTextField {
    // [self doneClicked:aTextField];
    aTextField.userInteractionEnabled = YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}
-(void)doneClicked:(id) sender
{
    //hides the pickerView
    [pickerTextFeild resignFirstResponder];
    
    if (self->pickerTextFeild.text.length == 0) {
        self->pickerTextFeild.placeholder = self->placeholder;
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void)cancelClicked:(id)sender
{
    [pickerTextFeild resignFirstResponder]; //hides the pickerView
    if (_previousSelectedString.length == 0)
    {
        self->pickerTextFeild.placeholder = self->placeholder;
    }
    self->pickerTextFeild.text = _previousSelectedString;
}
-(UIPickerView*) getPickerView
{
    return self->universalPickerView;
}
-(void)startSampleProcess{
    
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self.PickerDelegate
                                   selector:@selector(processCompleted) userInfo:nil repeats:NO];
}
@end
