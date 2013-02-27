#Windows Programming, student gr. FAF-111 Lungu Constantin
###Laboratory Work #1 README / Report

##About the application:

* The application is all about fruits. It has two columns which are text labels, four buttons (two add and two clear buttons), two text field inputs, and a header title image. It lets you add fruits you like to the first column, and fruits you dislike to the second one (by pressing enter in the text field or by clicking the "Add" button on top of the columns). If a fruit is already in the list, it won't let you add it again (with an nice alert). You can also clear the lists if you want to begin from scratch. The labels, buttons and text fields are set to align to the right or left borders. The default and minimum window size is 480x360. 
* The application follows a [Model-View-Controller](http://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) software pattern. The model is the data we give to the app, the view is the nib file called MainMenu.xib, and the controller are the header and implementation files AppDelegate.h and AppDelegate.m. I've also put some credits, which are available at "About" application tab.
* I followed the [Apple programming style for Cocoa development](https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/CodingGuidelines/CodingGuidelines.html) and also the offered [C style guide](https://github.com/nickbjohnson4224/rhombus/wiki/C-style-guide).
* I used the interface builder and I've done connections by ctrl-dragging, which I found very useful back ago in iOS dev.
* Used frameworks are: AppKit, CoreData and Foundation.
* The UI elements are mixed and different, they have different sizes and fonts, different styles.
* I got the list of fruits from [wikipedia](http://simple.wikipedia.org/wiki/List_of_fruits).
* The application is built on Xcode 4.3.3 running on Mac OS X 10.7.3.
* The application looks like this:
 
![Final](http://oi54.tinypic.com/67o280.jpg)

## Completed objectives:

### Mandatory objectives:
* Created an application
* Chose and followed PSGs
* Added 2 (in my case, 4) buttons
* Added 2 text fields
* Added 2 text inputs

### Objectives with points:
* Made elements to fit the window when it's resized
* Made elements to interact with other elements

## Conclusion
Even though I've been staying late nights in Xcode, this is the first Cocoa application that I've made, and frankly, it was a lot of fun. I hope I've explained and documented the code pretty good so it'll be easy to understand. I've used some rudimentary Objective-C and some simple actions, outlets.
