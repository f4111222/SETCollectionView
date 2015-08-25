//
//  ViewController.h
//  SETCollectionView
//
//  Created by 蔡繼東 on 2015/8/25.
//  Copyright (c) 2015年 蔡繼東. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIToolbarDelegate, UINavigationControllerDelegate>{
    NSMutableData *responseData;
    NSMutableArray *jarray;
}

@property (nonatomic, strong) IBOutlet UICollectionView *collectView;


@end

