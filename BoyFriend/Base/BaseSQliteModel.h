//
//  BaseSQliteModel.h
//  Demon
//
//  Created by apple on 2019/1/30.
//  Copyright © 2019年 BoyFriend. All rights reserved.
//

#import "BaseModel.h"
#import "LKDBHelper.h"

/*----  使用说明  ----
--保存--
AppCacheInfo *model  =[[AppCacheInfo alloc]init];
model.userProvinceCode=@"350000";
[model saveToDB];

--更新--
AppCacheInfo *model  =[[AppCacheInfo alloc]init];
model.userProvinceCode=@"350000";
[model updateToDB];

--删除--
删除整个表
[LKDBHelper clearTableData:[AppCacheInfo class]];
删除某条数据
BOOL flagIM= [AppCacheInfo deleteWithWhere:[NSString stringWithFormat:@"dialoguleId = '%@' and userId = '%@'",model.dialoguleId,[BFUserDefaults objectForKey:@"userId"]]];
--查找--
查找整个表
AppCacheInfo *entity = [AppCacheInfo searchSingleWithWhere:nil orderBy:nil];
查找具体某条数据
AppCacheInfo *tempModel=[AppCacheInfo searchSingleWithWhere:[NSString stringWithFormat:@"dialoguleId = '%@'and userId = '%@'",model.dialoguleId,[BFUserDefaults objectForKey:@"userId"]] orderBy:nil];

searchWithWhere:(id)where orderBy:(NSString *)orderBy offset:(NSInteger)offset count:(NSInteger)count
条件设置的格式处理。如：

where格式："name= 'zhang'"

orderBy格式：按名字升序 "name asc"，或按名字降序 "name desc"

offset格式：从第11个开始查找：10

count格式：只查找10个：10


3.5查操作(模糊查询根据名称查询内容)

+(NSMutableArray*)selectAllStorages:(NSString*)content

{

    NSString *likeContent = [NSString stringWithFormat:@"NAME like '%%%@%%'", content];

    return [QuickLookStorageModel searchWithWhere:likeContent];

}
*/

@interface BaseSQliteModel : BaseModel

@end
