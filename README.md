# GHTransitioningAnimation
iOS 转场动画学习记录

![景甜.jpg](https://upload-images.jianshu.io/upload_images/1419035-74efd9bbf3447484.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/620)

####关于转场动画
######转场动画一直是一个心结,现在有时间正好把之前所学的整理下来防止自己忘记


####API
在iOS5.6以前采用block的方式实现转场但是代码耦合不易于扩展和维护,针对这个问题
在iOS7之后苹果加入了新的API用于转场动画

####相关知识点

![548467-900501947b5d62bd.jpg](https://upload-images.jianshu.io/upload_images/1419035-f326cdf0df81cac0.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

转场过程
下面是一个present动画的步骤：
1.不管是用代码还是通过segue，我们需要触发转场。
2.UIKit向"to" view controller(将被显示的view controller)的transitioning delegate询问，如果没有代理，就会用内置的默认转场动画。
3.UIKit之后向transigioning delegate通过代理方法animationControllerForPresentedController(_:presentingController:sourceController:)询问一个animation controller，如果返回nil，仍然会用默认的动画。
4.一旦有一个有效的animation controller后，UIKit就会构建transitioning context。
5.UIKit之后向animation controller通过transitionDuration(_:)询问动画持续时长。
6.UIKit调用animateTransition来实现animation controller的转场动画。
7.最后animation controller调用context的completeTransition方法来表示这次动画已经结束



* 转场协议: UIViewControllerTransitioningDelegate
每个view controller都可以有一个transitioningDelegate代理，它实现了UIViewControllerTransitioningDelegate的协议。
不管你是present还是dismiss一个view controller，UIKit总会向transitioning delegate询问是否有代理可用。设置view controller的transitioningDelegate为我们自定义的类来作出自定义的转场动画。


```
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
}
```
>/*
 不管是 present 还是dismiss
 要是调用interactionControllerForPresentation 或者是 interactionControllerForDismissal
 返回值是nil,就会走下面animationControllerForPresentedController和animationControllerForDismissedController方法
 要是不是nil,就不会走下面这两个方法了， 在我们这里也就是用手势测试的时候是不会走的，点击present或   者是dismiss会走
 */
// 这个方法返回一个遵守 <UIViewControllerAnimatedTransitioning> 协议的对象
// 其实返回的就是PresentedController控制器的动画

---

```
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{

}

```
>这个方法和上面的解释是类似的，只不过这里的控制器就是DismissedController


---
```
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{};
```
> UIKit还会调用代理的interactionControllerForPresentation:方法来获取交互式控制器，如果得到了nil则执行非交互式动画
// 如果获取到了不是nil的对象，那么UIKit不会调用animator的animateTransition方法，而是调用交互式控制器的startInteractiveTransition:方法。

---


```
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{};
```
> 这个方法是在dismiss的时候的时候调用，也是交互转场执行的时候

---

```
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0){};
```
>这个方法的返回值是UIPresentationController

---

* 动画协议
```
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
}
```
>动画执行的时间
---

```
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
}
```

- initialFrameForViewController 开始 ViewController 的frame
finalFrameForViewController 结束ViewController 的 frame。
---

* 交互控制器协议UIViewControllerInteractiveTransitioning 简单的来说就是利用手势来完成转场

* 动画
* 视图
---

####问题
两者的区别:
UIModalPresentationFullScreen <br/>UIModalPresentationCustom 

modalTransitionStyle
modalPresentationStyle

1. modalTransitionStyle
```
   // 默认的从下到上
   UIModalTransitionStyleCoverVertical = 0,
   // 翻转
   UIModalTransitionStyleFlipHorizontal__TVOS_PROHIBITED,
   // 渐显
  UIModalTransitionStyleCrossDissolve,
  // 类似你翻书时候的效果
  UIModalTransitionStylePartialCurl NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,

```
2. modalPresentationStyle
```
  //presented控制器充满全屏，如果弹出VC的wantsFullScreenLayout设置为YES的，则会填充到状态栏下边，否则不会填充到状态栏之下.iPhone默认是这个
  UIModalPresentationFullScreen = 0,
  //presented控制器的高度和当前屏幕高度相同，宽度和竖屏模式下屏幕宽度相同，剩余未覆盖区域将会变暗并阻止用户点击，这种弹出模式下，竖屏时跟UIModalPresentationFullScreen的效果一样，横屏时候两边则会留下变暗的区域
  UIModalPresentationPageSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
  //presented控制器的高度和宽度均会小于屏幕尺寸，presented VC居中显示，四周留下变暗区域。
  UIModalPresentationFormSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
  //presented控制器的弹出方式和presenting VC的父VC的方式相同。
  UIModalPresentationCurrentContext NS_ENUM_AVAILABLE_IOS(3_2),
   //自定义
   UIModalPresentationCustom NS_ENUM_AVAILABLE_IOS(7_0),
  UIModalPresentationOverFullScreen NS_ENUM_AVAILABLE_IOS(8_0),       
  UIModalPresentationOverCurrentContext NS_ENUM_AVAILABLE_IOS(8_0),
   // http://www.15yan.com/story/jlkJnPmVGzc/ 在iPad上弹出控制器
   UIModalPresentationPopover NS_ENUM_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED,
   // None
   UIModalPresentationNone NS_ENUM_AVAILABLE_IOS(7_0) = -1,  

````

----


####利用转场动画实现实现一个淡入淡出的效果

. 创建两个控制器分别命名为GHCrossFromViewController 和 GHCrossToViewController
. 创建一个转场动画管理类,集成自NSObject 命名为GHCrossAnimation
. GHCrossAnimation遵守动画协议,包含#import <UIKit/UIKit.h>框架
<UIViewControllerAnimatedTransitioning>
. 实现动画协议里的两个方法
```
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext;

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext;
```
第一个代理方法直接返回一个时间,这个时间为动画的执行时间.
第二个代理方法主要在这个方法里实现转场动画.
伪代码:
```
1.获取到源控制器在这里定义为fromVc,获取到目标控制器toVc
2.获取到源控制器的view这里定义为fromView.获取到目标控制器toView
3.获取到源控制器的初始位置fromView.frame,获取到目标控制器的结束位置toView.frame
4.获取到contentView

```


