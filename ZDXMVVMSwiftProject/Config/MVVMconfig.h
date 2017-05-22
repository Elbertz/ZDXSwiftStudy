//
//  MVVMconfig.h
//  zdxMVVMMiguCloudDemo
//
//  Created by shangbao on 16/7/20.
//  Copyright © 2016年 wondertek. All rights reserved.
//


#define FOR_DEBUG
#ifdef FOR_DEBUG
#define DebugLog(log, ...) NSLog(log, ##__VA_ARGS__)
#define DebugSocketLog(log, ...) //NSLog(log, ##__VA_ARGS__)
#define kPrintfLog NSLog(@"Func:%s , Line: %d", __PRETTY_FUNCTION__, __LINE__)
#else
#define DebugLog(log, ...)
#define DebugSocketLog(log, ...)
#define kPrintfLog
#endif



#ifndef MVVMconfig_h
#define MVVMconfig_h

#define isIos7      ([[[UIDevice currentDevice] systemVersion] floatValue])
#define StatusbarSize ((isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)

#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define IosAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define isIphone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define SharedAppNFInfo [NFUserInfo shareNFInfo]
#define SharedPreferenceManager [PreferenceManager sharedPreferenceManager]
#define appDelegate ((AppDelegate*)[UIApplication sharedApplication].delegate)

#define IsEn_Language YES

#define AFont(s) [UIFont systemFontOfSize:s]

#define ENISOCODE CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1)
#define ENGBKCODE CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)

#define barRGB [UIColor colorWithRed:33/255.f green:158/255.f  blue:255/255.f  alpha:1.0]

//#define baseRGB [UIColor colorWithRed:33/255.f green:158/255.f  blue:255/255.f  alpha:1.0]

#define baseRGB [UIColor colorWithRed:55/255.f green:188/255.f  blue:155/255.f  alpha:1.0]

#define baseBGRGB [UIColor colorWithRed:242/255.f green:242/255.f  blue:242/255.f  alpha:1.0]

#define pickerbaseRGB [UIColor colorWithRed:240/255.f green:240/255.f  blue:240/255.f  alpha:1.0]

#define KAccountFontColor ([UIColor colorWithRed:227.0/255 green:88.0/255 blue:80.0/255 alpha:1])






#define IMPLEMENT_SINGLE_INSTANCE       \
static id s_instance;                   \
+ (id)sharedInstance                    \
{                                       \
if (s_instance == nil) {                \
s_instance = [[self alloc] init];       \
}                                       \
return s_instance;                      \
}


//6s :WIDTH=375.00   HEIGHT=667.00  6s Plus :WIDTH=414.00   HEIGHT=736.00
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define kSTATUSHEIGHT 20
#define kNAVHEIGHT 44
#define kTABBARHEIGHT 49
#define HTOTOP 64 //64   0

#define jj [UIColor colorWithRed:38/255.0 green:151/255.0 blue:169/255.0 alpha:1]
#define ZDXColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define KLIVEURLSTRING @"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8?wsSession=50fb2baedaa48d89fa5b7939-148965193895578&wsIPSercert=83a8d2017f4d2e6cc093695ca44b108a&wsMonitor=-1"

//健康统计估算每步0.6米
#define KMETERPERSTEP 0.6

#endif /* MVVMconfig_h */
