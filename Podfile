
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'
inhibit_all_warnings!

target 'BoyFriend' do
    pod 'AFNetworking','4.0.1'
    pod 'Bugly' #腾讯崩溃统计SDK
    pod 'DateTools','2.0.0'#日期工具库
    pod 'FLEX','~> 4.6.1', :configurations => ['Debug']#调试神器(模拟器按s,会出现视图层级关系)
    pod 'IQKeyboardManager','6.5.6'
    pod 'JPFPSStatus','0.1.1'#FPS显示
    pod 'JXCategoryView','1.5.9'
    pod 'KVOController','1.2.0'
    pod 'LKDBHelper','2.5.8'#sqlite ORM
    pod 'Masonry','1.1.0'#布局框架
    pod 'MBProgressHUD','1.2.0'
    pod 'MJRefresh','3.7.2'
    pod 'MJExtension','3.3.0'
    pod 'QMUIKit' #功能说明 https://qmuiteam.com/ios/documents/
    pod 'ReactiveObjC','3.1.1' #函数响应式编程框架
    pod 'SDWebImage','5.12.1'
    pod 'SDWebImageWebPCoder','0.8.4'#SD支持webp格式(添加完 configSDWebImage 要设置)
    pod 'SDCycleScrollView','1.82'#图片轮播
    pod 'TZImagePickerController','3.7.6'#相册图片选择
    pod 'WebViewJavascriptBridge','6.0.3'#更快的支持JS调用OC,OC调用JS
    pod 'YYKit','1.0.9'
#    pod 'JPush','4.4.0'#极光推送
#    pod 'JCore', '3.1.0-noidfa'
#    pod 'JLRoutes','2.1'#路由跳转
#    pod 'FSCalendar','2.8.2'#日历控件
#    pod 'UMengAnalytics-NO-IDFA','4.2.5'#友盟统计无IDFA版SDK
#    pod 'LBXScan','2.5.1'#二维码扫描
#    pod 'WeChat_SDK_iOS'#微信支付SDK
#    pod 'Alipay_SDK_iOS'#支付宝支付SDK
#    pod 'mob_sharesdk','4.3.16'
#    # UI模块(非必须，需要用到ShareSDK提供的分享菜单栏和分享编辑页面需要以下1行)
#    pod 'mob_sharesdk/ShareSDKUI'
#    pod 'mob_sharesdk/ShareSDKPlatforms/QQ'
#    pod 'mob_sharesdk/ShareSDKPlatforms/SinaWeibo'
#    #    （微信sdk不带支付的命令）
#    #    pod 'mob_sharesdk/ShareSDKPlatforms/WeChat'
#    #（微信sdk带支付的命令，和上面不带支付的不能共存，只能选择一个）
#    pod 'mob_sharesdk/ShareSDKPlatforms/WeChatFull'

end

# 加入这些配置,防止masonry使用 mas_topMargin 等 margin属性会崩溃
post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == "Masonry"
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
            end
        end
    end
end
#删除WebViewJavascriptBridge中的WebViewJavascriptBridge.h和WebViewJavascriptBridge.m文件
pre_install do |installer|
  dir_web = File.join(installer.sandbox.pod_dir('WebViewJavascriptBridge'), 'WebViewJavascriptBridge')
  Dir.foreach(dir_web) {|x|
    real_path = File.join(dir_web, x)
    if (!File.directory?(real_path) && File.exists?(real_path))
      if(x == 'WebViewJavascriptBridge.h' || x == 'WebViewJavascriptBridge.m')
        File.delete(real_path)
      end
    end
  }
end
