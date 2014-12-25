//
//  ImageViewController.m
//  HW_CollectionView
//
//  Created by Айдар on 23.10.14.
//  Copyright (c) 2014 Айдар. All rights reserved.
//

#import "ImageViewController.h"
#import "MyNetManager.h"

@interface ImageViewController ()

@end

@implementation ImageViewController 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[MyNetManager sharedInstance] getAsyncImageWithURL:[NSURL URLWithString:_str] complection:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^(){
            _img.image = image;
        });
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
