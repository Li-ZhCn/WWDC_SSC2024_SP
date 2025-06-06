# WWDC SSC 24 ACCEPTED 🎉
This app was developed for the Apple Swift Student Challenge as a 3-minute demo showcasing a hands-free interactive experience.

Leveraging the latest advancements introduced by Apple in 2024—specifically the Vision Framework and Core ML—the app demonstrates real-time image and video analysis through on-device machine learning. These frameworks now support training and deploying custom models, enabling highly responsive and efficient visual recognition directly on Apple devices.

Built upon this new functionality, the app presents an intuitive game interface that users can control through contactless pinch gestures, mirroring the interaction style of Apple Vision Pro. By simply pinching in the air, players can seamlessly navigate and interact with the UI, offering a futuristic, immersive user experience without the need for physical touch.

## Technologies used.

* Vision: To detect and recognize user's fingers, allowing user to control the puppet by pinching and moving hands.
* SwiftUI: Most of the views were made based on SwiftUI.
* SpriteKit: Puppet scene was made by SpriteKit. Inverse kinematics were used to manipulate the puppet.
* UIKit: Live camera preview was used as input of Vision Framework and also to help user to play.
* Accelerate: The output of Vision Framework was filtered by certain method, in which Accelerate played an essential part.

## Open source software used

* ToyViewer: This is used to precisely rotate and resize images.
* GarageBand: All the background music and sound effects are made it.

## Others

Some images of puppet were made based on pictures shot by myself in the Museum of Wang Pi Yeng in Sichuan, China.
