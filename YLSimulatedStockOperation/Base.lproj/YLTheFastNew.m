//
//  YLTheFastNew.m
//  YLSimulatedStockOperation
//
//  Created by Waterstrong on 2/11/16.
//  Copyright © 2016 hoggenWang. All rights reserved.
//

#import "YLTheFastNew.h"
#import "YLFastNewsModel.h"
@implementation YLTheFastNew
-(NSArray*)requestDataTheFastNews{
    // 通过NSURLSessionConfiguration对象创建NSURLSession对象
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    // 通过指定的NSURL对象创建一个获取数据的任务
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
            if ([dict[@"code"] isEqualToString:@"do_success"]) {
                CDAlbum *model = [[CDAlbum alloc] init];
                model.albumId = [dict[@"albumid"] integerValue];
                model.albumName = name;
                model.pictureCount = 0;
                // 将模型对象放在装模型的数组中
                [dataArray insertObject:model atIndex:0];
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 回到主线程在表格视图中插入新行
                    [myTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
                });
            }
            else {
                NSLog(@"然并卵!!!");
            }
        }
        else {
            NSLog(@"%@", error);
        }
        
    }];
    // 执行任务
    [task resume];
    ｝
@end
