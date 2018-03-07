//
//  UITextField+CJAddLeftRightView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "UITextField+CJAddLeftRightView.h"
#import <objc/runtime.h>

@interface UITextField ()

@property (nonatomic, copy) void (^cjLeftViewHandle)(UITextField *textField);
@property (nonatomic, copy) void (^cjRightViewHandle)(UITextField *textField);

@end

@implementation UITextField (CJAddLeftRightView)

#pragma mark - runtime
static NSString * const kCJLeftViewHandleKey = @"kCJLeftViewHandleKey";
static NSString * const kCJRightViewHandleKey = @"kCJRightViewHandleKey";

- (void (^)(UITextField *))cjLeftViewHandle {
    return objc_getAssociatedObject(self, (__bridge const void *)(kCJLeftViewHandleKey));
}

- (void)setCjLeftViewHandle:(void (^)(UITextField *))cjLeftViewHandle {
    objc_setAssociatedObject(self, (__bridge const void *)(kCJLeftViewHandleKey), cjLeftViewHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UITextField *))cjRightViewHandle {
    return objc_getAssociatedObject(self, (__bridge const void *)(kCJRightViewHandleKey));
}

- (void)setCjRightViewHandle:(void (^)(UITextField *))cjRightViewHandle {
    objc_setAssociatedObject(self, (__bridge const void *)(kCJRightViewHandleKey), cjRightViewHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)cj_addLeftOffset:(CGFloat)leftOffset {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftOffset, 10)];
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)cj_addRightOffset:(CGFloat)rightOffset {
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightOffset, 10)];
    self.rightView = rightView;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (UIButton *)cj_addLeftButtonWithSize:(CGSize)buttonSize
                            leftOffset:(CGFloat)leftOffset
                           rightOffset:(CGFloat)rightOffset
                       leftNormalImage:(UIImage *)leftNormalImage
                            leftHandel:(void (^)(UITextField *textField))leftHandle
{    
    CGFloat leftViewWidth = leftOffset + buttonSize.width + rightOffset;
    CGFloat leftViewHeight = buttonSize.height;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, leftViewWidth, leftViewHeight)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, leftOffset, 0, rightOffset)];
    [button setImage:leftNormalImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.cjLeftViewHandle = leftHandle;
    self.leftView = button;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    return button;
}

- (UIButton *)cj_addRightButtonWithSize:(CGSize)buttonSize
                            rightOffset:(CGFloat)rightOffset
                            leftOffset:(CGFloat)leftOffset
                       rightNormalImage:(UIImage *)rightNormalImage
                            rightHandle:(void (^)(UITextField *textField))rightHandle
{
    CGFloat rightViewWidth = rightOffset + buttonSize.width + leftOffset;
    CGFloat rightViewHeight = buttonSize.height;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, rightViewWidth, rightViewHeight)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, leftOffset, 0, rightOffset)];
    [button setImage:rightNormalImage forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.cjRightViewHandle = rightHandle;
    self.rightView = button;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    return button;
}

- (void)leftButtonClick {
    if (self.cjLeftViewHandle) {
        self.cjLeftViewHandle(self);
    }
}

- (void)rightButtonClick {
    if (self.cjRightViewHandle) {
        self.cjRightViewHandle(self);
    }
}


@end
