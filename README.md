# Gesture Controlled Wireless Robot
## Arduino + Image Processing

Image processing is done in the Matlab and for controlling robot, we have used Arduino Controller.
Matlab code is available under Matlab Code directory.
Arduino Code is available under RobotControl directory.

Here, we are processing frame by frame. Once frame is available, we are separating this frame in RGB format.
Once all three images are available, we are iterating through the image matrix for detecting blobs and its centroid.

For detecting different gesture, we are using simple thresholding technique. Based on the distance between fingers and thumb, we are detecting gestures.

For controlling the robot, we are using RKI-1198 and RKI-1197 RF trans-receiver.
Video of the working robot can be found at : https://www.youtube.com/watch?v=_EdzMGvUjpQ
