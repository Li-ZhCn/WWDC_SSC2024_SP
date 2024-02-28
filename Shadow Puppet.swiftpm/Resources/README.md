#  README

## Beyond the Swift Student Challenge
This is a gift I gave to the shadow play troupe in my hometown. When I was a boy, my village once invited this troupe over to perform. I was very excited when I saw various magical characters moving with the sound of drums and gongs, which made me want to try it myself. Therefore, during this WWDC, I personally visited many museums where shadow puppets were exhibited and watched many performances, thus producing this work. 

I shared it with many people around me, even the shadow play performers, and received a lot of praise. In particular, the spacial pinching operation similar to Vision Pro, which breaks through the two-dimensional limit of the screen, allows people to experience the process of shadow play more immersively. Shadow play art is the heritage of human culture in the world, and I believe this work can make people better understand this kind of art.

## Features and technologies you used.
* Vision: To detect and recognize user's fingers, allowing user to control the puppet by pinching and moving hands.
* SwiftUI: Most of the views were made based on SwiftUI.
* SpriteKit: Puppet scene was made by SpriteKit. Inverse kinematics were used to manipulate the puppet.
* UIKit: Live camera preview was used as input of Vision Framework and also to help user to play.
* Accelerate: The output of Vision Framework was filtered by certain method, in which Accelerate played an essential part.

## Open source software used
* ToyViewer: This is used to precisely rotate and resize images.
* GarageBand: All the background music and sound effects are made it.

## Comments
I am a student in the iOS Club in UESTC. As a beginner in Swift, this is my first time to participate in this activity.

This app consists 4 major parts. The first one is like a Costume game and all the chosen items will be introduced in the second part(To Learn More). User then can modify settings in the 3rd part.

The most attractive part is the 4th part. This is a simple app integrated with Vision Framework, so that these shadow puppets can be manipulated in a way that similar to Vision Pro! Instead of just touching  the screen, this could be more immersive just like that we are really having a stick, by which we can move the joint of puppets.

Maybe in the future, I will explore more towards this direction, transplanting more spacial gestures from VisionOS to iOS. I think it is promising.


## Others
Some images of puppet were made based on pictures shot by myself in the Museum of Wang Pi Yeng in Sichuan, China.


