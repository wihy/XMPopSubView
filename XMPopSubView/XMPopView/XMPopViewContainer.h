//
//  XMPopViewContainer.h
//
//  Created by will.xu on 16/4/25.
//

#import <UIKit/UIKit.h>

@class XMPopViewContainer;
@protocol XMPopViewContainerDelegate<NSObject>

@optional
-(void)containerDidShow:(XMPopViewContainer*)container;
-(void)containerDidHide:(XMPopViewContainer*)container;

@end

@interface XMPopViewContainer : UIView

@property (nonatomic,assign) id<XMPopViewContainerDelegate>delegate;
@property (nonatomic,copy) NSString *title;
@property(nonatomic,retain) UIView *superView;

/**
 *  a flag indicate whether resize self according subview's frame or not,default is NO. If you want to use this apperance,set before call showSubView:withAnimate:
 */
@property (nonatomic,assign) BOOL autoSizeWithSubFrame;
@property (nonatomic,assign) BOOL hideTitle; //default NO

-(instancetype)initWithSuperView:(UIView*)superView title:(NSString*)title;
-(void)showSubView:(UIView*)view withAnimate:(BOOL)animate;
-(void)hidePopContainerWithAnimate:(BOOL)animate;

@end
