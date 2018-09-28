//
//  XMPopViewContainer.h
//
//  Created by will.xu on 16/4/25.
//  Copyright © 2016年 willing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMPopSubview;
@class XMPopViewContainer;

@protocol XMPopViewContainerDelegate<NSObject>

@optional
-(void)containerDidShow:(XMPopViewContainer*)container;
-(void)containerDidHide:(XMPopViewContainer*)container;
-(void)containerDidTouchOutsideHide:(XMPopViewContainer*)container;

@end

@interface XMPopViewContainer : UIView

@property (nonatomic,weak) id<XMPopViewContainerDelegate> delegate;
@property (nonatomic,copy  ) NSString    *title; //!< the title for show
@property (nonatomic,strong) UIView      *superPopView; //!< super view

@property (nonatomic,strong) UIColor     *bgColor;  //!< default color: white
/**
 *  a flag indicate whether resize self according subview's frame or not,default is NO. If you want to use this apperance,set before call showSubView:withAnimate:
 */
@property (nonatomic,assign) BOOL        autoSizeWithSubFrame;
@property (nonatomic,assign) BOOL        hideTitle;     //!< default NO
@property (nonatomic,assign) BOOL        hideCancelBtn; //!< default NO

-(instancetype)initWithSuperView:(UIView*)superView title:(NSString*)title;
-(void)showSubView:(XMPopSubview*)view withAnimate:(BOOL)animate;
-(void)hidePopContainerWithAnimate:(BOOL)animate;

@end
