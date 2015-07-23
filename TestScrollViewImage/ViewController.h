//
//  ViewController.h
//  TestScrollViewImage
//
//  Created by raykle on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>{
    CGFloat offset;
}

@property (nonatomic, retain) UIScrollView *imageScrollView;

- (CGRect)zoomRectForScale:(float)scale inView:(UIScrollView*)scrollView withCenter:(CGPoint)center;

@end
