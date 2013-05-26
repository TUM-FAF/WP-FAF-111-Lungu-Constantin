//
//  AppDelegate.m
//  lab#5
//
//  Created by Constantin Lungu on 5/22/13.
//  Copyright (c) 2013 Constantin Lungu. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize commandField = _commandField, outputField = _outputField, window = _window, currentPath = _currentPath;

int level = 1;

NSString* helpString = @"/*------------------------ Help ------------------------*/\n Available commands: \n 'mkdir /name/' - create a folder in the current directory\n 'rm /name/' - remove file or folder in the current working path\n 'cd /path/' - change directory to the specified path (if it exists), use 'up' or 'cd ..' to cd to root directory\n 'ls' - list all folders and files in the current directory\n 'gobj' - get the current objective for passing the level\n 'cobj /answer/' - give your final answer for the current objective. To see the current objective, use 'gobj' command\n 'run /name/' - run the specified script/program\n 'whatis /name/' - get info on the specified file\n 'clear' or 'cl' - clear the screen \n/*---------------------- End Help ----------------------*/\n";
NSMutableArray* filesInDesktop;
NSArray* tasks;
NSString* usernameWithPathLine, *username;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self.window setBackgroundColor:[NSColor blackColor]];
    
    _currentPath = @"Desktop";
    
    filesInDesktop = [NSMutableArray arrayWithObjects:@"Desktop/Work",@"Desktop/Work/Files",@"Desktop/Work/Files/Scripts",@"Desktop/Work/Files/Scripts/mail_test.rb",@"Desktop/Work/Files/Scripts/",@"Desktop/UTM",@"Desktop/UTM/Reports",@"Desktop/UTM/Reports/RRG.rb",@"Desktop/UTM/Reports/WP",@"Desktop/UTM/Reports/WP/lab#1.pdf",@"Desktop/UTM/Reports/WP/lab#2.pdf",@"Desktop/UTM/Reports/WP/lab#3.pdf",@"Desktop/UTM/Reports/WP/lab#4.pdf",@"Desktop/UTM/Reports/IDE",@"Desktop/UTM/Reports/IDE/lab#1.pdf",@"Desktop/UTM/Reports/IDE/lab#2.pdf",@"Desktop/UTM/Reports/IDE/lab#3.pdf",@"Desktop/UTM/Reports/IDE/lab#6.pdf",@"Desktop/UTM/Reports/IDE/IDE Course Introduction.pdf", nil];
    
    tasks = [NSArray arrayWithObjects:@"\nCurrent level : 1\nObjective: Find out who copied your laboratory work #4 for Windows Programming\n\n",@"\nNew tasks coming soon...\n\n", nil];
    [self.outputField setStringValue:@"-"];
    _commandField.delegate = self;
    [_commandField setEditable:YES];
    username = [self input:@"Pick a username" defaultValue:@"user"];
    usernameWithPathLine = [NSString stringWithFormat:@"Macbook-%@ %@$: waiting for command...\n",_currentPath,username];
    [_outputField setStringValue:usernameWithPathLine];
}

- (void) controlTextDidChange:(NSNotification *)obj{
//    NSLog(@"Did change");
}

