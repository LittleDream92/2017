//
//  ViewController.m
//  OC-Switch
//
//  Created by Meng Fan on 17/2/7.
//  Copyright © 2017年 Meng Fan. All rights reserved.
//

#import "ViewController.h"

//自定义的可以写字的switch
#import "NMFCustomSwitch.h"

@interface ViewController ()

//switch控件
//1. create a property of type UISwitch
@property (nonatomic, strong) UISwitch *mainSwitch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self systemSwitch];
    [self customSwitch];
    [self customSwitch2];
    
}

#pragma mark - 系统switch
- (void)systemSwitch {
    //2. create switch
    self.mainSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(100, 70, 0, 0)];
    [self.view addSubview:self.mainSwitch];
    
    //缩小或者放大switch的size
    self.mainSwitch.transform = CGAffineTransformMakeScale(0.5, 0.5);
    self.mainSwitch.layer.anchorPoint = CGPointMake(0, 0.3);
    
//    self.mainSwitch.onImage = [UIImage imageNamed:@"on.png"];   //无效
//    self.mainSwitch.offImage = [UIImage imageNamed:@"off.png"]; //无效
    
//    self.mainSwitch.backgroundColor = [UIColor yellowColor];    //设置背景颜色之后才发现原来它是矩形的
    
    // 设置开关状态(默认是 关)
//    self.mainSwitch.on = YES;
    [self.mainSwitch setOn:YES animated:true];  //animated
    
    //判断开关的状态
    if (self.mainSwitch.on) {
        NSLog(@"switch is on");
    } else {
        NSLog(@"switch is off");
    }
    
    //添加事件监听
    [self.mainSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    //定制开关颜色UI
    //tintColor 关状态下的背景颜色
    self.mainSwitch.tintColor = [UIColor redColor];
    //onTintColor 开状态下的背景颜色
    self.mainSwitch.onTintColor = [UIColor yellowColor];
    //thumbTintColor 滑块的背景颜色
    self.mainSwitch.thumbTintColor = [UIColor blueColor];
    
}

- (void)switchAction:(UISwitch *)sender {
    NSLog(@"switch value changed");
    
    if (sender.on) {
        NSLog(@"switch is on");
    } else {
        NSLog(@"switch is off");
    }
}

#pragma mark - 自定义 文字 switch
- (void)customSwitch {
    // Standard ON/OFF
    NMFCustomSwitch *switchView = [[NMFCustomSwitch alloc] initWithFrame:CGRectZero];
    switchView.center = CGPointMake(160.0f, 200.0f);
    [switchView addTarget:self action:@selector(switchFlipped:) forControlEvents:UIControlEventValueChanged];
    switchView.on = YES;
    [self.view addSubview:switchView];
    
    // Custom YES/NO
    switchView = [NMFCustomSwitch switchWithLeftText:@"YES" andRight:@"NO"];
    switchView.center = CGPointMake(160.0f, 250.0f);
    switchView.on = YES;
    [self.view addSubview:switchView];
    
    // Custom font and color
    switchView = [NMFCustomSwitch switchWithLeftText:@"Hello " andRight:@"ABC "];
    switchView.center = CGPointMake(160.0f, 300.0f);
    switchView.on = YES;
    [switchView.leftLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [switchView.rightLabel setFont:[UIFont italicSystemFontOfSize:15.0f]];
    [switchView.rightLabel setTextColor:[UIColor blueColor]];
    [self.view addSubview:switchView];
    
    // Multiple lines
    switchView = [NMFCustomSwitch switchWithLeftText:@"Hello\nWorld" andRight:@"Bye\nWorld"];
    switchView.center = CGPointMake(160.0f, 350.0f);
    switchView.on = YES;
    switchView.tintColor = [UIColor orangeColor];
    switchView.leftLabel.font = [UIFont boldSystemFontOfSize:9.0f];
    switchView.rightLabel.font = [UIFont boldSystemFontOfSize:9.0f];
    switchView.leftLabel.numberOfLines = 2;
    switchView.rightLabel.numberOfLines = 2;
    switchView.leftLabel.lineBreakMode = NSLineBreakByWordWrapping;
    switchView.rightLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:switchView];
    
    switchView = [[NMFCustomSwitch alloc] init];
    switchView.center = CGPointMake(160.0f, 400.0f);
    switchView.on = YES;
    switchView.tintColor = [UIColor purpleColor];
    [self.view addSubview:switchView];
    
    switchView = [NMFCustomSwitch switchWithLeftText:@"l" andRight:@"O"];
    switchView.center = CGPointMake(160.0f, 450.0f);
    switchView.tintColor = [UIColor colorWithRed:125.f/255.f green:157.f/255.f blue:93.f/255.f alpha:1.0];
    switchView.tintColor = [UIColor colorWithRed:125.f/255.f green:157.f/255.f blue:93.f/255.f alpha:1.0];
    [self.view addSubview:switchView];
    
}

-(void)switchFlipped:(NMFCustomSwitch *)switchView {
    
    NSLog(@"switchFlipped=%f  on:%@",switchView.value, (switchView.on?@"Y":@"N"));
    
}

#pragma mark - customSwitch2
- (void)customSwitch2 {
    
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
