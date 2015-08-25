//
//  SETCollectionViewCell.h
//  SETCollectionView
//
//  Created by 蔡繼東 on 2015/8/25.
//  Copyright (c) 2015年 蔡繼東. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SETCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *artist;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *cover;

@end
