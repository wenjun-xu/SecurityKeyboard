//
//  WjKeyboardBtn.m
//  WjKeyboard
//
//  Created by 徐庆标 on 17/09/04.
//  Copyright © 2017年 徐庆标. All rights reserved.
//

#import "WjKeyboardBtn.h"

@implementation WjKeyboardBtn

+ (WjKeyboardBtn *)buttonWithTitle:(NSString *)title tag:(NSInteger)tag delegate:(id)delegate
{
    WjKeyboardBtn *btn = [WjKeyboardBtn buttonWithType:UIButtonTypeCustom];
    btn.tag = tag;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:btn action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    btn.titleLabel.font = [UIFont systemFontOfSize:20.0 weight:0.12];
    [btn setBackgroundColor:[UIColor whiteColor]];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.delegate = delegate;
    return btn;
}

- (void)btnClick:(WjKeyboardBtn *)btn {
    
    if ([self.delegate respondsToSelector:@selector(KeyboardBtnDidClick:)]) {
        [self.delegate KeyboardBtnDidClick:btn];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
