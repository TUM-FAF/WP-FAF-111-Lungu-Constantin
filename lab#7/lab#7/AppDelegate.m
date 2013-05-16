//
//  AppDelegate.m
//  lab#7
//
//  Created by Constantin Lungu on 5/16/13.
//
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize allSongs = _allSongs;
NSTimer *timer,*timer2;
NSMutableArray *urls;
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _allSongs = [NSMutableArray array];
    
    NSArray * directoryContents = [self arrayOfFoldersInFolder:@"/Users/nemesis/Desktop/muzz"];
    urls = [NSMutableArray array];
    for(NSString* file in directoryContents){
        if(![file isEqualToString:@".DS_Store"]){
        NSString* name = [file stringByReplacingOccurrencesOfString:@".mp3" withString:@""];
            NSArray* separatedName = [name componentsSeparatedByString:@" - "];
            Song* tempSong = [[Song alloc] init];
            [tempSong setTitle:[separatedName objectAtIndex:1] andArtist:[separatedName objectAtIndex:0]];
            [_allSongs addObject:tempSong];
            NSString* urlString = [[NSBundle mainBundle] pathForResource:name ofType:@"mp3"];
            NSString* webStringURL = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL* temp = [NSURL URLWithString:webStringURL];
        [urls addObject:temp];
        }
    }
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[urls objectAtIndex:0] error:nil];
    [self.player prepareToPlay];
    [self.player setVolume:0.5];
    self.currentSong = [_allSongs objectAtIndex:0];
}


- (NSArray*)arrayOfFoldersInFolder:(NSString*) folder {
	NSFileManager *fm = [NSFileManager defaultManager];
	NSArray* files = [fm directoryContentsAtPath:folder];
	NSMutableArray *directoryList = [NSMutableArray arrayWithCapacity:10];
    
	for(NSString *file in files) {
		NSString *path = [folder stringByAppendingPathComponent:file];
		BOOL isDir = NO;
		[fm fileExistsAtPath:path isDirectory:(&isDir)];
        [directoryList addObject:file];
	}
    
	return files;
}

-(void) updateTimeLabel {
    if([self.player isPlaying]){
        NSTimeInterval currentTime = [self.player currentTime];
        int currentMinutes = ((int) currentTime)/60;
        int currentSeconds = (((int) currentTime)%60);
        NSString *currentTimeString;
        if(currentSeconds<10){
            currentTimeString = [NSString stringWithFormat:@"%i:0%i",currentMinutes,currentSeconds];
        }
        else{
            currentTimeString = [NSString stringWithFormat:@"%i:%i",currentMinutes,currentSeconds];
        }
        [self.timeLabel setStringValue:currentTimeString];
    }
}

- (void) updateProgressBar {
    NSTimeInterval playtime = [self.player currentTime];
    NSTimeInterval duration = [self.player duration];
    float progressFloat = playtime/duration*100;
    [self.songSlider setIntValue:progressFloat];
    [self.player setDelegate:self];
}

- (IBAction)volumeChanged:(id)sender {
    [self.player setVolume:[self.volumeSlider intValue]/100.0f];
}

- (IBAction)songSlided:(id)sender {
    NSTimeInterval jumpTo = (self.songSlider.integerValue/100.0f)*self.player.duration;
    self.player.currentTime = jumpTo;
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimeLabel) userInfo:nil repeats:YES];
    [timer fire];
}

- (IBAction)prevPressed:(id)sender {
    int index = 0;
    for (int i = 0; i < [_allSongs count]; i++) {
        if (_currentSong == [_allSongs objectAtIndex:i]) {
            index = i;
            break;
        }
    }
    
    [self.songSlider setIntegerValue:0];
    
    if(index == 0){
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[urls lastObject] error:nil];
        _currentSong = [_allSongs objectAtIndex:[urls count]-1];
        [self playPressed:self];
    } else {
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[urls objectAtIndex:index-1] error:nil];
        _currentSong = [_allSongs objectAtIndex:index-1];
        [self playPressed:self];
    }
        [self.player setVolume:[self.volumeSlider intValue]/100.0f];
}

- (IBAction)pausePressed:(id)sender {
    [self.player pause];
    [self.currentlyPlayingLabel setStringValue:[NSString stringWithFormat:@"%@ (paused)",[self.currentlyPlayingLabel stringValue]]];
}

- (IBAction)playPressed:(id)sender {
    [self.player play];
    
        [self.player setVolume:[self.volumeSlider intValue]/100.0f];
    NSString* songName = [NSString stringWithFormat:@"%@ - %@",[self.currentSong artist],[self.currentSong title]];
    [self.currentlyPlayingLabel setStringValue:songName];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimeLabel) userInfo:nil repeats:YES];
    timer2 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateProgressBar) userInfo:nil repeats:YES];
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [self nextPressed:self];
}

- (IBAction)stopPressed:(id)sender {
    [self.player stop];
    [self.player setCurrentTime:0];
    [self.songSlider setIntegerValue:0];
    [self.timeLabel setStringValue:@""];
    [self.currentlyPlayingLabel setStringValue:@""];
}

- (IBAction)nextPressed:(id)sender {
    int index = 0;

    [self.songSlider setIntegerValue:0];
    
    for (int i = 0; i < [_allSongs count]; i++) {
        if (_currentSong == [_allSongs objectAtIndex:i]) {
            index = i;
            break;
        }
    }

    if(index == [_allSongs count]-1){
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[urls objectAtIndex:0] error:nil];
        _currentSong = [_allSongs objectAtIndex:0];
        [self playPressed:self];
    } else {
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[urls objectAtIndex:index+1] error:nil];
        _currentSong = [_allSongs objectAtIndex:index+1];
        [self playPressed:self];
    }
        [self.player setVolume:[self.volumeSlider intValue]/100.0f];
}
@end
