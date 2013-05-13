#Windows Programming, student gr. FAF-111 Lungu Constantin
###Laboratory Work #4 README / Report

##About the application:

* The application consists of a button "Start", buttons "+" and "-" and a checkbox called "Randomize directions on start"
* "Start" button starts the animation, if there are any balls on the screen (you can click to add one, no matter if the screen is currently animating anything or not)
* "+" and "-" buttons are for changing the speed animation, which in this case is directly changing the velocity of the balls (I haven't found a way to listen to the mouse wheel events in OS X)
* If "Randomize" checkbox is enabled, on every stop & start action the balls will have a new direction, and if not they will always have the same one that's been randomly chosen in the beginning, until bumping one into another.
* There is a maximum and minimum velocity for the balls (3 and 0.1 pixels every frame)
* Flicking problem was solved by making the balls properties of the mainView controller.
* [Watch the screencast on vimeo](https://vimeo.com/66082415)

![Final](http://oi42.tinypic.com/2nj66q.jpg)

## Completed objectives:

### Mandatory objectives:
* Create an animation based on a timer which involves at least 5 different drawn objects

### Objectives with points:
* Increase and decrease animation speed using mouse wheel (2 pt)
* Solve flicking problem (2 pt) 
* Add animated objects which interact with each other (2-6 pt) (added checking for a ball hitting another ball, also bumping back on hit)

## Conclusion
Drawing and animating the objects, checking their boundaries on the stage and making them stay in the main view in any case was simple and straightforward for me, the real problem was to check if they intersect each other and if so, to make them bounce one from each other. For that I've made an array in which I store the directions, always. In that way, each and every second I know, for example, that the red ball is moving up, the green one is moving left, and the yellow is moving down.
