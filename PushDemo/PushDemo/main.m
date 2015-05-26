//
//  main.m
//  PushDemo
//
//  Created by px on 15/5/25.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <BmobSDK/Bmob.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
#warning 填写key
        [Bmob registerWithAppKey:@"c054f26635406ed0cc893b9d6d890992"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
