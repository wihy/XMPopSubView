//
//  XMPopSubview.h
//
//  Created by will.xu on 16/4/25.
//

#import <UIKit/UIKit.h>
#import "UIView+Frame.h"

@interface XMPopSubview : UIView

@property (nonatomic,assign) BOOL autoSizeWithSubFrame;//defaut NO
@property (nonatomic,assign) BOOL hideTitle;

-(instancetype)initWithController:(UIViewController*)ctrl title:(NSString*)title ;
-(void)showWithAnimate:(BOOL)animate;
-(void)hideWithAnimate:(BOOL)animate;

@end
