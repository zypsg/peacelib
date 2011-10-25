//
//  AudioDetect.m
//  Utility_Test
//
//  Created by 袁 彬 on 11-8-4.
//  Copyright 2011 瓦力. All rights reserved.
//

#import "AudioDetect.h"
#import "Constants.h"

#define kShowPeakValue 0   //打印peak属性相关值
#define kShowdifferValue 0 //打印差值？还是打印原值

#define kExpirationThreshold -15.0f



static AudioDetect *sharedInstance = nil;

static void audioRouteChangeListenerCallback(void                        *inUserData,
											 AudioSessionPropertyID    inID,
											 UInt32                    inDataSize,
											 const void             *inPropertyValue)
{
	AudioDetect* talkSessionViewController = (AudioDetect*)inUserData;
	
	CFDictionaryRef routeChangeDictionary = inPropertyValue;
	
	
	CFNumberRef routeChangeReasonRef =
	CFDictionaryGetValue (routeChangeDictionary,
						  CFSTR (kAudioSession_AudioRouteChangeKey_Reason));
	
	SInt32 routeChangeReason;
	
	CFNumberGetValue (routeChangeReasonRef, kCFNumberSInt32Type, &routeChangeReason);
	
	if (routeChangeReason == kAudioSessionRouteChangeReason_OldDeviceUnavailable) 
	{
		// Headset is unplugged..
        [talkSessionViewController  removeHeadset];
		
	}
	if (routeChangeReason == kAudioSessionRouteChangeReason_NewDeviceAvailable)
	{
		// Headset is plugged in..  
		[talkSessionViewController  insertHeadset];
	}
}



@implementation AudioDetect
@synthesize truthDelegate;
@synthesize status;
 

+ (id)sharedDetect
{
	@synchronized(self)
	{
		if(sharedInstance == nil)
		{
			sharedInstance = [[self alloc] init];
		}
	}
	
	return sharedInstance;
}


- (id)init
{
	self = [super init];
	if(self)
	{
		//开启录音设置
		NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
		NSDictionary* settings = [NSDictionary dictionaryWithObjectsAndKeys:
								  [NSNumber numberWithFloat:44100.0],AVSampleRateKey,
								  [NSNumber numberWithInt:kAudioFormatAppleLossless],AVFormatIDKey,
								  [NSNumber numberWithInt:1],AVNumberOfChannelsKey,
								  [NSNumber numberWithInt:AVAudioQualityMax],AVEncoderAudioQualityKey,nil];
		NSError* error;
		_audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
		if(error)
		{
			NSLog(@"error :%@",error);		
		}
		
		lastPeakValue = 1000;
        status = ExpirationStatusInvalid;
        
        AudioSessionInitialize(NULL, NULL, NULL, NULL);
        AudioSessionSetActive(TRUE);
        AudioSessionAddPropertyListener (kAudioSessionProperty_AudioRouteChange,
                                         audioRouteChangeListenerCallback,
                                         self);
        
	}
	return self;
}

- (void)startDetect:(id<AudioDetectDelegate>)delegate
{
    invalidCount = 0;
    readyCount = 0;
    status = ExpirationStatusReady;
    
	if ( _audioRecorder ) 
	{
		[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];

		_delegate = delegate;

		if ( ![_audioRecorder isRecording] )
		{
			//开启录音
			[_audioRecorder prepareToRecord];
			_audioRecorder.meteringEnabled = YES;
			[_audioRecorder record];
		}
				
		//设定能量初始值
		_lowPassResults = 0;
		_averagePowerIndex = 0;
		for ( int i=0;i<AVERAGE_POWER_RECORD_COUNT;i++ )
		{
			_averagePowers[i] = -50.0f;
		}
		
		//开启定时采样
		if ( _audioLevelTimer ) {
			[_audioLevelTimer invalidate];
			_audioLevelTimer = nil;
		}
		if ( !_audioLevelTimer ) 
		{
			_audioLevelTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f
																target:self
															  selector:@selector(audioLevelTimerCallback:)
															  userInfo:nil
															   repeats:YES];			
		}		
	}
    
    if([AudioDetect isHeadsetPluggedIn])
    {
        NSLog(@"有耳机");
    }
    else
    {
        NSLog(@"没有耳机");
    }
}

- (void)startDetectFinger:(id<AudioDetectDelegate>)delegate
{
	_detectType = EDetectFinger;
	[self startDetect:delegate];
}
- (void)startDetectBlow:(id<AudioDetectDelegate>)delegate
{
	_detectType = EDetectBlow;
	[self startDetect:delegate];
}

- (void)stopDetect
{
	
	if ( _audioRecorder ) 
	{
		[_audioRecorder pause];
	}
	
	if ( _audioLevelTimer ) {
		[_audioLevelTimer invalidate];
		_audioLevelTimer = nil;
	}
}

- (BOOL)isRecording
{
	return [_audioRecorder isRecording];
}

 

#pragma mark -
#pragma mark 定期采样
 
