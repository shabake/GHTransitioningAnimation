//
//  ViewController.m
//  GHTransitioningAnimation
//
//  Created by mac on 2018/12/5.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import "ViewController.h"
#import "GHCrossFromViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *types;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    self.types = [NSMutableArray arrayWithObjects:@"淡入淡出", nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.types.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    NSString *type = self.types[indexPath.row];
    cell.textLabel.text = type;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
            
        case 0:
            [self jumpCross];
            break;
            
        default:
            break;
    }
}
- (void)jumpCross {
    GHCrossFromViewController *crossFromVc = [GHCrossFromViewController new];
    [self.navigationController pushViewController:crossFromVc animated:YES];
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellID"];
    }
    return _tableView;
}

- (NSMutableArray *)types {
    if (_types == nil) {
        _types = [NSMutableArray array];
    }
    return _types;
}
@end
