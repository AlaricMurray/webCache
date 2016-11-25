//
//  RootViewController.m
//  网络缓存
//
//  Created by MyMac on 2016/11/11.
//  Copyright © 2016年 hengshuimofangkeji. All rights reserved.
//

#import "RootViewController.h"
#import "MyRequest.h"
#import "JsonModel.h"
#import "MyCell.h"
@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , weak)UITableView * tableView;
@property (nonatomic , strong)NSMutableArray * dataArray;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView = tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    [MyRequest GET:@"http://www.zimozibao.com:8080/zimoAppWS/cxf/rest/kecheng/getallKecheng?_type=json&index=1&size=20" CacheTime:0 isLoadingView:nil success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        NSArray * array = jsonDic[@"data"];
        for (NSDictionary * dict in array) {
            JsonModel * model = [[JsonModel alloc]init];
            model.kcjssj = dict[@"kcjssj"];
            model.kclxmc = dict[@"kclxmc"];
            model.kcsm = dict[@"kcsm"];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        
    }];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * iden = @"mycell";
    MyCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyCell" owner:nil options:nil] lastObject];
    }
    JsonModel * model = _dataArray[indexPath.row];
    cell.titleLabel.text = model.kclxmc;
    cell.descLabel.text = model.kcsm;
    cell.dateLabel.text = model.kcjssj;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
