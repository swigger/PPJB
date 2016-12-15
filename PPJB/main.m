//
//  main.m
//  PPJB
//
//  Created by xungeng on 16/12/15.
//  Copyright (c) 2016年 xungeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#include <unistd.h>

char *
getcwd(char *buf, size_t size);

int main(int argc, char * argv[]) {
    char buf[1024];
    printf("%s\n", getcwd(buf, sizeof(buf)));
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
