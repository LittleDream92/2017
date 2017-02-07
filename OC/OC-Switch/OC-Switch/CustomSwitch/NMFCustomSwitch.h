//
//  NMFCustomSwitch.h
//  OC-Switch
//
//  Created by Meng Fan on 17/2/7.
//  Copyright © 2017年 Meng Fan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMFCustomSwitch : UISlider

@property(nonatomic,getter=isOn) BOOL on;
@property (nonatomic,retain) UIColor *tintColor;
@property (nonatomic,retain) UIView *clippingView;
@property (nonatomic,retain) UILabel *rightLabel;
@property (nonatomic,retain) UILabel *leftLabel;

+ (NMFCustomSwitch *) switchWithLeftText: (NSString *) tag1 andRight: (NSString *) tag2;

- (void)setOn:(BOOL)on animated:(BOOL)animated;


@end
