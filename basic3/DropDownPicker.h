//
//  DropDownPicker.h
//  basic3
//
//  Created by Aethon Technologies on 10/10/16.
//  Copyright © 2016 Aethon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DropDownPickerDelegate <NSObject>
@required
-(void)processCompleted;
@optional
-(id)initWithTextFeild:(UITextField *)textFeild withData:(NSArray *)data;

-(id)initWithTextField:(UITextField *)textFeild;
-(void)setPlaceHolder:(NSString *)string;
@end



@interface DropDownPicker : UIControl<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    IBOutlet UITextField *pickerTextFeild;
    UIPickerView *universalPickerView;
    NSString *placeholder;
    NSArray *dataArrayForPicker;
}
@property (nonatomic) BOOL shouldDisplayCancelButton;
@property (nonatomic,retain) id<DropDownPickerDelegate>PickerDelegate;

-(id)initWithTextField:(UITextField *)textFeild;
-(id)initWithTextFeild:(UITextField *)textFeild withData:(NSArray *)data;
-(void)setPlaceHolder:(NSString *)string;
-(void)setData:(NSArray *)data;
-(UIPickerView*) getPickerView;
-(void)startSampleProcess;
@end
