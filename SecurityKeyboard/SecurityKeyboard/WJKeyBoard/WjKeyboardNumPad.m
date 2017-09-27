//
//  WjKeyboardNumPad.m
//  WjKeyboard
//
//  Created by 徐庆标 on 17/09/04.
//  Copyright © 2017年 徐庆标. All rights reserved.
//

#import "WjKeyboardNumPad.h"

@interface WjKeyboardNumPad () <WjKeyboardBtnDelegate>
@property (nonatomic, weak) UITextField *responder;

@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) NSArray *wordArray;
@property (nonatomic, strong) NSArray *WORDArray;
@property (nonatomic, weak) UIButton *trasitionWordBtn;
@property (nonatomic, weak) UIButton *deleteBtn;
@property (nonatomic, weak) UIButton *numPadCheckBtn;
@property (nonatomic, weak) UIButton *okBtn;
@end

@implementation WjKeyboardNumPad


- (UITextField *)responder {
    if (!_responder) {  // 防止多个输入框采用同一个inputview
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *firstResponder = [keyWindow valueForKey:@"firstResponder"];
    _responder = (UITextField *)firstResponder;
    
    }
    return _responder;
}

- (NSArray *)wordArray {
    
    if (!_wordArray) {
        NSMutableArray *numberArr=[NSMutableArray arrayWithArray:@[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m"]];
        NSInteger numberCount=numberArr.count;
        NSMutableArray *tmpArr=[NSMutableArray array];
        for (NSInteger i=0; i<numberCount; i++) {
            NSNumber *number=numberArr[arc4random() % numberArr.count];
            [tmpArr addObject:number];
            [numberArr removeObject:number];
        }
        _wordArray = @[tmpArr[0],tmpArr[1],tmpArr[2],tmpArr[3],tmpArr[4],tmpArr[5],tmpArr[6],tmpArr[7],tmpArr[8],tmpArr[9],tmpArr[10],tmpArr[11],tmpArr[12],tmpArr[13],tmpArr[14],tmpArr[15],tmpArr[16],tmpArr[17],tmpArr[18],tmpArr[19],tmpArr[20],tmpArr[21],tmpArr[22],tmpArr[23],tmpArr[24],tmpArr[25],@"空格"];
    }
    return _wordArray;
}

- (NSArray *)WORDArray {
    
    if (!_WORDArray) {
        NSMutableArray *numberArr=[NSMutableArray arrayWithArray:@[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M"]];
        NSInteger numberCount=numberArr.count;
        NSMutableArray *tmpArr=[NSMutableArray array];
        for (NSInteger i=0; i<numberCount; i++) {
            NSNumber *number=numberArr[arc4random() % numberArr.count];
            [tmpArr addObject:number];
            [numberArr removeObject:number];
        }
        _WORDArray = @[tmpArr[0],tmpArr[1],tmpArr[2],tmpArr[3],tmpArr[4],tmpArr[5],tmpArr[6],tmpArr[7],tmpArr[8],tmpArr[9],tmpArr[10],tmpArr[11],tmpArr[12],tmpArr[13],tmpArr[14],tmpArr[15],tmpArr[16],tmpArr[17],tmpArr[18],tmpArr[19],tmpArr[20],tmpArr[21],tmpArr[22],tmpArr[23],tmpArr[24],tmpArr[25],@"空格"];
    }
    return _WORDArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addControl];
    }
    return self;
}

- (void)addControl {
    
    NSMutableArray *btnArray = [NSMutableArray array];
    for (int i = 0; i< 27; i++) {
      WjKeyboardBtn *btn  = [WjKeyboardBtn buttonWithTitle:self.wordArray[i] tag:i delegate:self];
        if (i == 26) {
        } else {
            [btn setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:11/255.0 green:98/255.0 blue:224/255.0 alpha:1]] forState:UIControlStateHighlighted];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        }
        [btnArray addObject:btn];
        [self addSubview:btn];
    }
    self.btnArray = btnArray;
    
    // 大小写装换
    UIButton *trasitionWordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [trasitionWordBtn setImage:[UIImage imageNamed:@"icon_daxiaoxieqiehuan_nor"] forState:UIControlStateNormal];
    [trasitionWordBtn setImage:[UIImage imageNamed:@"icon_daxiaoxieqiehuan_pre"] forState:UIControlStateSelected];
    
    [trasitionWordBtn addTarget:self action:@selector(trasitionWord:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:trasitionWordBtn];
    
    // 删除键
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setImage:[UIImage imageNamed:@"icon_delete_nor"] forState:UIControlStateNormal];
    
    [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteBtn];
    
    // 数字键123
    UIButton *numPadCheckBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [numPadCheckBtn setBackgroundColor:[UIColor colorWithRed:170/255.0 green:176/255.0 blue:186/255.0 alpha:1]];
    numPadCheckBtn.layer.cornerRadius = 5;
    numPadCheckBtn.layer.masksToBounds = YES;
    [numPadCheckBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [numPadCheckBtn setTitle:@".?123" forState:UIControlStateNormal];
    [numPadCheckBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:numPadCheckBtn];
    
    // return 键
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:170/255.0 green:176/255.0 blue:186/255.0 alpha:1]] forState:UIControlStateHighlighted];
    [okBtn setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:170/255.0 green:176/255.0 blue:186/255.0 alpha:1]] forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:okBtn];
    
    self.okBtn = okBtn;
    self.numPadCheckBtn = numPadCheckBtn;
    self.deleteBtn = deleteBtn;
    self.trasitionWordBtn = trasitionWordBtn;
    
    self.numPadCheckBtn.layer.cornerRadius = 5.0;
    self.numPadCheckBtn.layer.masksToBounds = YES;
    self.okBtn.layer.cornerRadius = 5.0;
    self.okBtn.layer.masksToBounds = YES;
    
    self.deleteBtn.layer.cornerRadius = 5.0;
    self.deleteBtn.layer.masksToBounds = YES;
}

