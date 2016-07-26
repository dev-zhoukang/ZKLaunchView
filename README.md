# ZKLaunchView
启动图

#### 注意: 本demo是基于launch images source, 请将launch screen file入口删除. 否则iOS8之后会自动加载launch screen.xib/storyboard.
当然, 也可以直接使用launch screen文件来布局, 用下面的方法加载即可
```
[[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"]
```

