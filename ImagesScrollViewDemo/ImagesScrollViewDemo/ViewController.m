//
//  ViewController.m
//  ImagesScrollViewDemo
//
//  Created by Liu on 14/11/10.
//  Copyright (c) 2014年 Wealtree. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) NSArray *imagesArray;

@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) NSInteger page;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.imagesArray = @[@"1.png", @"2.png", @"3.png"];
    
    for (NSInteger i = 0; i < self.imagesArray.count + 2; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(320*i, 0, 320, self.imageSC.bounds.size.height)];
        [self.imageSC addSubview:imageView];
        
        if (i == 0) {
            imageView.image = [UIImage imageNamed:[self.imagesArray objectAtIndex:self.imagesArray.count - 1]];
        }
        else if (i == self.imagesArray.count + 1) {
            imageView.image = [UIImage imageNamed:[self.imagesArray objectAtIndex:0]];
        }
        else {
            imageView.image = [UIImage imageNamed:[self.imagesArray objectAtIndex:i - 1]];
        }
    }
    
    self.pageControl.currentPage = 0;
    self.imageSC.contentSize = CGSizeMake(320*(self.imagesArray.count + 2), self.imageSC.bounds.size.height);
    
    self.page = 0;
    self.pageControl.currentPage = self.page;
    [self.imageSC scrollRectToVisible:CGRectMake(320, 0, 320, self.imageSC.bounds.size.height) animated:NO];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
}

- (void)changeImage
{
    self.page ++;
    if (self.page == self.imagesArray.count) {
        self.page = 0;
        [self.imageSC scrollRectToVisible:CGRectMake(0, 0, 320, self.imageSC.bounds.size.height) animated:NO];
    }
    self.pageControl.currentPage = self.page;
    [self.imageSC scrollRectToVisible:CGRectMake(320*(self.page+1), 0, 320, self.imageSC.bounds.size.height) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x/320;
    if (index == 0) {
        self.pageControl.currentPage = 3;
        [self.imageSC scrollRectToVisible:CGRectMake(320*3, 0, 320, self.imageSC.bounds.size.height) animated:NO];
    }
    else if (index == 4) {
        self.pageControl.currentPage = 0;
        [self.imageSC scrollRectToVisible:CGRectMake(320, 0, 320, self.imageSC.bounds.size.height) animated:NO];
    }
    else {
        self.pageControl.currentPage = index - 1;
    }
    self.page = self.pageControl.currentPage;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer = nil;
}


@end
