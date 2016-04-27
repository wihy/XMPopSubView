//
//  XMBlurView.h
//
//  Created by will.xu on 16/4/25.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    BlurViewStyleDefault            = 0, //Light
    BlurViewStyleBlack              = 1, //Dark
    
#ifdef __IPHONE_8_0
    BlurViewStyleExtraLight         // for iOS8 UIBlurEffectStyleExtraLight
#endif
    
} XMBlurViewStyle;

@interface XMBlurView : UIView

@property   (nonatomic, assign)        XMBlurViewStyle viewStyle;

@property   (nonatomic, retain)        UIColor         *backgroundColor; //for iOS6.0 or before no blur effect

- (void)showBlur:(BOOL)show;

- (id)initWithFrame:(CGRect)frame withEffect:(XMBlurViewStyle)style;

@end
