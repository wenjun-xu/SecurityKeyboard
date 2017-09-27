//
//  WjKeyboardNumPad.h
//  WjKeyboard
//
//  Created by 徐庆标 on 17/09/04.
//  Copyright © 2017年 徐庆标. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WjKeyboardBtn.h"

@protocol WjKeyboardNumPadDelegate  <NSObject>

@required
- (void)KeyboardNumPadDidClickSwitchBtn:(UIButton *)btn;

@end

@interface WjKeyboardNumPad : UIView <WjKeyboardBtnDelegate>

@property (nonatomic, assign) id <WjKeyboardNumPadDelegate> delegate;

@end
