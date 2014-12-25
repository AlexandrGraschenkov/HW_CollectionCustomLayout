//
//  MyNetManager.h
//  HW_CollectionView
//
//  Created by Айдар on 27.10.14.
//  Copyright (c) 2014 Айдар. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyNetManager : NSObject

+ (instancetype)sharedInstance;

- (NSData *)getImagesInfo;

- (void)getAsyncImageWithURL:(NSURL*)url complection:(void(^)(UIImage* image))complection;

- (UIImage *)getSyncImageWithURL:(NSURL*)url;

@end
