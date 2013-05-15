//
//  DragDropImageView.h
//  lab#5
//
//  Created by nemesis on 5/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface DragDropImageView : NSImageView <NSDraggingSource, NSDraggingDestination, NSPasteboardItemDataProvider>
{
    BOOL highlight;
}

- (id)initWithCoder:(NSCoder *)coder;

@end