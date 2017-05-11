//
//  TextFieldViewController.h
//  CJUIKitDemo
//
//  Created by dvlproad on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJTextField.h"

@interface TextFieldViewController : UIViewController

@property (nonatomic, weak) IBOutlet CJTextField *textFiled;

@property (nonatomic, weak) IBOutlet UISwitch *canInputSwitch;  //控制是否允许文本框输入的开关
@property (nonatomic, weak) IBOutlet CJTextField *addSubtractTextField;


@end