- (BOOL) control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector{
    
    if([NSStringFromSelector(commandSelector) isEqualToString:@"insertNewline:"]){
        /* ------------------------- HELP ------------------------- */
        if([[_commandField stringValue] isEqualToString:@"help"]){
            [_outputField setStringValue:[[_outputField stringValue] stringByAppendingFormat:@"%@",helpString]];
        }
        /* ------------------------- CD ------------------------- */
        else if([[_commandField stringValue] isEqualToString:@"cd"] || [[_commandField stringValue] isEqualToString:@"cd "]){
            [self appendText:@"cd command usage example: cd Work/Files\n"];
        }
        /* ------------------------- LS ------------------------- */
        else if([[_commandField stringValue] isEqualToString:@"ls"]) {
            // List all files...		
            for( NSString* path in filesInDesktop ){
                if(!([path rangeOfString:_currentPath].location == NSNotFound)){
                NSArray* substrings = [path componentsSeparatedByString:_currentPath];
                NSString* firstPath = [substrings objectAtIndex:1];
                int count = (int) [[firstPath componentsSeparatedByString:@"/"]count];
                if(count == 2){
                    [_outputField setStringValue:[[_outputField stringValue] stringByAppendingFormat:@"%@ \t",[firstPath stringByReplacingOccurrencesOfString:@"/" withString:@""]]];
                    }
                }
            }
            [_outputField setStringValue:[[_outputField stringValue] stringByAppendingFormat:@"\n"]];
        }
        /* ------------------------- MKDIR ------------------------- */
        else if([[_commandField stringValue] isEqualToString:@"mkdir"]){
            [self appendText:@"mkdir command usage example: mkdir new_folder\n"];
        }
         /* ------------------------- MKDIR 'dirname' ------------------------- */
        else if ([[_commandField stringValue] rangeOfString:@"mkdir "].location != NSNotFound){
            NSString* newDirname = [NSString stringWithFormat:@"%@/%@",_currentPath,[[_commandField stringValue] stringByReplacingOccurrencesOfString:@"mkdir " withString:@""]];
            BOOL directoryExists = NO;
            for(NSString* paths in filesInDesktop){
                if([newDirname isEqualToString:paths]){
                    directoryExists = YES;
                    break;
                }
            }
            if(!directoryExists){
                [filesInDesktop addObject:newDirname];
                NSLog(@"%@",filesInDesktop);
                [self appendText:[NSString stringWithFormat:@"Created directory %@ in %@\n",[newDirname stringByReplacingOccurrencesOfString:_currentPath withString:@""],_currentPath]];
            }
                 else {
                     [self appendText:[NSString stringWithFormat:@"Couldn't create directory in %@, probably it already exists",_currentPath]];
                 }
            
        }
        /* ------------------------- RM ------------------------- */
        else if ([[_commandField stringValue] isEqualToString:@"rm"]){
            [self appendText:@"rm command usage example: rm new_folder\n"];
        }
        
        /* ------------------------- RM 'path' ------------------------- */
        else if ([[_commandField stringValue] rangeOfString:@"rm "].location != NSNotFound){
            NSString* removeDirPath;
            removeDirPath = [_currentPath stringByAppendingFormat:@"/%@",[[_commandField stringValue] stringByReplacingOccurrencesOfString:@"rm " withString:@""]];
            if([filesInDesktop containsObject:removeDirPath]){
                [filesInDesktop removeObject:removeDirPath];
                [self appendText:[NSString stringWithFormat:@"Removed %@ from %@\n",[[_commandField stringValue] stringByReplacingOccurrencesOfString:@"rm " withString:@""],_currentPath]];
            } else {
                [self appendText:[NSString stringWithFormat:@"Couldn't remove %@, make sure file/directory exists\n",[[_commandField stringValue] stringByReplacingOccurrencesOfString:@"rm " withString:@""]]];
            }
        }
        /* ------------------------- COBJ ------------------------- */
        else if ([[_commandField stringValue] isEqualToString:@"cobj"] || [[_commandField stringValue] isEqualToString:@"cobj "]){
            [self appendText:@"cobj command usage example: cobj your_answer\n"];
        }
        /* ------------------------- COBJ 'answer' ------------------------- */
        else if ([[_commandField stringValue] rangeOfString:@"cobj "].location != NSNotFound){
            [self appendText:@"/*------------------------ COBJ result ------------------------*/\n\n"];
            switch (level) {
                case 1:
                    if([[[_commandField stringValue] stringByReplacingOccurrencesOfString:@"cobj " withString:@""] isEqualToString:@"Constantin Lungu"] ||  [[[_commandField stringValue] stringByReplacingOccurrencesOfString:@"cobj " withString:@""] isEqualToString:@"Lungu Constantin"]){
                        [self appendText:[NSString stringWithFormat:@"Congratulations! The answer %@ is correct! You've passed level %i!\nCurrent Level: %i\n",[[_commandField stringValue] stringByReplacingOccurrencesOfString:@"cobj " withString:@""],level,level+1]];
                        level++;
                    } else {
                        [self appendText:[NSString stringWithFormat:@"Sorry, the answer %@ is not correct.\n",[[_commandField stringValue] stringByReplacingOccurrencesOfString:@"cobj " withString:@""]]];
                    }
                    break;
                    
                default:
                    break;
            }
            [self appendText:@"\n /*------------------------ END COBJ result ------------------------*/\n"];
                
        }
        /* ------------------------- WHATIS ------------------------- */
        else if ([[_commandField stringValue] isEqualToString:@"whatis"] || [[_commandField stringValue] isEqualToString:@"whatis "]){
            [self appendText:@"whatis command usage example: whatis myscript.py\n"];
        }
        /* ------------------------- WHATIS 'path' ------------------------- */
        else if ([[_commandField stringValue] rangeOfString:@"whatis "].location != NSNotFound){
            NSString* requestedFile = [[_commandField stringValue] stringByReplacingOccurrencesOfString:@"whatis " withString:@""];
            NSString* whatIsPath;
            whatIsPath = [_currentPath stringByAppendingFormat:@"/%@",[[_commandField stringValue] stringByReplacingOccurrencesOfString:@"whatis " withString:@""]];
            NSLog(@"Whatis path = %@",whatIsPath);
            if([filesInDesktop containsObject:whatIsPath]){
                
                if([requestedFile rangeOfString:@".pdf"].location != NSNotFound){
                [self appendText:[NSString stringWithFormat:@"%@ - a pdf file\n",requestedFile]];
                }
                if([requestedFile rangeOfString:@"."].location == NSNotFound){
                    [self appendText:[NSString stringWithFormat:@"%@ - a folder\n",requestedFile]];
                }
                if([requestedFile rangeOfString:@"mail_test.rb"].location != NSNotFound){
                    [self appendText:[NSString stringWithFormat:@"\n%@ - a ruby script, written by Roibu Roman.\n-Should- get you the mails containing the keyword from a existing mail address with a probability of 2/3.\nUsage: 'run mail_test.rb example@mail.com /keyword/ || list /mail_index/'\nNOTE: PARAMETERS BEFORE THE '||' ARE MANDATORY.\nWASN'T TESTED YET. MAY REQUIRE A PASSWORD.\n\n",requestedFile]];
                }
                
            } else {
                [self appendText:[NSString stringWithFormat:@"Couldn't get info on %@, make sure file exists\n",[[_commandField stringValue] stringByReplacingOccurrencesOfString:@"rm " withString:@""]]];
            }
        }
        /* ------------------------- RUN ------------------------- */
        else if ([[_commandField stringValue] isEqualToString:@"run"] || [[_commandField stringValue] isEqualToString:@"run "]){
            [self appendText:@"run command usage example: run scriptname.py, run myscript.rb\n"];
        }
        /* ------------------------- RUN 'name' ------------------------- */
        else if ([[_commandField stringValue] rangeOfString:@"run "].location != NSNotFound){
            if([[_commandField stringValue] rangeOfString:@"mail_test.rb"].location != NSNotFound){
                if([[[_commandField stringValue] componentsSeparatedByString:@" "] count] >= 4){
                NSString* password = [self secureInput:@"Enter the password for mail_test.rb (Roman should have it)" defaultValue:@""];
                    if([password isEqualToString:@"ruby"]){
                        NSArray* params = [[[_commandField stringValue] stringByReplacingOccurrencesOfString:@"run mail_test.rb " withString:@""] componentsSeparatedByString:@" "];
                        [self appendText:[NSString stringWithFormat:@"/*------------------------ SCRIPT RESULT OUTPUT ------------------------*/\n\n"]];
                        [self appendText:[NSString stringWithFormat:@"NR\t FROM\t\t\t\t\t TO\t\t\t\t\t            SUBJECT\n\n"]];
                        if([[params objectAtIndex:0] isEqualToString:@"constantine.lungu@gmail.com"] && [[params objectAtIndex:1] isEqualToString:@"WP"]){
                            [self appendText:[NSString stringWithFormat:@"1\t bmbalex@gmail.com\t constantine.lungu@gmail.com [WP][FAF-111][Laboratory Work Reports]\n\n",[params objectAtIndex:0]]];
                            [self appendText:[NSString stringWithFormat:@"2\t karapuz_92@gmail.com\t constantine.lungu@gmail.com WP Lab#4 Source Code\n\n"]];
                        } else {
                            [self appendText:[NSString stringWithFormat:@"1\t bmbalex@gmail.com\t %@ [WP][FAF-111][Laboratory Work Reports]\n\n",[params objectAtIndex:0]]];
                        }
                        [self appendText:[NSString stringWithFormat:@"/*---------------------- END SCRIPT RESULT OUTPUT ----------------------*/\n"]];
                        
                    }
                    else {
                        [self appendText:[NSString stringWithFormat:@"Incorrect password for %@\n",[[_commandField stringValue] stringByReplacingOccurrencesOfString:@"run " withString:@""]]];
                    }
                } else {
                    [self appendText:[NSString stringWithFormat:@"Couldn't run %@, make sure script exists and you passed the parameters\n",[[_commandField stringValue] stringByReplacingOccurrencesOfString:@"run " withString:@""]]];
                }
            }   
         else {
            [self appendText:[NSString stringWithFormat:@"Couldn't run %@, make sure script exists and you passed the parameters\n",[[_commandField stringValue] stringByReplacingOccurrencesOfString:@"run " withString:@""]]];
            }
        }
        /* ------------------------- CD 'path' ------------------------- */
        else if(!([[_commandField stringValue] rangeOfString:@"cd "].location == NSNotFound) && ![[_commandField stringValue] isEqualToString:@"cd .."]){
            NSString* path = [_currentPath stringByAppendingFormat:@"/%@",[[_commandField stringValue] stringByReplacingOccurrencesOfString:@"cd " withString:@""]];

            BOOL pathExists = NO;
            for( NSString* allPaths in filesInDesktop ){
                if([allPaths isEqualToString:path]){
                        pathExists = YES;
                        break;
                    }
            }
            if(pathExists){
            _currentPath = path;
            } else {
                [_outputField setStringValue:[[_outputField stringValue] stringByAppendingFormat:@"Path %@ does not exist\n",path]];
            }
        }
        /* ------------------------- CD .. or UP ------------------------- */
        else if ([[_commandField stringValue] isEqualToString:@"cd .."] || [[_commandField stringValue] isEqualToString:@"up"]) {
            NSMutableArray* substrings = (NSMutableArray*)[_currentPath componentsSeparatedByString:@"/"];
            if([substrings count] > 1){
            [substrings removeLastObject];
            _currentPath = [substrings componentsJoinedByString:@"/"];
            
            } else {
                [self appendText:@"\nYou are in the root directory.\n\n"];
            }
        }
        /* ------------------------- CLEAR or CL ------------------------- */
        else if ([[_commandField stringValue] isEqualToString:@"clear"] || [[_commandField stringValue] isEqualToString:@"cl"]) {
            [_outputField setStringValue:@""];
        }
        /* ------------------------- GOBJ ------------------------- */
        else if([[_commandField stringValue] isEqualToString:@"gobj"]){
            [self appendText:[tasks objectAtIndex:level-1]];
        }
        /* ------------------------- COMMAND NOT FOUND ------------------------- */
        else {
            [self appendText:[NSString stringWithFormat:@"%@ - command not found\n",_commandField.stringValue]];;
        }
        usernameWithPathLine = [NSString stringWithFormat:@"Macbook-%@ %@$: waiting for command...\n",_currentPath,username];
        [self appendText:usernameWithPathLine];
        [_commandField setStringValue:@""];
    }
    return YES;
}

