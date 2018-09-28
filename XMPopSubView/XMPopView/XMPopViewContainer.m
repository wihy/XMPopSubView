//
//  XMPopViewContainer.m
//
//  Created by will.xu on 16/4/25.
//  Copyright © 2016年 willing. All rights reserved.
//

#import "XMPopViewContainer.h"
#import "XMBlurView.h"
#import "XMPopSubview.h"
#import "UIView+Frame.h"

#define colorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define colorFromRGBA(rgbValue,trans) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:trans]
#define LSTR(str)       NSLocalizedString(str, nil)
#define kOnePixelsLineHeight        1/[UIScreen mainScreen].scale

static CGFloat kNormalHeight  = 50.0f;
static CGFloat kLineHeight = 1.0f;

@interface XMPopViewContainer ()
{
    
    UIView *_alphaBlackView;
    UIView *_blurView;
    
    UILabel *_topTitleLabel;
    UIView *_topCutLine;
    UIView *_bottomCutLine;
    UIButton *_cancelButton;
}
@property(nonatomic, assign) XMPopSubview *subContainView;

@end


@implementation XMPopViewContainer

- (void)dealloc
{
    self.bgColor = nil;
    self.superPopView = nil;
    self.title = nil;
    self.delegate = nil;
    self.subContainView = nil;
    
}

-(instancetype)initWithSuperView:(UIView*)superView title:(NSString*)title{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.superPopView = superView;
        self.title = title;
        self.hideTitle = NO;
        self.hideCancelBtn = NO;
        self.bgColor = [UIColor whiteColor];
        [self customedUI];
    }
    return self;
}

-(void)customedUI{
    
    self.frame = self.superPopView.frame;
    
    _alphaBlackView = [[UIView alloc] init];
    _alphaBlackView.backgroundColor = colorFromRGBA(0x000000, 0.6);
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
    [_alphaBlackView addGestureRecognizer:tapGestureRecognizer];
    [self addSubview:_alphaBlackView];
    
    _topTitleLabel = [[UILabel alloc] init];
    _topTitleLabel.textAlignment = NSTextAlignmentCenter;
    _topTitleLabel.textColor = colorFromRGB(0x333333);
    _topTitleLabel.text = self.title;
    [_topTitleLabel setAccessibilityLabel:self.title];
    _topTitleLabel.font = [UIFont systemFontOfSize:16];
    [_topTitleLabel sizeToFit];
    [self addSubview:_topTitleLabel];
    
    _blurView = [[UIView alloc] init];
    _blurView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_blurView];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setTitle:LSTR(@"关闭") forState:UIControlStateNormal];
    [_cancelButton setTitleColor:colorFromRGB(0x333333) forState:UIControlStateNormal];
    [_cancelButton setAccessibilityLabel:LSTR(@"关闭")];
    [_cancelButton addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchUpInside];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_cancelButton sizeToFit];
    [self addSubview:_cancelButton];
    
    //半透明效果
    _topCutLine = [[UIView alloc] init];
    _topCutLine.backgroundColor = colorFromRGB(0xfc5832);
    _topCutLine.hidden = YES;
    [self addSubview:_topCutLine];
    
    _bottomCutLine = [[UIView alloc] init];
    _bottomCutLine.backgroundColor = colorFromRGBA(0x333333, 0.15);
    _bottomCutLine.hidden = YES;
    [self addSubview:_bottomCutLine];

}


