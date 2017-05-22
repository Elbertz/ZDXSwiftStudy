//
//  BackgroundAudoTask.h
//  AUDIO + VOIP
//
//  Created by Ravishanker Kusuma on 12/31/13.
//  该类用于后台长期运行,需调用[bgTask startBackgroundTasks:2 target:self selector:@selector(backgroundCallback:)];  开启



#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "MVVMconfig.h"

@interface BackgroundTask : NSObject
{
    __block UIBackgroundTaskIdentifier bgTask;
    __block dispatch_block_t expirationHandler;
    __block NSTimer * timer;
    __block AVAudioPlayer *player;
    
    NSInteger timerInterval;
    id target;
    SEL selector;
}
-(void) startBackgroundTasks:(NSInteger)time_  target:(id)target_ selector:(SEL)selector_;
-(void) stopBackgroundTask;

+ (id)sharedInstance;


@end