- (void) appendText:(NSString*) text{
    [_outputField setStringValue:[[_outputField stringValue] stringByAppendingFormat:text]];
}

- (NSString *)input: (NSString *)prompt defaultValue: (NSString *)defaultValue {
    NSAlert *alert = [NSAlert alertWithMessageText: prompt
                                     defaultButton:@"OK"
                                   alternateButton:nil
                                       otherButton:nil
                         informativeTextWithFormat:@""];
    
    NSTextField *input = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 24)];
    
    [input setStringValue:defaultValue];
    [alert setAccessoryView:input];
    NSInteger button = [alert runModal];
    if (button == NSAlertDefaultReturn) {
        [input validateEditing];
        return [input stringValue];
    } else if (button == NSAlertAlternateReturn) {
        return nil;
    } else {
        NSAssert1(NO, @"Invalid input dialog button %d", button);
        return nil;
    }
}

- (NSString *)secureInput: (NSString *)prompt defaultValue: (NSString *)defaultValue {
    NSAlert *alert = [NSAlert alertWithMessageText: prompt
                                     defaultButton:@"OK"
                                   alternateButton:nil
                                       otherButton:nil
                         informativeTextWithFormat:@""];
    
    NSSecureTextField *input = [[NSSecureTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 24)];
    
    [input setStringValue:defaultValue];
    [alert setAccessoryView:input];
    NSInteger button = [alert runModal];
    if (button == NSAlertDefaultReturn) {
        [input validateEditing];
        return [input stringValue];
    } else if (button == NSAlertAlternateReturn) {
        return nil;
    } else {
        NSAssert1(NO, @"Invalid input dialog button %d", button);
        return nil;
    }
}

@end
