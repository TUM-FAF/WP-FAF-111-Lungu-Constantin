#Windows Programming, student gr. FAF-111 Lungu Constantin
###Laboratory Work #6 README / Report

##About the application:
* The application contains a image view, a text field, and some buttons - for pasting/copying to that image view or text field (which can also be done by pressing command+v/command+c, or by going to the edit menu), and a button for clearing the clipboard.
* You can drag and drop images, text, files (to get paths)
* You're notified with alerts if you're doing something wrong or just trying to paste something empty

* [Watch the screencast on vimeo](https://vimeo.com/66277359)

![Final](http://oi39.tinypic.com/2kqxp3.jpg)

## Completed objectives:

### Mandatory objectives:
* When pasting (Ctrl+V) a text value, output it in your application using DrawText function
* When the clipboard has no content then output an alert (Message Box) with explanation.
* When the clipboard contains non-text content (link, dif, bitmap...) output an alert (Message Box) with explanation.

### Objectives with points:
* When clipboard contains some specific text (circle, rectangle) then draw/do (on paste) something different from drawing (1 pt)
* When clipboard contains some data in bitmap format or a link to a bitmap, draw that bitmap (on paste) in your application (3 pt)

## Conclusion
Drawing and animating the objects, checking their boundaries on the stage and making them stay in the main view in any case was simple and straightforward for me, the real problem was to check if they intersect each other and if so, to make them bounce one from each other. For that I've made an array in which I store the directions, always. In that way, each and every second I know, for example, that the red ball is moving up, the green one is moving left, and the yellow is moving down.
