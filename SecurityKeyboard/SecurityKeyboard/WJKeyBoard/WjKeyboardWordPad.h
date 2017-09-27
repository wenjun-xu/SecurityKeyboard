//
//  WjKeyboardWordPad.h
//  WjKeyboard
//
//  Created by 徐庆标 on 17/09/04.
//  Copyright © 2017年 徐庆标. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WjKeyboardBtn.h"

@protocol WjKeyboardWordPadDelegate <NSObject>

@required
- (void)KeyboardWordPadDidClickSwitchBtn:(UIButton *)btn;

@end

@interface WjKeyboardWordPad : UIView <WjKeyboardBtnDelegate>

@property (nonatomic, assign) id <WjKeyboardWordPadDelegate> delegate;

@end

