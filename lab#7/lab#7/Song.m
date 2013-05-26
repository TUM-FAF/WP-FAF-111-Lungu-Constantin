//
//  Song.m
//  lab#7
//
//  Created by Constantin Lungu on 5/17/13.
//
//

#import "Song.h"

@implementation Song

@synthesize artist, title;

- (void) setTitle:(NSString *)newTitle andArtist:(NSString*) newArtist{
    self.artist = newArtist;
    self.title = newTitle;
}

@end
