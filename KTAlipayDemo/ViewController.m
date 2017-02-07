//
//  ViewController.m
//  KTAlipayDemo
//
//  Created by kirito_song on 17/2/6.
//  Copyright © 2017年 kirito_song. All rights reserved.
//

#import "ViewController.h"
#import "RefreshHeaader.h"

#define SCREEN_HEIGHT                      [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                       [UIScreen mainScreen].bounds.size.width
#define SCALE_6                                                   (SCREEN_WIDTH / 375)

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

/* 展示用topView */
@property (nonatomic) UIView * topView;

@property (nonatomic) UITableView *tableView;

/* 刷新效果的view */
@property (nonatomic) RefreshHeaader * refreshHeaaderView;
@end

@implementation ViewController


/*************** core code ***************/
- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.view addSubview:self.tableView];
    /* 这里。展示用的topView需要添加在tableView上。不然导致在topView上面上下滑动的时候无法与tableView联动 */
    [self.tableView addSubview:self.topView];
    [self.tableView reloadData];
}

#pragma mark - delegate
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat tableViewoffsetY = scrollView.contentOffset.y;
    /* topView联动 */
    if ( tableViewoffsetY>=-64) {
        self.topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
        
    }else if( tableViewoffsetY < -64){
        
        self.topView.frame = CGRectMake(0, 64 + tableViewoffsetY, SCREEN_WIDTH, 200);
        
    }
    
    /* 刷新用 */
    if (tableViewoffsetY > -64.0f) {
        self.refreshHeaaderView.type = typeNull;
    }else if (tableViewoffsetY > - 125.0f){
        self.refreshHeaaderView.type = typeWillRefresh;
    }else {
        self.refreshHeaaderView.type = typeRefreshing;
    }
}

#pragma mark - setter && getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        
        /* 这里用一个透明的view将header撑开 */
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        tableHeaderView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = tableHeaderView;
        /* 修改scrollIndicatorInsets。仿造出tableView从下方开始的效果 */
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(200, 0, 0, 0);
        /* 再在header下方安装一个刷新用的view */
        [_tableView.tableHeaderView addSubview:self.refreshHeaaderView];
    }
    return _tableView;
}

/**************** end ****************/







#pragma mark - 下面就没啥好写的了。都是些正常的东西

- (RefreshHeaader *)refreshHeaaderView {
    if (!_refreshHeaaderView) {
        _refreshHeaaderView  = [[RefreshHeaader alloc] init];
        _refreshHeaaderView.frame = CGRectMake(0, 150, SCREEN_WIDTH, 50);
    }
    return _refreshHeaaderView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _topView.backgroundColor = [UIColor clearColor];
        
        
        UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 200)];
        [btn1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn1.backgroundColor = [UIColor orangeColor];
        UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 200)];
        [btn2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        btn2.backgroundColor = [UIColor blueColor];
        
        [_topView addSubview:btn1];
        [_topView addSubview:btn2];
    }
    return _topView;
}

- (void)buttonAction:(UIButton *)btn {
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    btn.backgroundColor =[UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];

}


#pragma mark  UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [UITableViewCell new];
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    cell.backgroundColor =[UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.frame;
}

@end
