//
//  ZKLaunchView.m
//  ZKLaunchView
//
//  Created by ZK on 16/7/26.
//  Copyright © 2016年 ZK. All rights reserved.
//

#import "ZKLaunchView.h"

#define KeyWindow           [[UIApplication sharedApplication].delegate window]
#define ResourcePath        [[NSBundle mainBundle] resourcePath]    //获取自定义文件的bundle路径
#define ImageNamed(name)    [UIImage imageWithContentsOfFile:[ResourcePath stringByAppendingPathComponent:name]]

@interface ZKLaunchView()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ZKLaunchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    CGSize viewSize = KeyWindow.bounds.size;
    NSString *viewOrientation = @"Portrait"; // 横屏设置成 @"Landscape"
    
    NSArray <NSDictionary *> *launchImages = [NSBundle mainBundle].infoDictionary[@"UILaunchImages"];
    
    __block NSString *launchImageName = nil;
    
    [launchImages enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImageName = dict[@"UILaunchImageName"];
            *stop = YES;
        }
    }];
    
    _imageView = [[UIImageView alloc] initWithImage:ImageNamed(launchImageName)];
    _imageView.frame = [UIScreen mainScreen].bounds;
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_imageView];
}

+ (void)showAndAutoDisappear {
    [self showAndAutoDisappearAfter:.8];
}

+ (void)showAndAutoDisappearAfter:(NSTimeInterval)seconds {
    [self showWithDisappearType:ZKLaunchViewDisappearTypeZoomOut after:seconds];
}

+ (void)showWithDisappearType:(ZKLaunchViewDisappearType)type after:(NSTimeInterval)seconds {
    ZKLaunchView *launchView = [[ZKLaunchView alloc] initWithFrame:KeyWindow.bounds];
    [KeyWindow addSubview:launchView];
    
    CGFloat scale = 1.3f;
    if (type == ZKLaunchViewDisappearTypeZoomOut) {
        scale = 1.3f;
    }
    else if (type == ZKLaunchViewDisappearTypeZoomIn) {
        scale = .001;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:seconds animations:^{
            launchView.alpha = 0;
            launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1);
        } completion:^(BOOL finished) {
            [launchView removeFromSuperview];
        }];
    });
}

@end
