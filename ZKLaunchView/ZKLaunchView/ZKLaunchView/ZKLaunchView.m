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

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
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

+ (void)showWithDisappearType:(ZKLaunchViewDisappearType)type
{
    ZKLaunchView *launchView = [[ZKLaunchView alloc] initWithFrame:KeyWindow.bounds];
    [KeyWindow addSubview:launchView];
    
    [UIView animateWithDuration:0.8f animations:^{
        launchView.alpha = 0;
        
        CGFloat scale;
        if (type == ZKLaunchViewDisappearTypeZoomIn) {
            scale = 1.3;
        }
        else if (type == ZKLaunchViewDisappearTypeZoomOut) {
            scale = .001;
        }
        
        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1);
        
    } completion:^(BOOL finished) {
        [launchView removeFromSuperview];
    }];
}

@end
