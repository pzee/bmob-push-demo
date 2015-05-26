//
//  ViewController.m
//  PushDemo
//
//  Created by px on 15/5/25.
//  Copyright (c) 2015年 unknown. All rights reserved.
//

#import "ViewController.h"
#import <BmobSDK/Bmob.h>
#import "GetPropertyUtil.h"
#import "Test.h"


@interface ViewController ()

@property(nonatomic , strong)NSMutableArray *dataArray;
@property(nonatomic , strong)NSDateFormatter *dateFormatter;
@end

@implementation ViewController
@synthesize dataArray = _dataArray;
@synthesize dateFormatter = _dateFormatter;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"推送Demo";
    [self initVar];
    self.tableView.dataSource = self;
    self.tableView.delegate  = self;
    
    Test *test = [[Test alloc] init];
    test.title = @"title1";
//    test.name = @"name1";
    
    
    Test *test1 = [[Test alloc] init];
    test1.title = @"title2";
    test1.name = @"name2";

    NSLog(@"test %@",[GetPropertyUtil classPropsFor:[test class]]);
    NSLog(@"test %@",[GetPropertyUtil classPropsFor:[test1 class]]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)initVar{
    _dataArray = [[NSMutableArray alloc] initWithArray:@[@"推送给单个设备"]];
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.dataArray[ indexPath.row]];
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            [self pushToOneAppleDevice];
        }
            
            break;
            
        default:
            break;
    }
}


#pragma mark - push method

-(void)pushToOneAppleDevice{
    BmobPush *push = [BmobPush push];
    BmobQuery *query = [BmobInstallation query];
    [query whereKey:@"deviceToken" equalTo:@""];
    
    NSString *dateString = [self.dateFormatter stringFromDate:[NSDate date]];
    NSString *alertString = [NSString stringWithFormat:@"push test time %@",dateString];
    NSDictionary *pushContentDic = @{@"aps":@{@"alert":alertString,@"sound":@"default",@"badge":@1}};
    [push setQuery:query];
    [push setData:pushContentDic];
    [push sendPushInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (error) {
            NSLog(@"push error %@",error.description);
        }else{
            NSLog(@"push successfully ,time %@",dateString);
        }
    }];

}

@end
