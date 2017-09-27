//
//  ViewController.m
//  SecurityKeyboard
//
//  Created by 徐庆标 on 2017/9/27.
//  Copyright © 2017年 徐庆标. All rights reserved.
//

#import "ViewController.h"
#import "WjKeyboard.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()
@property (nonatomic,strong)UITextField *passWord;
@property (nonatomic,copy)NSString *mimas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _passWord = [[UITextField alloc] initWithFrame:CGRectMake(50,200,200,40)];
//    _passWord.tintColor = [UIColor grayColor];
    _passWord.backgroundColor = [UIColor grayColor];
    _passWord.placeholder = @"请输入密码";
//    _passWord.clearsOnBeginEditing = YES;
//    _passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
//    _passWord.secureTextEntsry = YES;
    _passWord.inputView = [[WjKeyboard alloc] init];
    [_passWord addTarget:self action:@selector(inputLenth:) forControlEvents:UIControlEventAllEvents];
    _passWord.tag = 20;
    [self setTextFieldInputAccessoryViewWithTF:_passWord];
    [self.view addSubview:_passWord];

}



- (void)inputLenth:(UITextField *)textField {
    if (textField.text.length > 10) {
        textField.text = _mimas;
    }else {
        _mimas = textField.text;
    }
}







/**
 * 设置回收键盘按钮
 */
- (void)setTextFieldInputAccessoryViewWithTF:(UITextField *)tf
{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * spaceBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    doneBtn.frame = CGRectMake(0, 0, 40, 30);
    [doneBtn addTarget:self action:@selector(keyboardHide) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneBtnItem = [[UIBarButtonItem alloc]initWithCustomView:doneBtn];
    NSArray *buttonsArray = [NSArray arrayWithObjects:spaceBtn,doneBtnItem,nil];
    [topView setItems:buttonsArray];
    
    [tf setInputAccessoryView:topView];
    [tf setAutocorrectionType:UITextAutocorrectionTypeNo];
    [tf setAutocapitalizationType:UITextAutocapitalizationTypeNone];
}
/**
 * 隐藏键盘方法
 */
- (void)keyboardHide {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}













- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
