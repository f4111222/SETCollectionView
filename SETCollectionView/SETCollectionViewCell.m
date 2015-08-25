//
//  SETCollectionViewCell.m
//  SETCollectionView
//
//  Created by 蔡繼東 on 2015/8/25.
//  Copyright (c) 2015年 蔡繼東. All rights reserved.
//

#import "SETCollectionViewCell.h"

@implementation SETCollectionViewCell

@synthesize name, cover, artist;

- (void)awakeFromNib {
    // Initialization code
}

-(id) initWithFrame:(CGRect)frame{
    
    if (self) {
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"SETCollectionViewCell" owner:self options:nil];
        if (arrayOfViews.count < 1) return  nil;
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) return nil;
        
        self = [arrayOfViews objectAtIndex:0];
        name.lineBreakMode = NSLineBreakByWordWrapping;
        name.numberOfLines = 0;
        name.textColor = [UIColor whiteColor];
        CGRect bound = artist.bounds;
        bound.origin.y = name.frame.size.height + name.frame.origin.y;
        [artist setFrame:bound];
        [artist setNumberOfLines:0];
        
        
    }
    
    return self;
}

@end
