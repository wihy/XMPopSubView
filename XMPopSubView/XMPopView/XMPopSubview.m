//
//  XMPopSubview.m
//
//  Created by will.xu on 16/4/25.
//  Copyright © 2016年 willing. All rights reserved.
//

#import "XMPopSubview.h"
#import "XMPopViewContainer.h"


@interface XMPopSubview ()<XMPopViewContainerDelegate>

@property(nonatomic,strong) XMPopViewContainer *popContainer;

@end


@implementation XMPopSubview

- (void)dealloc
{
    self.popContainer = nil;
    self.bgColor = nil;
}


-(instancetype)initWithController:(UIViewController*)ctrl title:(NSString*)title{
    if (self = [super init]) {
        
        self.attachCtrl = ctrl;
        self.popContainer = [[XMPopViewContainer alloc] initWithSuperView:ctrl.view title:title];
		
		self.autoSizeWithSubFrame = NO;
        self.bgColor = [UIColor whiteColor];
        self.canTouchToHide = YES;
		self.style = XMPopSubviewStyle_noHide;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

-(void)showWithAnimate:(BOOL)animate{
    
    self.isShowing = YES;
    self.popContainer.bgColor = self.bgColor;
    self.popContainer.autoSizeWithSubFrame = self.autoSizeWithSubFrame;
	
	//判断操作
	if (self.style == XMPopSubviewStyle_hideAll) {
		self.popContainer.hideTitle = YES;
		self.popContainer.hideCancelBtn = YES;
	}
	else if (self.style == XMPopSubviewStyle_hideTitle) {
		self.popContainer.hideTitle = YES;
		self.popContainer.hideCancelBtn = NO;
	}
	else if (self.style == XMPopSubviewStyle_hideCancelBtn) {
		self.popContainer.hideTitle = NO;
		self.popContainer.hideCancelBtn = YES;
	}
	else if (self.style == XMPopSubviewStyle_noHide) {
		self.popContainer.hideTitle = NO;
		self.popContainer.hideCancelBtn = NO;
	}
	
    [self.popContainer showSubView:self withAnimate:animate];
    
    [self setNeedsLayout];
}

-(void)hideWithAnimate:(BOOL)animate{
    
    self.isShowing = NO;
    self.attachCtrl = nil;
    [self.popContainer hidePopContainerWithAnimate:animate];
    [self onViewHide];
    
    if ([self.popDelegate respondsToSelector:@selector(onPopViewDidHide)]) {
        [self.popDelegate onPopViewDidHide];
    }
}

#pragma mark -- 
-(void)containerDidShow:(XMPopViewContainer*)container{
    
    if ([self.popDelegate respondsToSelector:@selector(onPopViewDidShow)]) {
        [self.popDelegate onPopViewDidShow];
    }
}

-(void)containerDidHide:(XMPopViewContainer*)container{
    
    self.isShowing = NO;
    self.attachCtrl = nil;
    if ([self.popDelegate respondsToSelector:@selector(onPopViewDidHide)]) {
        [self.popDelegate onPopViewDidHide];
    }
    
    [self onViewHide];
}

-(void)containerDidTouchOutsideHide:(XMPopViewContainer*)container{
    
    self.isShowing = NO;
    self.attachCtrl = nil;
    if ([self.popDelegate respondsToSelector:@selector(onPopViewDidHide)]) {
        [self.popDelegate onPopViewDidHide];
    }
    
    [self onViewHide];
}


-(void)onViewHide{
    
}

@end
