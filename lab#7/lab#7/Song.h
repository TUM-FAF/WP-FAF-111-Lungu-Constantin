//
//  Song.h
//  lab#7
//
//  Created by Constantin Lungu on 5/17/13.
//
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

@property NSString* title;
@property NSString* artist;

- (void) setTitle:(NSString *)newTitle andArtist:(NSString*) newArtist;

@end
