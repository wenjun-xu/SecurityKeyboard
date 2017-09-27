//
//  WjKeyboard.m
//  WjKeyboard
//
//  Created by 徐庆标 on 17/09/04.
//  Copyright © 2017年 徐庆标. All rights reserved.
//

#import "WjKeyboard.h"
#import "WjKeyboardNumPad.h"
#import "WjKeyboardWordPad.h"


#define  iPhone4     ([[UIScreen mainScreen] bounds].size.height==480)
#define  iPhone5     ([[UIScreen mainScreen] bounds].size.height==568)
#define  iPhone6     ([[UIScreen mainScreen] bounds].size.height==667)
#define  iPhone6plus ([[UIScreen mainScreen] bounds].size.height==736)


@interface WjKeyboard ()<WjKeyboardNumPadDelegate,WjKeyboardWordPadDelegate>

@property (nonatomic, weak) WjKeyboardNumPad *numPad;
@property (nonatomic, weak) WjKeyboardWordPad *wordPad;
@end

@implementation WjKeyboard

- (instancetype)init {
   
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:208/255.0 green:211/255.0 blue:219/255.0 alpha:1];
        CGRect rect = CGRectZero;
        if (iPhone4 || iPhone5) {
            rect = CGRectMake(0, 0, 320, 216);
        }else if (iPhone6){
            rect = CGRectMake(0, 0, 375, 216);
        }else{
            rect = CGRectMake(0, 0, 414, 226);
        }
        
        self.frame = rect;
        WjKeyboardNumPad *numPad = [[WjKeyboardNumPad alloc] initWithFrame:rect];
        numPad.delegate = self;
        self.numPad = numPad;
        [self addSubview:numPad];
    }
    return self;
}

- (void)KeyboardNumPadDidClickSwitchBtn:(UIButton *)btn {
    NSLog(@"btn.text === %@",btn);
    if ([btn.titleLabel.text isEqualToString:@".?123"]) {
        WjKeyboardWordPad *wordPad = [[WjKeyboardWordPad alloc] initWithFrame:self.bounds];
        wordPad.delegate = self;
        [self addSubview:wordPad];
        self.wordPad = wordPad;
        [self.numPad removeFromSuperview];
    }
}

- (void)KeyboardWordPadDidClickSwitchBtn:(UIButton *)btn {
    NSLog(@"btn.text === %@",btn);

    if ([btn.titleLabel.text isEqualToString:@"拼音"]) {
        
        WjKeyboardNumPad *numPad = [[WjKeyboardNumPad alloc] initWithFrame:self.bounds];
        numPad.delegate = self;
        [self addSubview:numPad];
        self.numPad = numPad;
        [self.wordPad removeFromSuperview];
    }
}

- (void)KeyboardSymbolPadDidClickSwitchBtn:(UIButton *)btn {
    
    if ([btn.titleLabel.text isEqualToString:@"ABC"]) {
        
        WjKeyboardNumPad *numPad = [[WjKeyboardNumPad alloc] initWithFrame:self.bounds];
        numPad.delegate = self;
        [self addSubview:numPad];
        self.numPad = numPad;
        
    } else {
        
        WjKeyboardWordPad *wordPad = [[WjKeyboardWordPad alloc] initWithFrame:self.bounds];
        wordPad.delegate = self;
        [self addSubview:wordPad];
        self.wordPad = wordPad;
    }
}


@end

