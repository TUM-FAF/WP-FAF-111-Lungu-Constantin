//
//  AppDelegate.h
//  lab#7
//
//  Created by Constantin Lungu on 5/16/13.
//
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>
#import "Song.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, AVAudioPlayerDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong) AVAudioPlayer* player;
@property (nonatomic, strong) NSMutableArray* allSongs;

@property (weak) IBOutlet NSSlider *songSlider;
@property (weak) IBOutlet NSTextField *currentlyPlayingLabel;
@property (weak) IBOutlet NSTextField *timeLabel;
@property (weak) IBOutlet NSSlider *volumeSlider;

@property (nonatomic) Song* currentSong;

- (IBAction)prevPressed:(id)sender;
- (IBAction)pausePressed:(id)sender;
- (IBAction)playPressed:(id)sender;
- (IBAction)stopPressed:(id)sender;
- (IBAction)nextPressed:(id)sender;



@end
