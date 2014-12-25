//
//  MyNetManager.m
//  HW_CollectionView
//
//  Created by Айдар on 27.10.14.
//  Copyright (c) 2014 Айдар. All rights reserved.
//

#import "MyNetManager.h"

@interface MyNetManager ()
{
    NSMutableDictionary *pages;
    NSURL *baseURL;
    NSURLSession *jsonLoadSession;
}
@property (strong, nonatomic) NSOperationQueue *queue;

@end

@implementation MyNetManager

+ (instancetype)sharedInstance
{
    static MyNetManager *net;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(){
        net = [MyNetManager new];
        net.queue = [NSOperationQueue new];
    });
    return net;
}

- (NSData *)getImagesInfo
{
    NSURL *url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/u/55523423/Nature/0.json"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    return data;
}

- (void)getAsyncImageWithURL:(NSURL*)url complection:(void(^)(UIImage* image))complection
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [NSURLConnection sendAsynchronousRequest:request queue:_queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        complection([UIImage imageWithData:data]);
    }];
}

- (UIImage *)getSyncImageWithURL:(NSURL*)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

@end
