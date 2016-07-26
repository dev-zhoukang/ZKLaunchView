//
//  ZKLaunchView.h
//  ZKLaunchView
//
//  Created by ZK on 16/7/26.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZKLaunchViewDisappearType) {
    ZKLaunchViewDisappearTypeZoomIn, //!< 放大
    ZKLaunchViewDisappearTypeZoomOut, //!< 缩小
};

@interface ZKLaunchView : UIView

+ (void)showWithDisappearType:(ZKLaunchViewDisappearType)type;

@end
