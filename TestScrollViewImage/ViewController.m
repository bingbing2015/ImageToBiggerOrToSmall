//
//  ViewController.m
//  TestScrollViewImage
//
//  Created by raykle on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#define PHOTONUMBERS 5  //照片数量
@interface ViewController ()

@end

@implementation ViewController

@synthesize imageScrollView;

#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    offset = 0.0;
    
    self.imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    self.imageScrollView.backgroundColor = [UIColor clearColor];
    self.imageScrollView.scrollEnabled = YES;
    self.imageScrollView.pagingEnabled = YES;
    self.imageScrollView.delegate = self;
    self.imageScrollView.contentSize = CGSizeMake(320*PHOTONUMBERS, 460);
    
    for (int i = 0; i<PHOTONUMBERS; i++){
        UITapGestureRecognizer *doubleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        [doubleTap setNumberOfTapsRequired:2];
        
        UIScrollView *s = [[UIScrollView alloc] initWithFrame:CGRectMake(320*i, 0, 320, 460)];
        s.backgroundColor = [UIColor clearColor];
        s.contentSize = CGSizeMake(320, 460);
        s.delegate = self;
        s.minimumZoomScale = 1.0;
        s.maximumZoomScale = 3.0;
//        s.tag = i+1;
        [s setZoomScale:1.0];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg",i%2];
        imageview.image = [UIImage imageNamed:imageName];
        imageview.userInteractionEnabled = YES;
        imageview.tag = i+1;
        [imageview addGestureRecognizer:doubleTap];
        [s addSubview:imageview];
        [self.imageScrollView addSubview:s];
        
        [doubleTap release];
        [imageview release];
        [s release];
    }
    
    [self.view addSubview:self.imageScrollView];
}

#pragma mark - ScrollView delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    for (UIView *v in scrollView.subviews){
        return v;
    }
    return nil;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.imageScrollView){
        CGFloat x = scrollView.contentOffset.x;
        if (x==offset){

        }
        else {
            offset = x;
            for (UIScrollView *s in scrollView.subviews){
                if ([s isKindOfClass:[UIScrollView class]]){
                    [s setZoomScale:1.0];
                }
            }
        }
    }
}

//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
//    [scrollView setZoomScale:scale+1.0 animated:YES];
//    [scrollView setZoomScale:scale animated:YES];
//}
#pragma mark -
-(void)handleDoubleTap:(UIGestureRecognizer *)gesture{
    
    float newScale = [(UIScrollView*)gesture.view.superview zoomScale] * 1.5;
    CGRect zoomRect = [self zoomRectForScale:newScale  inView:(UIScrollView*)gesture.view.superview withCenter:[gesture locationInView:gesture.view]];
    [(UIScrollView*)gesture.view.superview zoomToRect:zoomRect animated:YES];
}

#pragma mark - Utility methods

- (CGRect)zoomRectForScale:(float)scale inView:(UIScrollView*)scrollView withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    zoomRect.size.height = [scrollView frame].size.height / scale;
    zoomRect.size.width  = [scrollView frame].size.width  / scale;
    
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

@end
