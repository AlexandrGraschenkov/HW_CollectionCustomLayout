//
//  ViewController.m
//  HW_CollectionView
//
//  Created by Айдар on 23.10.14.
//  Copyright (c) 2014 Айдар. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableArray *dataArr;
    UICollectionViewFlowLayout *flowLayout;
}
@property (nonatomic, weak) IBOutlet UICollectionView *collection;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArr = [NSMutableArray new];
    for (int i = 0; i < 8; i++) {
        NSMutableArray *sectionArr = [NSMutableArray new];
        for (int itemIdx = 0; itemIdx < 5; itemIdx++) {
            NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i * 5 + itemIdx + 1];
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
    NSLog(@"%d",dataArr.count);
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    UIImageView *imgView = (id)[cell viewWithTag:1];
    imgView.image = [UIImage imageNamed:dataArr[indexPath.section][indexPath.item]];
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
