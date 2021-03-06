//
//  DemoTextFieldFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef TEST_CJBASEUIKIT_POD
#import "CJTextField.h"
#import "UIColor+CJHex.h"
#else
#import <CJBaseUIKit/CJTextField.h>
#import <CJBaseUIKit/UIColor+CJHex.h>
#endif

@interface DemoTextFieldFactory : NSObject

///含左侧图片的textField，并支持通过leftButtonSelected属性切换图片变化 (使用场景：登录等)
+ (CJTextField *)textFieldWithNormalImage:(UIImage *)normalImage
                            selectedImage:(UIImage *)selectedImage;

///含 左侧label 的textField(使用场景：忘记密码、修改密码等)
+ (CJTextField *)textFieldWithLeftLabelText:(NSString *)leftLabelText;


///含 左侧label 和 右侧button 的textField(使用场景：获取验证码等)
+ (CJTextField *)textFieldWithLeftLabelText:(NSString *)leftLabelText rightButton:(UIButton *)rightButton;

/// 用来选择的文本框(文本框中的值只能来源于选择，不能来源于输入)
+ (CJTextField *)textFieldWhichTextOnlyFromPickerView:(UIView *)pickerView;

/**
 *  用来选择的文本框(文本框中的值只能来源于选择，不能来源于输入)
 *
 *  @param pickerView           pickerView
 *  @param leftButtonHandle     leftButtonHandle
 *  @param rightButtonHandle    rightButtonHandle
 */
+ (CJTextField *)textFieldWhichTextOnlyFromPickerView:(UIView *)pickerView
                                     leftButtonHandle:(void(^)(UIButton *button))leftButtonHandle
                                    rightButtonHandle:(void(^)(UIButton *button))rightButtonHandle;

@end
