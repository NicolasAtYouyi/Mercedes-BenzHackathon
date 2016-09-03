//
//  HomePreViewFlowLayout.m
//  YouYi
//
//  Created by Nicolas on 16/4/9.
//  Copyright © 2016年 Nicolas. All rights reserved.
//

#import "HomePreViewFlowLayout.h"


@interface HomePreViewFlowLayout () {
    
    CGFloat _viewWidth;
    CGFloat _itemWidth;
    CGFloat _margin;
}

@property (nonatomic, assign) NSInteger visibleCount;
@property (nonatomic, assign) CGFloat middleIndex;

@end

@implementation HomePreViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _viewWidth = CGRectGetWidth(self.collectionView.frame);
    _itemWidth = self.itemSize.width;
    _margin = (_viewWidth - _itemWidth) / 2;
    
    self.itemSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame) - itemWidthMargin / 2, CGRectGetHeight(self.collectionView.frame) - 40);
    
    self.collectionView.contentInset = UIEdgeInsetsMake(0, _margin, 0, _margin);
    self.visibleCount = 3;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    CGFloat centerX = self.collectionView.contentOffset.x + _viewWidth / 2;
    NSInteger index = centerX / _itemWidth;
    NSInteger count = (self.visibleCount - 1) / 2;
    NSInteger minIndex = MAX(0, (index - count));
    NSInteger maxIndex = MIN((cellCount - 1), (index + count));
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSInteger i = minIndex; i <= maxIndex; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [array addObject:attributes];
        
        CGFloat middle = (minIndex + maxIndex) / 2.;
        
        
//        float collectionViewHalfFrame = self.collectionView.frame.size.width / 2.0;
//        CGFloat distance = CGRectGetMidX(visibleRect) - layoutAttributes.center.x;
//        CGFloat normalizedDistance = distance / collectionViewHalfFrame;
        
    
        if (self.middleIndex == middle) {
            
        } else {
            //改变文字
            self.middleIndex = middle;
            
            NSInteger index = middle;
            if (maxIndex - minIndex == 1) {
                if (maxIndex == [self.collectionView numberOfItemsInSection:0] - 1) {
                    index = maxIndex;
//                    NSLog(@"max");
                } else {
                    index = minIndex;
//                    NSLog(@"min");
                }
            }
            
            
//            if (ABS(distance) < collectionViewHalfFrame) {
//                
//                CGFloat alpha = (1  - ABS(normalizedDistance)) + 0.1;
//                if (alpha > 1.0f) alpha = 1.0f;
//                layoutAttributes.alpha = alpha;
//            }else {
//                layoutAttributes.alpha = 0.0f;
//            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changText" object:@{@"index" : [NSString stringWithFormat:@"%ld", index]}];
        }
    }
    
#warning 改变旁边两个的view透明度
    
    return array;
}

/*
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* attributes = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    float collectionViewHalfFrame = self.collectionView.frame.size.width / 2.0;
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in attributes) {
        
        if (CGRectIntersectsRect(layoutAttributes.frame, rect)) {
            
            CGFloat distance = CGRectGetMidX(visibleRect) - layoutAttributes.center.x;
            CGFloat normalizedDistance = distance / collectionViewHalfFrame;
            
            if (ABS(distance) < collectionViewHalfFrame) {
                CGFloat zoom = 1 + ZOOM_FACTOR*(1- ABS(normalizedDistance));
                CATransform3D rotationTransform = CATransform3DIdentity;
                rotationTransform = CATransform3DMakeRotation(normalizedDistance * M_PI_2 *0.8, 0.0f, 0.0f, 0.0f);
                CATransform3D zoomTransform = CATransform3DMakeScale(zoom, zoom, 1.0);
                layoutAttributes.transform3D = CATransform3DConcat(zoomTransform, rotationTransform);
                layoutAttributes.zIndex = ABS(normalizedDistance) * 10.0f;
                
                
                CGFloat alpha = (1  - ABS(normalizedDistance)) + 0.1;
                if (alpha > 1.0f) alpha = 1.0f;
                layoutAttributes.alpha = alpha;
            }else {
                layoutAttributes.alpha = 0.0f;
            }
        }
    }
    
    return attributes;
}
*/

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = self.itemSize;
    
    CGFloat cX = self.collectionView.contentOffset.x + _viewWidth / 2;
    CGFloat attributesX = _itemWidth * indexPath.row + _itemWidth / 2;
    attributes.zIndex = -ABS(attributesX - cX);
    
    CGFloat delta = cX - attributesX;
    CGFloat ratio = - delta / (_itemWidth * 2);
    CGFloat scale = 1 - ABS(delta) / (_itemWidth * 3.0) * cos(ratio * M_PI_4) / 3;
    
    attributes.transform = CGAffineTransformMakeScale(scale * 1.1, scale * 1.1);
    CGFloat centerX = attributesX;
    attributes.center = CGPointMake(centerX, CGRectGetHeight(self.collectionView.frame) / 2);
    
    return attributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    CGFloat index = roundf((proposedContentOffset.x + _viewWidth / 2 - _itemWidth / 2) / _itemWidth);
    proposedContentOffset.x = _itemWidth * index + _itemWidth / 2 - _viewWidth / 2;
    
    return proposedContentOffset;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
    
    //    return !CGRectEqualToRect(newBounds, self.collectionView.bounds);
}


@end

