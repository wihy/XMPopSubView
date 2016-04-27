//
//  XMPopViewContainer.m
//
//  Created by will.xu on 16/4/25.
//

#import "XMPopViewContainer.h"
#import "XMBlurView.h"
#import "UIView+Frame.h"

#define colorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define colorFromRGBA(rgbValue,trans) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:trans]
#define LSTR(str)       NSLocalizedString(str, nil)

static CGFloat kNormalHeight  = 50.0f;
static CGFloat kLineHeight = 1.0f;

@interface XMPopViewContainer ()
{
    UIView *_subContainView;
    
    UIView *_alphaBlackView;
    UIView *_blurView;
    
    UILabel *_topTitleLabel;
    UIView *_topCutLine;
    UIView *_bottomCutLine;
    UIButton *_cancelButton;
    
}


@end


@implementation XMPopViewContainer

- (void)dealloc
{
    _cancelButton = nil;
    _topCutLine = nil;
    _topTitleLabel = nil;
    _bottomCutLine = nil;
    _blurView = nil;
    _alphaBlackView = nil;
    _subContainView = nil;
    _superView = nil;
}

-(instancetype)initWithSuperView:(UIView*)superView title:(NSString*)title{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.superView = superView;
        self.title = title;
        self.hideTitle = NO;
        
        [self customedUI];
    }
    return self;
}

-(void)customedUI{
    
    self.frame = self.superView.frame;
    
    _alphaBlackView = [[UIView alloc] init];
    _alphaBlackView.backgroundColor = colorFromRGBA(0x000000, 0.7);
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapped:)];
    [_alphaBlackView addGestureRecognizer:tapGestureRecognizer];
    [self addSubview:_alphaBlackView];
    
    _topTitleLabel = [[UILabel alloc] init];
    _topTitleLabel.textAlignment = NSTextAlignmentCenter;
    _topTitleLabel.textColor = colorFromRGB(0xfc5832);
    _topTitleLabel.text = self.title;
    [_topTitleLabel setAccessibilityLabel:self.title];
    _topTitleLabel.font = [UIFont systemFontOfSize:15];
    [_topTitleLabel sizeToFit];
    [self addSubview:_topTitleLabel];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelButton setTitle:LSTR(@"关闭") forState:UIControlStateNormal];
    [_cancelButton setTitleColor:colorFromRGB(0x333333) forState:UIControlStateNormal];
    [_cancelButton setAccessibilityLabel:LSTR(@"关闭")];
    [_cancelButton addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton sizeToFit];
    [self addSubview:_cancelButton];
    
    //半透明效果
    _topCutLine = [[UIView alloc] init];
    _topCutLine.backgroundColor = colorFromRGB(0xfc5832);
    [self addSubview:_topCutLine];
    
    _bottomCutLine = [[UIView alloc] init];
    _bottomCutLine.backgroundColor = colorFromRGBA(0x333333, 0.15);
    [self addSubview:_bottomCutLine];

}


-(void)layoutSubviews{
    
    //容器视图的高度
    CGFloat containerHeight = [self contentHeight];
    CGFloat fx = 0.0;
    CGFloat fy = 0.0;
    CGRect frame = CGRectZero;
    
    frame = _alphaBlackView.frame;
    frame.size = CGSizeMake(self.width, self.height - containerHeight);
    _alphaBlackView.frame = frame;
    MoveTo(_alphaBlackView, fx, fy);
    
    _topTitleLabel.text = self.title;
    [_topTitleLabel sizeToFit];
    fy = _alphaBlackView.bottom;
    frame = CGRectMake(fx, fy, self.width, kNormalHeight);
    _topTitleLabel.frame = frame;
    
    fy = _topTitleLabel.bottom;
    _topCutLine.frame = CGRectMake(fx, fy, self.width, kLineHeight);
    
    fy =   self.height - kNormalHeight;
    frame = _cancelButton.frame;
    frame.size = CGSizeMake(self.width, kNormalHeight);
    _cancelButton.frame = frame;
    MoveTo(_cancelButton, fx, fy);
    
    fy = _cancelButton.top - kLineHeight;
    _bottomCutLine.frame = CGRectMake(fx, fy, self.width, kLineHeight);
    
    frame = _subContainView.frame;
    fy = _topCutLine.bottom;
    frame.size = CGSizeMake(self.width, containerHeight - (kNormalHeight + kLineHeight) * 2);
    _subContainView.frame = frame;
    MoveTo(_subContainView, fx, fy);
    
    _blurView.frame = CGRectMake(0, self.height - containerHeight, self.width, containerHeight);
    [self sendSubviewToBack:_blurView];
    
    _topTitleLabel.hidden = self.hideTitle;
    _topCutLine.hidden = self.hideTitle;
}

#pragma mark --  tap and close actions
-(void)onTapped:(UITapGestureRecognizer*)tapGesturer{
     [self hidePopContainerWithAnimate:YES];
}

-(void)onClose{
    [self hidePopContainerWithAnimate:YES];
}


#pragma mark -- public show and hide methods
-(void)showSubView:(UIView*)view withAnimate:(BOOL)animate{
    _subContainView = view;
    
    //移动位置
    self.frame = self.superView.frame;
    MoveTo(self, 0, self.height);
    
    [self addSubview:_subContainView];
    [self.superView addSubview:self];
    
    CGFloat containHeight = [self contentHeight];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        _blurView = [[XMBlurView alloc]initWithFrame:CGRectMake(0, self.height - containHeight, self.width, containHeight) withEffect:BlurViewStyleExtraLight];
    }
    else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        _blurView = [[XMBlurView alloc]initWithFrame:CGRectMake(0, self.height - containHeight, self.width,containHeight) withEffect:BlurViewStyleDefault];
    }
    else {
        _blurView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - containHeight, self.width, containHeight)];
        _blurView.backgroundColor = [UIColor whiteColor];
    }
    _blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:_blurView];
    
    if (animate) {
        _alphaBlackView.alpha = 0.0;
        [UIView  animateWithDuration:0.3 animations:^{
            MoveTo(self, 0, 0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                _alphaBlackView.alpha = 1.0;
            }];
        }];
    }else{
        _alphaBlackView.alpha = 1.0;
        MoveTo(self, 0, 0);
    }
}

-(void)hidePopContainerWithAnimate:(BOOL)animate{
    if (animate) {
        [UIView animateWithDuration:0.15 animations:^{
            _alphaBlackView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3f animations:^{
                MoveTo(self, 0, self.height);
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                [_blurView removeFromSuperview];
                _blurView = nil;
            }];
        }];
    }else{
        _alphaBlackView.alpha = 0.0;
        MoveTo(self, 0, self.height);
        [self removeFromSuperview];
        [_blurView removeFromSuperview];
        _blurView = nil;
    }
}

#pragma mark -- content height
-(CGFloat)contentHeight{
    CGFloat subContentHeight = self.height * 5 / 7;
    if (self.autoSizeWithSubFrame) {
        if (self.hideTitle) {
            subContentHeight = _subContainView.height + kNormalHeight + kLineHeight;
        }else{
            subContentHeight = _subContainView.height + (kNormalHeight + kLineHeight) * 2;
        }
    }
    return subContentHeight;
}

@end
