//
//  XMPopSubview.m
//
//  Created by will.xu on 16/4/25.
//

#import "XMPopSubview.h"
#import "XMPopViewContainer.h"

@interface XMPopSubview ()

@property(nonatomic,retain) XMPopViewContainer *popContainer;

@end


@implementation XMPopSubview
- (void)dealloc
{
    _popContainer = nil;
}


-(instancetype)initWithController:(UIViewController*)ctrl title:(NSString*)title{
    if (self = [super init]) {
        self.popContainer = [[XMPopViewContainer alloc] initWithSuperView:ctrl.view title:title];
        self.hideTitle = NO;
        self.autoSizeWithSubFrame = NO;
    }
    return self;
}
-(void)showWithAnimate:(BOOL)animate{
     self.popContainer.hideTitle = self.hideTitle;
     self.popContainer.autoSizeWithSubFrame = self.autoSizeWithSubFrame;
    [self.popContainer showSubView:self withAnimate:animate];
}
-(void)hideWithAnimate:(BOOL)animate{
    [self.popContainer hidePopContainerWithAnimate:animate];
}

@end
