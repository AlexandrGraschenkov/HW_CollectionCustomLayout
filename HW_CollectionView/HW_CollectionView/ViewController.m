//
//  ViewController.m
//  HW_CollectionView
//
//  Created by Айдар on 23.10.14.
//  Copyright (c) 2014 Айдар. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"
#import "MyNetManager.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableArray *dataArr;
    UICollectionViewFlowLayout *flowLayout;
    NSArray *urls;
}
@property (nonatomic, weak) IBOutlet UICollectionView *collection;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyNetManager *mnm = [MyNetManager sharedInstance];
    NSData *data = [mnm getImagesInfo];
    NSDictionary  *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: nil];
    urls = [json objectForKey:@"images"];
    dataArr = [NSMutableArray new];
    for (int i = 0; i < urls.count/5; i++) {
        NSMutableArray *sectionArr = [NSMutableArray new];
        for (int itemIdx = 0; itemIdx < 5; itemIdx++) {
            NSString *imageName = urls[i*5+itemIdx];
            [sectionArr addObject:imageName];
        }
        [dataArr addObject:sectionArr];
    }
    flowLayout = (id)self.collection.collectionViewLayout;
}

#pragma mark - Collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [dataArr[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    UIImageView *imgView = (id)[cell viewWithTag:1];
    NSURL *url = [NSURL URLWithString:dataArr[indexPath.section][indexPath.item]];
    [[MyNetManager sharedInstance] getAsyncImageWithURL:url complection:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^(){
            imgView.image = image;
        });
    }];
    NSLog(@"%@",dataArr[indexPath.section][indexPath.item]);
    cell.layer.zPosition = [collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath].zIndex;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ImageViewController *image = [segue destinationViewController];
    NSString *str = [[[self.collection.indexPathsForSelectedItems description] componentsSeparatedByCharactersInSet:
                            [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                           componentsJoinedByString:@""];
    NSString *str1 = [str substringFromIndex: [str length] - 2];
    int a = (int)[str1 characterAtIndex:0]-'0';
    int b = (int)[str1 characterAtIndex:1]-'0';
    NSLog(@"dataArr - %d %d --- %@",a,b, dataArr[a][b]);
    image.str = dataArr[a][b];
}

@end
