//
//  LEOAlbumViewController.m
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import "LEOAlbumViewController.h"
#import "LEOPicBrowserCollectionViewCell.h"
#import "LEOAlbumModel.h"
#import "LEOEmptyView.h"
#import "MBProgressHUD.h"
#import "constant.h"
#import "SDWebImageManager.h"

@interface LEOAlbumViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MBProgressHUDDelegate>
{
    NSMutableArray *_photos;
    NSUInteger _currentPage;
    
    long long expectedLength;
    long long currentLength;
}

@property (nonatomic, strong) MBProgressHUD *HUD;

@property (weak, nonatomic) IBOutlet LEOEmptyView *emptyView;
@property (nonatomic, strong) LEOAlbumModel *albumModel;

@property (nonatomic, weak) IBOutlet UIButton *backBtn;
@property (nonatomic, weak) IBOutlet UIButton *downloadBtn;
@property (nonatomic, weak) IBOutlet UIButton *collectionBtn;
@property (nonatomic, weak) IBOutlet UIButton *shareBtn;
- (IBAction)backAction:(id)sender;
- (IBAction)downloadAction:(id)sender;
- (IBAction)collectionAction:(id)sender;
- (IBAction)shareAction:(id)sender;

@end

@implementation LEOAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self startActivity];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:@"LEOPicBrowserCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:PicBrowserCollectionViewCellIdentify];
    
    _collectionView.bounces = NO;
    
    [self loadTestData];
    self.emptyView.loadViewType = LoadViewTypePicLoading;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _albumModel.albumItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LEOPicBrowserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PicBrowserCollectionViewCellIdentify forIndexPath:indexPath];
    [cell initCellWithModel:_albumModel.albumItems[indexPath.row] andCurrentPage:(indexPath.row+1) andTotalPages:_albumModel.albumItems.count];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.collectionView.frame.size;
}

#pragma mark -action

- (IBAction)backAction:(id)sender
{
    self.navigationController.navigationBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)downloadAction:(id)sender
{
    NSInteger currentIndex = _collectionView.contentOffset.x/kWidth;
    DLog(@"%ld",currentIndex);
    LEOAlbumItemModel *model = _albumModel.albumItems[currentIndex];
    
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.mode = MBProgressHUDModeDeterminate;
    _HUD.delegate = self;
    _HUD.labelText = @"下载中…";
    
    [self downLoadImg:model];
}

- (void)downLoadImg:(LEOAlbumItemModel *)model
{
    __weak typeof (self) weakSelf = self;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:[NSURL URLWithString:model.pictureHttpUrl] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        NSLog(@"receivedSize = %ld,expectedSize = %ld",receivedSize,expectedSize);
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (expectedSize > 0) {
            float progress = ((receivedSize/(float)expectedSize));
            DLog(@"%f",progress);
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.HUD.progress = progress;
            });
            
            if (receivedSize == expectedSize) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    strongSelf.HUD.progress = 1.0;
                });
            }
        }else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.HUD.progress = 0.0;
            });
        }
        NSLog(@"显示当前进度");
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.HUD.mode = MBProgressHUDModeIndeterminate;
        strongSelf.HUD.labelText = @"保存中…";
        UIImageWriteToSavedPhotosAlbum(image, strongSelf,
                                       @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [_HUD hide:YES];
    [self showToastMessage:@"保存成功" isSuccessToast:YES];
}

- (IBAction)collectionAction:(id)sender
{
    DLog(@"shou")
}
- (IBAction)shareAction:(id)sender
{
    DLog(@"分享")
}

#pragma mark -ScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    DLog(@"scrollViewDidEndDragging = %f",scrollView.contentOffset.x);
    if (scrollView.contentOffset.x <= 0.000001) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)loadTestData
{
    NSError *error;
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"album" ofType:@"json"]];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSDictionary *content = [dic objectForKeyNotNull:@"data"];
    LEOAlbumModel *albumModel = [[LEOAlbumModel alloc]initWithDic:content];
    
    
    
    [self stopActivity];
    _albumModel = albumModel;
    
    if(_albumModel.albumItems.count == 0)
    {
        self.emptyView.loadViewType = LoadViewTypePicFailure;
    }else
    {
        [_collectionView reloadData];
        self.emptyView.hidden = YES;
    }
}

@end