- (void)audioLevelTimerCallback:(NSTimer*)timer
{
	[_audioRecorder updateMeters];
	const double ALPHA = 0.05;
	double peakPowerForChannel = pow(10,(ALPHA*[_audioRecorder peakPowerForChannel:0]));
	_lowPassResults = ALPHA*peakPowerForChannel+(1.0-ALPHA)*_lowPassResults; 
	
    if([_delegate respondsToSelector:@selector(notifyLowPass:)])
    {
        [_delegate notifyLowPass:[NSString stringWithFormat:@"%.1f", _lowPassResults]];
    }
    
	_averagePowers[_averagePowerIndex] = [_audioRecorder averagePowerForChannel:0];
	_averagePowerIndex++;
	if ( _averagePowerIndex >= AVERAGE_POWER_RECORD_COUNT ) {
		_averagePowerIndex = 0;
	}
    
    float peakValue = [_audioRecorder peakPowerForChannel:0];
    float averagePower = [_audioRecorder averagePowerForChannel:0];
//    NSLog(@"peakValue:%f,averagePower:%f",peakValue,averagePower);
    
    if([_delegate respondsToSelector:@selector(notifyPeakValue:)])
    {
        [_delegate notifyPeakValue:[NSNumber numberWithFloat:peakValue]];
    }
    
    if([_delegate respondsToSelector:@selector(notifyPowerValue:)])
    {
        [_delegate notifyPowerValue:[NSNumber numberWithFloat:averagePower]];
    }
    
    if(ExpirationStatusReady==status)
    {
        if(averagePower>kExpirationThreshold)
        {
            readyCount++;
            if(readyCount>=3)
            {
                status = ExpirationStatusExpirating;
                NSLog(@"开始吹气了...");
                lastRecordTimeInterval = [NSDate timeIntervalSinceReferenceDate];
                if([_delegate respondsToSelector:@selector(notifyStatus:)])
                {
                    [_delegate notifyStatus:kBreathStatusBreathing];
                }
   
                if([_delegate respondsToSelector:@selector(noitfyBegin)])
                {
                    [_delegate noitfyBegin ];
                }
            }
        }
        else
        {
            readyCount = 0;
        }
    }
    else if(ExpirationStatusExpirating == status)
    {
        if(averagePower>kExpirationThreshold)
        {
            invalidCount = 0;
            if([_delegate respondsToSelector:@selector(notifyUpdateDuration:)])
            {
                [_delegate notifyUpdateDuration: [NSDate timeIntervalSinceReferenceDate] - lastRecordTimeInterval  ];
            }
        }
        else
        {
            invalidCount++;
            if(invalidCount>=3)
            {
                invalidCount = 0;
                readyCount = 0;
                status = ExpirationStatusReady;
                NSLog(@"吹气结束 ...second:%f",([NSDate timeIntervalSinceReferenceDate] - lastRecordTimeInterval));
                if([_delegate respondsToSelector:@selector(notifyStatus:)])
                {
                    [_delegate notifyStatus:[NSString stringWithFormat:@"%.1f",( [NSDate timeIntervalSinceReferenceDate] - lastRecordTimeInterval )]];
                }
                if([_delegate respondsToSelector:@selector(notifyEnd)])
                {
                    [_delegate notifyEnd ];
                }
                
                
             
            }
        }
    }
}

- (void)dealloc
{
	[_audioRecorder release];
    [super dealloc];
}


#pragma mark-
#pragma mark ---Headset relative methods ---
+ (BOOL)isHeadsetPluggedIn {
    UInt32 routeSize = sizeof (CFStringRef);
    CFStringRef route;
    
    OSStatus error = AudioSessionGetProperty (kAudioSessionProperty_AudioRoute,
                                              &routeSize,
                                              &route);
    
    /* Known values of route:
     * "Headset"
     * "Headphone"
     * "Speaker"
     * "SpeakerAndMicrophone"
     * "HeadphonesAndMicrophone"
     * "HeadsetInOut"
     * "ReceiverAndMicrophone"
     * "Lineout"
     */
    
    if (!error && (route != NULL)) {
        
        NSString* routeStr = (NSString*)route;
        
        NSRange headphoneRange = [routeStr rangeOfString : @"Head"];
        
        if (headphoneRange.location != NSNotFound) return YES;
        
    }
    
    return NO;
}

- (void) insertHeadset
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kHeadsetPlugInNotification object:nil];
}

+ (BOOL) hasMicrophone
{
    NSError *error;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance]; 
    if (![audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error]) 
    { 
        return NO;
    } // mix audio with others, such as iPod etc. 
    UInt32 doSetProperty = 1; 
    AudioSessionSetProperty (kAudioSessionProperty_OtherMixableAudioShouldDuck, sizeof(doSetProperty), &doSetProperty); 
    if (![audioSession setActive:YES error:&error]) 
    {
        return NO;
    } 
    return audioSession.inputIsAvailable;
}

- (void) removeHeadset
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kHeadsetRemovedNotification object:nil];
}


@end