- (void)trasitionWord:(UIButton *)trasitionWordBtn {
    
    trasitionWordBtn.selected = !trasitionWordBtn.selected;
    if (trasitionWordBtn.selected) {
        for (int i = 0; i<26; i++) {
            WjKeyboardBtn *btn = self.btnArray[i];
            [btn setTitle:self.WORDArray[i] forState:UIControlStateNormal];
        }
    } else {
        for (int i = 0; i<26; i++) {
            WjKeyboardBtn *btn = self.btnArray[i];
            [btn setTitle:self.wordArray[i] forState:UIControlStateNormal];
        }
    }
}

- (void)deleteBtnClick {
    
    if (self.responder.text.length) {
        self.responder.text = [self.responder.text substringToIndex:self.responder.text.length-1];
    }
}

- (void)switchBtnClick:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(KeyboardNumPadDidClickSwitchBtn:)]) {
        [self.delegate KeyboardNumPadDidClickSwitchBtn:btn];
    }
}


- (void)okBtnClick {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGFloat smallBtnW = (self.frame.size.width - 13*margin)/10;
    CGFloat btnH = (self.frame.size.height - 5*margin)/4;
    
    for (int i = 0; i < 10; i++) {
        WjKeyboardBtn *btn = self.btnArray[i];
        btn.frame = CGRectMake(2*margin + i*(smallBtnW + margin), margin, smallBtnW, btnH);
    }
    CGFloat margin2 = (self.frame.size.width - 8*margin - 9*smallBtnW)/2;
    for (int i = 10; i < 19; i++) {
        WjKeyboardBtn *btn = self.btnArray[i];
        btn.frame = CGRectMake(margin2 + (i-10)*(smallBtnW + margin), 2*margin + btnH, smallBtnW, btnH);
    }
    CGFloat margin3 = (self.frame.size.width - 7 * smallBtnW - 8 *margin - 2 * 1.5 * smallBtnW ) / 2;
    self.trasitionWordBtn.frame = CGRectMake(margin3, 3*margin + 2*btnH, smallBtnW*1.5, btnH);
    self.deleteBtn.frame = CGRectMake(margin3 + smallBtnW*1.5+ 8*margin + 7*smallBtnW , 3*margin + 2*btnH, smallBtnW * 1.5, btnH);
    for (int i = 19; i<26; i++) {
        WjKeyboardBtn *btn = self.btnArray[i];
        btn.frame = CGRectMake(margin3 + smallBtnW*1.5 + margin + (i-19)*(smallBtnW + margin), 3*margin + 2*btnH, smallBtnW, btnH);
    }
    
    CGFloat bigBtnW = (self.frame.size.width - 5*margin)/4;
    self.numPadCheckBtn.frame = CGRectMake(margin, 4*margin + btnH*3, bigBtnW, btnH);
    WjKeyboardBtn *btn = [self.btnArray lastObject];
    btn.frame = CGRectMake(2*margin+bigBtnW, 4*margin + btnH*3, bigBtnW * 2 + margin, btnH);
    self.okBtn.frame = CGRectMake(4*margin + 3*bigBtnW, 4*margin + btnH*3, bigBtnW, btnH);
}

#pragma mark - WjKeyboardBtnDelegate
- (void)KeyboardBtnDidClick:(WjKeyboardBtn *)btn {
    
    if ([btn.titleLabel.text isEqualToString:@"空格"]) {
        self.responder.text = [self.responder.text stringByAppendingString:@" "];
    } else {
        if (self.trasitionWordBtn.selected) {
            self.responder.text = [self.responder.text stringByAppendingString:self.WORDArray[[self.btnArray indexOfObject:btn]]];
        } else {
            self.responder.text = [self.responder.text stringByAppendingString:self.wordArray[[self.btnArray indexOfObject:btn]]];
        }
    }
}

/**
 *  用颜色返回一张图片
 */
- (UIImage *)createImageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end

