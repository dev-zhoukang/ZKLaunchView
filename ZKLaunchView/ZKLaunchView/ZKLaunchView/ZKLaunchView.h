//
//  ZKLaunchView.h
//  ZKLaunchView
//
//  Created by ZK on 16/7/26.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZKLaunchViewDisappearType) {
    ZKLaunchViewDisappearTypeZoomOut, //!< zoom out to disappear
    ZKLaunchViewDisappearTypeZoomIn,  //!< zoom in to disappear
};

@interface ZKLaunchView : UIView

/**
 show launchView and disappear automatically
 disappear type: default to ZKLaunchViewDisappearTypeZoomOut
 remain seconds: default to .8s
 */
+ (void)showAndAutoDisappear;

/**
 show launchView and disappear automatically
 disappear type: default to ZKLaunchViewDisappearTypeZoomOut
 */
+ (void)showAndAutoDisappearAfter:(NSTimeInterval)seconds;

+ (void)showWithDisappearType:(ZKLaunchViewDisappearType)type after:(NSTimeInterval)seconds;

@end
