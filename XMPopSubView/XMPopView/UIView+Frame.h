//
//  UIView+Frame.h
//
//  Created by will.xu on 16/4/25.
//
//

#import <UIKit/UIKit.h>

#define MoveTo(view, x, y)          view.frame = CGRectMake(x, y, view.frame.size.width, view.frame.size.height)

@interface UIView (Frame)

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;


- (CGFloat)topCenterWith:(UIView *)v;

@end
