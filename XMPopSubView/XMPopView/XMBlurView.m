//
//  XMBlurView.m
//
//  Created by will.xu on 16/4/25.
//
//

#import "XMBlurView.h"
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

const CGFloat  XMBlurViewDefaultBlurRadius = 25;
const CGFloat  XMBlurViewTintColorAlpha = 0.5;


@interface XMBlurView ()
{
    UIToolbar       *_toolBar;  // for iOS7 OR Later
    
    CALayer         *_tintLayer;
    
#ifdef __IPHONE_8_0
    UIVisualEffectView  *_effectView;
#endif
    
}
@end

@implementation XMBlurView
@synthesize viewStyle;
@synthesize backgroundColor;

- (void)dealloc
{
    _toolBar = nil;
    _tintLayer = nil;
    self.backgroundColor = nil;
    _effectView = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
        
#ifdef __IPHONE_8_0
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            
            [self setUpEffectView];
        }
        else {
#endif
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                [self setUpToolbar];
            }
            else {
                [self setUpLayer];
            }
            
#ifdef __IPHONE_8_0

        }
#endif

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withEffect:(XMBlurViewStyle )style
{
    self.viewStyle = style;
    
    return [self initWithFrame:frame];
}


- (void)setViewStyle:(XMBlurViewStyle)newStyle
{
    viewStyle  = newStyle;

#ifdef __IPHONE_8_0
    if (_effectView) {
        [_effectView removeFromSuperview];
        [self setUpEffectView];
    }
#endif
    
    if (_toolBar) {
        
        _toolBar.barStyle = (UIBarStyle)newStyle;
        
    }
}

- (void)setBackgroundColor:(UIColor *)newColor
{
    backgroundColor = newColor;
    
    if (_tintLayer) {
        _tintLayer.backgroundColor = newColor.CGColor;
    }
}

- (void)setUpEffectView
{
#ifdef __IPHONE_8_0
    
    if (nil == _effectView) {
        
        UIBlurEffectStyle style = UIBlurEffectStyleLight;
        if (BlurViewStyleDefault == viewStyle) {
            style = UIBlurEffectStyleLight;
        }
        else if(BlurViewStyleBlack == viewStyle) {
            style = UIBlurEffectStyleDark;
        }
        else if(BlurViewStyleExtraLight == viewStyle) {
            style = UIBlurEffectStyleExtraLight;
        }
        
        _effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:style]];
        _effectView.frame = self.bounds;
        [self insertSubview:_effectView atIndex:0];
    }
#endif
}

- (void)setUpToolbar
{
    if (nil == _toolBar) {
        
        _toolBar = [[UIToolbar alloc] initWithFrame:self.bounds];
        _toolBar.barStyle = (UIBarStyle)viewStyle;
        _toolBar.translucent = YES;
        [self insertSubview:_toolBar atIndex:0];
    }
}

- (void)setUpLayer
{
    if (nil == _tintLayer) {
        _tintLayer = [[CALayer alloc] init];
        _tintLayer.frame = self.bounds;
        _tintLayer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sr_bg_mask"]].CGColor;
        [self.layer insertSublayer:_tintLayer atIndex:0];
    }
}

- (void)showBlur:(BOOL)show
{
    
#ifdef __IPHONE_8_0
      _effectView.hidden = !show;
#endif
    
    _toolBar.hidden = !show;
    
    _tintLayer.hidden = !show;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
