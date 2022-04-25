//
//  BaseViewModel.m
//  Demon
//
//  Created by BoyFriend on 2017/8/23.
//  Copyright © 2017年 BoyFriend. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

-(void)showLoading:(BOOL)isWindow Message:(NSString *)message{
    BFBlock_Safe_Calls(self.showLoadingBlock,isWindow,message);
}

-(void)showMessage:(BOOL)isWindow Message:(NSString *)message{
    BFBlock_Safe_Calls(self.showMessageBlock,isWindow,message);
}

-(void)showMessageInView:(NSString *)message{
    BFBlock_Safe_Calls(self.showMessageBlock,NO,message);
}
- (void)hideHUD{
    BFBlock_Safe_Calls(self.hideHUDBlock);
}

#pragma mark - response handler（统一错误处理，统一返回值处理）
- (void)handleResponse:(id)responseObject
                  resp:(Class)ObjType
            completion:(void (^)(BOOL success,BaseResponseData * respData))completion{
    @try {
        id resultData = [responseObject mj_JSONObject];
        BaseResponseData *result = [[BaseResponseData alloc]init];
        HandleModel *handModel = [HandleModel mj_objectWithKeyValues:resultData];
        result.code = [NSString stringWithFormat:@"%@",handModel.code];
        
        //所有的数据全部进行模型转换
        id jsonObject = [handModel.data mj_JSONObject];
        if (nil == ObjType) {
            if ([handModel.data isKindOfClass:[NSString class]]) {
                resultData = handModel.data;
            } else {
                resultData =jsonObject;
            }
        }else if ([jsonObject isKindOfClass:[NSDictionary class]]){
            resultData = [ObjType mj_objectWithKeyValues:jsonObject];
        }else if ([jsonObject isKindOfClass:[NSArray class]]){
            /**
             *  特别提示：此处ObjType模型中有个数组属性，数组里面又要装着其他模型时，需要在ObjType的m文件中实现+mj_objectClassInArray
             *
             *   + (NSDictionary *)mj_objectClassInArray
             *   {
             *      return @{@"arrayPropertyName":[Model class]};
             *   }
             *
             */
            resultData = [ObjType mj_objectArrayWithKeyValuesArray:jsonObject];
        }else{
            resultData = nil;
        }
        result.extendModel=resultData;
        result.info = [NSString stringWithFormat:@"%@",handModel.message];

        //服务端code 0表示成功
        if ([handModel.code isEqualToString:[NSString stringWithFormat:@"%ld",Server_Code_0]]) {
            
            if(![BFStringTools isEmpty:handModel.data]){
                completion(YES ,result);
            } else {
                result.info = [NSString stringWithFormat:@"%@",handModel.message];
                completion(YES ,result);
            }
        }else {
            result.info = [[NetWorkURL sharedInstance] getServerErrorWithCode:[handModel.code integerValue] Info:result.info];
            result.extendModel = jsonObject;
            completion(NO ,result);
        }
    }
    @catch(NSException *excep){
        BFDEBUG(@"数据解析异常: %@",excep.reason);
        completion(NO,nil);

    }
}



@end


@implementation HandleModel


@end
@implementation BaseResponseData

- (NSString*)info{
    _info =[_info isNotBlank]?_info:@"";
    return  _info;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]initWithCapacity:1];
    }
    return _dataArray;
}

- (NSMutableDictionary *)dataDic {
    if (!_dataDic) {
        _dataDic = [[NSMutableDictionary alloc]initWithCapacity:1];
    }
    return _dataDic;
}

@end
