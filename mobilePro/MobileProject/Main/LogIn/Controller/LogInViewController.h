//
//  LogInViewController.h
//  MobileProject 登录
//
//  Created by wujunyang on 16/1/5.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LoginViewModel.h"

@interface LogInViewController : UIViewController

@property(nonatomic,strong,readonly)UITextField *userNameText,*passWordTest;

@property(nonatomic,strong,readonly)LoginViewModel *myLoginViewModel;

@end
