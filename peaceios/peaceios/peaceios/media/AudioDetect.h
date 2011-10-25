//
//  AudioDetect.h
//  Utility_Test
//
//  Created by 袁 彬 on 11-8-4.
//  Copyright 2011 瓦力. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <AudioToolbox/AudioToolbox.h>
 

#define AVERAGE_POWER_RECORD_COUNT 60

typedef enum _expirationStatus
{
    ExpirationStatusInvalid,
    ExpirationStatusReady,
    ExpirationStatusExpirating,
    ExpirationStatusEnd
}ExpirationStatus;

//插入耳机的广播通知
#define kHeadsetPlugInNotification @"kHeadsetPlugInNotification"
//耳机拔出的广播通知
#define kHeadsetRemovedNotification @"kHeadsetRemovedNotification"

@protocol  AudioDetectDelegate;

@interface AudioDetect : NSObject 
{
	
	id<AudioDetectDelegate> truthDelegate;
	
 
	NSTimeInterval lastRecordTimeInterval;
 
	
 
    
    ExpirationStatus status;
    
    NSUInteger invalidCount;
    NSUInteger readyCount;
@private
	AVAudioRecorder			*_audioRecorder;		//录音设备
	
	NSTimer					*_audioLevelTimer;		//音频采样频率
	
	double					_lowPassResults;		//低通滤波
	
	double					_averagePowers[AVERAGE_POWER_RECORD_COUNT];		
													//平均功率
	NSInteger				_averagePowerIndex;		//平均功率当前索引
	
	id<AudioDetectDelegate> _delegate;
	float lastPeakValue;
	BOOL hasAssignPeakValue;
	
	float lastPowerValue;
	BOOL hasAssignPowerValue;
	
	int noVoiceCount;
	
	enum enumDetectType {
		EDetectFinger = 0,
		EDetectBlow
	}						_detectType;
}
@property (nonatomic, assign)id<AudioDetectDelegate> truthDelegate;

@property (nonatomic,assign) ExpirationStatus status;

+ (id)sharedDetect;

- (void)startDetect:(id<AudioDetectDelegate>)delegate;

- (void)stopDetect;

- (BOOL)isRecording;

//判断有没有耳机插入
+ (BOOL)isHeadsetPluggedIn;

- (void) insertHeadset;

- (void) removeHeadset;

//判断有没有microphone
+ (BOOL) hasMicrophone;

@end

@protocol AudioDetectDelegate <NSObject>
@optional

- (void) notifyPeakValue:(NSNumber*)number;

- (void) notifyPowerValue:(NSNumber*)number;

- (void) notifyStatus:(NSString*) status;

- (void) notifyUpdateDuration:(float) duration;

- (void) notifyEnd;

- (void) noitfyBegin;

- (void) notifyLowPass:(NSString*)lowPass;
@end



