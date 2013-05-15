//
//  DragDropImageView.m
//  lab#5
//
//  Created by nemesis on 5/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DragDropImageView.h"

@implementation DragDropImageView

NSString *kPrivateDragUTI = @"com.utm.cocoadraganddrop";

- (id)initWithCoder:(NSCoder *)coder
{

    self=[super initWithCoder:coder];
    if ( self ) {
        //register for all the image types we can display
        [self registerForDraggedTypes:[NSImage imagePasteboardTypes]];
    }
    return self;
}

#pragma mark - Destination Operations

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
    
    // Check if the pasteboard contains image data and source/user wants it copied
    if ( [NSImage canInitWithPasteboard:[sender draggingPasteboard]] &&
        [sender draggingSourceOperationMask] &
        NSDragOperationCopy ) {
        
        //highlight our drop zone
        highlight=YES;
        
        [self setNeedsDisplay: YES];
        
        
        [sender enumerateDraggingItemsWithOptions:NSDraggingItemEnumerationConcurrent 
                                          forView:self
                                          classes:[NSArray arrayWithObject:[NSPasteboardItem class]] 
                                    searchOptions:nil 
                                       usingBlock:^(NSDraggingItem *draggingItem, NSInteger idx, BOOL *stop) {
                                           
                                          
                                           if ( ![[[draggingItem item] types] containsObject:kPrivateDragUTI] ) {
                                               
                                               *stop = YES;
                                               
                                           } else {
                                              
                                               [draggingItem setDraggingFrame:self.bounds contents:[[[draggingItem imageComponents] objectAtIndex:0] contents]];
                                           }
                                       }];
        
        //accept data as a copy operation
        return NSDragOperationCopy;
    }
    
    return NSDragOperationNone;
}

- (void)draggingExited:(id <NSDraggingInfo>)sender
{
    //remove highlight of the drop zone
    highlight=NO;
    
    [self setNeedsDisplay: YES];
}

-(void)drawRect:(NSRect)rect
{
    
    [super drawRect:rect];
    
    if ( highlight ) {
        [[NSColor grayColor] set];
        [NSBezierPath setDefaultLineWidth: 5];
        [NSBezierPath strokeRect: rect];
    }
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
    
    highlight=NO;
    
    [self setNeedsDisplay: YES];
    
    //check to see if we can accept the data
    return [NSImage canInitWithPasteboard: [sender draggingPasteboard]];
} 

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    
    if ( [sender draggingSource] != self ) {
        NSURL* fileURL;

        if([NSImage canInitWithPasteboard: [sender draggingPasteboard]]) {
            NSImage *newImage = [[NSImage alloc] initWithPasteboard: [sender draggingPasteboard]];
            [self setImage:newImage];
        }
        
        fileURL=[NSURL URLFromPasteboard: [sender draggingPasteboard]];
        [[self window] setTitle: fileURL!=NULL ? [fileURL absoluteString] : @"(no name)"];
    }
    
    return YES;
}

- (NSRect)windowWillUseStandardFrame:(NSWindow *)window defaultFrame:(NSRect)newFrame;
{
    
    NSRect ContentRect=self.window.frame;
    ContentRect.size=[[self image] size];
    
    return [NSWindow frameRectForContentRect:ContentRect styleMask: [window styleMask]];
};

#pragma mark - Source Operations

- (void)mouseDown:(NSEvent*)event
{
    
    
    NSPasteboardItem *pbItem = [NSPasteboardItem new];
    
    [pbItem setDataProvider:self forTypes:[NSArray arrayWithObjects:NSPasteboardTypeTIFF, NSPasteboardTypePDF, kPrivateDragUTI, nil]];
    
    NSDraggingItem *dragItem = [[NSDraggingItem alloc] initWithPasteboardWriter:pbItem];
    NSRect draggingRect = self.bounds;
    [dragItem setDraggingFrame:draggingRect contents:[self image]];
    NSDraggingSession *draggingSession = [self beginDraggingSessionWithItems:[NSArray arrayWithObject:dragItem] event:event source:self];
    draggingSession.animatesToStartingPositionsOnCancelOrFail = YES;
    
    draggingSession.draggingFormation = NSDraggingFormationNone;
}

- (NSDragOperation)draggingSession:(NSDraggingSession *)session sourceOperationMaskForDraggingContext:(NSDraggingContext)context
{
    switch (context) {
        case NSDraggingContextOutsideApplication:
            return NSDragOperationCopy;
        case NSDraggingContextWithinApplication:
        default:
            return NSDragOperationCopy;
            break;
    }
}

- (BOOL)acceptsFirstMouse:(NSEvent *)event 
{
    return YES;
}

- (void)pasteboard:(NSPasteboard *)sender item:(NSPasteboardItem *)item provideDataForType:(NSString *)type
{
    if ( [type compare: NSPasteboardTypeTIFF] == NSOrderedSame ) {
        [sender setData:[[self image] TIFFRepresentation] forType:NSPasteboardTypeTIFF];
    } else if ( [type compare: NSPasteboardTypePDF] == NSOrderedSame ) {
        [sender setData:[self dataWithPDFInsideRect:[self bounds]] forType:NSPasteboardTypePDF];
    }
    
}
@end