-(void)layoutSubviews{
    
    //容器视图的高度
    CGFloat containerHeight = [self contentHeight];
    CGFloat fx = 0.0;
    CGFloat fy = 0.0;
    
    _alphaBlackView.frame = CGRectMake(fx, fy, self.width, self.height - containerHeight);
    _blurView.backgroundColor = self.bgColor;
    _blurView.frame = CGRectMake(0, self.height - containerHeight, self.width, containerHeight);
    [self sendSubviewToBack:_blurView];
    
    CGFloat customedViewHeight = self.subContainView.height;
    if (!self.autoSizeWithSubFrame) { //使用的默认高度需要进行计算内部视图的高度
        customedViewHeight = containerHeight;
        if (!self.hideTitle) {
            customedViewHeight -= kNormalHeight + kLineHeight;
        }
        if (!self.hideCancelBtn) {
            customedViewHeight -= kNormalHeight + kLineHeight;
        }
    }
    
    _cancelButton.hidden = self.hideCancelBtn;
    _bottomCutLine.hidden = self.hideCancelBtn;
    if (!self.hideCancelBtn) {
        fy = self.height - kNormalHeight - [XMPopViewContainer safeAreaBottomInset];
        _cancelButton.frame = CGRectMake(fx, fy,self.width, kNormalHeight);
        
        fy = _cancelButton.top - kLineHeight;
        _bottomCutLine.frame = CGRectMake(fx, fy, self.width, kOnePixelsLineHeight);
    }
    
    _topTitleLabel.hidden = self.hideTitle;
//    _topCutLine.hidden = self.hideTitle;
    if (self.hideTitle) {
        fy = _alphaBlackView.bottom;
    }else{
        _topTitleLabel.text = self.title;
        [_topTitleLabel sizeToFit];
        fy = _alphaBlackView.bottom;
        _topTitleLabel.frame = CGRectMake(fx, fy, self.width, kNormalHeight);
        
        fy = _topTitleLabel.bottom;
        _topCutLine.frame = CGRectMake(fx, fy, self.width, kLineHeight);
        fy = _topCutLine.bottom;
    }
    self.subContainView.frame = CGRectMake(fx, fy, self.width, customedViewHeight);
}

#pragma mark --  tap and close actions
-(void)onTapped:(UITapGestureRecognizer*)tapGesturer{
    if (self.subContainView.canTouchToHide) {
        [self hidePopContainerWithAnimate:YES];
        
        if ([self.delegate respondsToSelector:@selector(containerDidTouchOutsideHide:)]) {
            [self.delegate containerDidTouchOutsideHide:self];
        }
    }
}

-(void)onClose{
    [self hidePopContainerWithAnimate:YES];
    
    if ([self.delegate respondsToSelector:@selector(containerDidHide:)]) {
        [self.delegate containerDidHide:self];
    }
}


#pragma mark -- public show and hide methods
-(void)showSubView:(XMPopSubview*)view withAnimate:(BOOL)animate{

    self.subContainView = view;
    //移动位置
    self.frame = self.superPopView.frame;
    MoveTo(self, 0, self.height);
    
    [self addSubview:view];
    [self.superPopView addSubview:self];
    [self.superPopView bringSubviewToFront:self];
    
    if (animate) {
        _alphaBlackView.alpha = 0.0;
        [UIView  animateWithDuration:0.3 animations:^{
            MoveTo(self, 0, 0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                _alphaBlackView.alpha = 1.0;
            }];
            if ([self.delegate respondsToSelector:@selector(containerDidShow:)]) {
                [self.delegate containerDidShow:self];
            }
        }];
    }else{
        _alphaBlackView.alpha = 1.0;
        MoveTo(self, 0, 0);
        
        if ([self.delegate respondsToSelector:@selector(containerDidShow:)]) {
            [self.delegate containerDidShow:self];
        }
    }
}

-(void)hidePopContainerWithAnimate:(BOOL)animate{
    if (animate) {
        [UIView animateWithDuration:0.1 animations:^{
            _alphaBlackView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3f animations:^{
                MoveTo(self, 0, self.height);
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
    }else{
        _alphaBlackView.alpha = 0.0;
        MoveTo(self, 0, self.height);
        [self removeFromSuperview];
        
    }
}

#pragma mark -- content height
-(CGFloat)contentHeight{
    
    if (self.autoSizeWithSubFrame) {
        CGFloat subContentHeight = self.subContainView.height + (kNormalHeight + kLineHeight) * 2;
        if(self.hideTitle){
            subContentHeight -= kNormalHeight + kLineHeight;
        }
        if (self.hideCancelBtn) {
            subContentHeight -= kNormalHeight + kLineHeight;
        }
        return subContentHeight + [XMPopViewContainer safeAreaBottomInset];
    }
    else{
       return  self.height * 5 / 7 + [XMPopViewContainer safeAreaBottomInset];
    }
}


+ (CGFloat)safeAreaBottomInset
{
	return isIPhoneX() ? 34 : 0;
}

static inline BOOL isIPhoneX() {
	BOOL iPhoneX = NO;
	/// 先判断设备是否是iPhone/iPod
	if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
		return iPhoneX;
	}
	
	if (@available(iOS 11.0, *)) {
		/// 利用safeAreaInsets.bottom > 0.0来判断是否是iPhone X。
		UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
		if (mainWindow.safeAreaInsets.bottom > 0.0) {
			iPhoneX = YES;
		}
	}
	
	return iPhoneX;
}
@end
