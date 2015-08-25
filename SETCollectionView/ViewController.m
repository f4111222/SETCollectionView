//
//  ViewController.m
//  SETCollectionView
//
//  Created by 蔡繼東 on 2015/8/25.
//  Copyright (c) 2015年 蔡繼東. All rights reserved.
//

#import "ViewController.h"
#import "SETCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize collectView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    self.view.backgroundColor = [UIColor blackColor];
    responseData = [NSMutableData data];
    NSString *URL =[NSString stringWithFormat:@"https://itunes.apple.com/tw/rss/topalbums/limit=20/json"] ;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    NSURLConnection *con =[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [con start];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{

    [collectView registerClass:[SETCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    collectView.dataSource = self;
    collectView.delegate = self;
    collectView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:collectView];
    [super viewWillAppear:animated];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [jarray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SETCollectionViewCell *cell = (SETCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    //get img url & replace the img url to fit the size
    NSString *str = [[[[jarray objectAtIndex:indexPath.row] objectForKey:@"im:image"] objectAtIndex:0] objectForKey:@"label"];
    str = [str stringByReplacingOccurrencesOfString:@"55x55"
                                         withString:[NSString stringWithFormat:@"%ix%i",(int)self.view.frame.size.width,(int)self.view.frame.size.width]];
    NSURL *imgURL = [NSURL URLWithString:str];
    
    //set cell data - img, artist, cover name
    [cell.cover sd_setImageWithURL:imgURL placeholderImage:nil];
    cell.artist.text =[[[jarray objectAtIndex:indexPath.row] objectForKey:@"im:artist"] objectForKey:@"label"];
    cell.name.text = [[[jarray objectAtIndex:indexPath.row] objectForKey:@"im:name"] objectForKey:@"label"];
    return cell;
}

#pragma mark <UICollectionViewDelegate>


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark --UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.width);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,0,0,0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0;
}

#pragma mark - Connection Delegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [responseData setLength:0];
}

//recevive new data
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [responseData appendData:data];
}

//finish
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSError *error = nil;
    jarray =[[[NSJSONSerialization JSONObjectWithData: responseData options: NSJSONReadingMutableContainers error: &error] objectForKey:@"feed"] objectForKey:@"entry"] ;
    [collectView reloadData];
}

//error
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error - %@ %@",[error localizedDescription], [[error userInfo] objectForKeyedSubscript:NSURLErrorFailingURLErrorKey]);
}

@end
