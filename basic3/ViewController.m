//
//  ViewController.m
//  basic3
//
//  Created by Aethon Technologies on 10/10/16.
//  Copyright © 2016 Aethon Technologies. All rights reserved.
//

#import "ViewController.h"
#import "DropDownPicker.h"

@interface ViewController ()<UITextFieldDelegate,DropDownPickerDelegate>
{
    UIPickerView *pickerfeild;
    DropDownPicker *brand,*Model,*Fuel,*processCompleted;
    NSMutableArray *brandList,*modelList,*fuelList;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self textFeilds];
    processCompleted=[[DropDownPicker alloc]init];
    processCompleted.PickerDelegate = self;
    [_processDelegate setText:@"Processing"];
    [processCompleted startSampleProcess];
    // Do any additional setup after loading the view, typically from a nib.
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFeilds{
    brandList = [[NSMutableArray alloc]initWithObjects:@"Chess",
                   @"Cricket",@"Football",@"Tennis",@"Volleyball", nil];
    UITextField *textFeild1=(UITextField *)[self.view viewWithTag:10];
    brand= [[DropDownPicker alloc]initWithTextFeild:textFeild1 withData:brandList];
    [brand setPlaceHolder:@"Brand"];
   
    UITextField *textFeild2=(UITextField *)[self.view viewWithTag:11];
    Model= [[DropDownPicker alloc]initWithTextField:textFeild2];
    [Model setPlaceHolder:@"Model"];

    UITextField *textFeild3=(UITextField *)[self.view viewWithTag:12];
    Fuel= [[DropDownPicker alloc]initWithTextField:textFeild3];
    [Fuel setPlaceHolder:@"Fuel"];


}
-(void)processCompleted{
    _processDelegate.text=@"Process completed.";
  
    
}
@end
