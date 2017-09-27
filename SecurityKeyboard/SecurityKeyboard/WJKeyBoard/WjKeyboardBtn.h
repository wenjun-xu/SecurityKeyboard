//
//  WjKeyboardBtn.h
//  WjKeyboard
//
//  Created by 徐庆标 on 17/09/04.
//  Copyright © 2017年 徐庆标. All rights reserved.
//

#import <UIKit/UIKit.h>

#define margin 5

@class WjKeyboardBtn;
@protocol WjKeyboardBtnDelegate <NSObject>

@required
- (void)KeyboardBtnDidClick:(WjKeyboardBtn *)btn;

@end

@interface WjKeyboardBtn : UIButton

+ (WjKeyboardBtn *)buttonWithTitle:(NSString *)title tag:(NSInteger)tag  delegate:(id)delegate;

@property (nonatomic, assign) id <WjKeyboardBtnDelegate> delegate;

@end
