//
//  XMPopSubview.h
//  需要使用弹出效果视图控件的话继承自该视图就可以
//
//  Created by will.xu on 16/4/25.
//  Copyright © 2016年 willing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Frame.h"

@protocol XMPopViewProtocol <NSObject>

/*!
 *  基于ViewController创建弹出视图
 *
 *  @param ctrl  控制器
 *  @param title 标题
 *
 *  @return 视图对象
 */
-(instancetype)initWithController:(UIViewController*)ctrl title:(NSString*)title;

/*!
 *  显示视图
 *  @param animate YES表示使用动画，否则不使用
 */
-(void)showWithAnimate:(BOOL)animate;

/*!
 *  隐藏视图
 *
 *  @param animate YES表示使用动画，否则不使用
 */
-(void)hideWithAnimate:(BOOL)animate;

@end

@protocol XMPopSubviewDelegate <NSObject>

@optional
-(void)onPopViewDidShow;
-(void)onPopViewDidHide;

@end

//弹窗展示风格
typedef NS_OPTIONS(NSUInteger, XMPopSubviewStyle) {
	XMPopSubviewStyle_noHide = 0, //!< 不隐藏
	XMPopSubviewStyle_hideTitle = 1 << 1, //!< 隐藏标题
	XMPopSubviewStyle_hideCancelBtn = 1 << 2, //!< 隐藏取消按钮
	XMPopSubviewStyle_hideAll = XMPopSubviewStyle_hideTitle | XMPopSubviewStyle_hideCancelBtn, //!< 即隐藏标题也隐藏取消按钮
};

@interface XMPopSubview : UIView <XMPopViewProtocol>

@property (nonatomic, weak) id<XMPopSubviewDelegate> popDelegate;
@property (nonatomic, weak) UIViewController *attachCtrl;

@property (nonatomic,strong) UIColor *bgColor;       //!< 背景色

@property (nonatomic,assign) BOOL isShowing;            //!< 表示是否正在显示
@property (nonatomic,assign) BOOL autoSizeWithSubFrame; //!< 是否自动适应子视图大小，默认NO
@property (nonatomic,assign) BOOL canTouchToHide;          //!< 触摸去隐藏，默认YES
@property (nonatomic,assign) XMPopSubviewStyle style;	//!< pop弹窗风格,默认XMPopSubviewStyle_noHide

- (void)onViewHide;

@end
