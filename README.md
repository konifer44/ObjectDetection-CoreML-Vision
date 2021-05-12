# ObjectDetection-CoreML-Vision
In this project Im using CoreML and Vision to detect object from photos imported form photo gallery or live capture using iPhone camera. In first case We choose photo with ImagePicker(To integrate UIKit and SwiftUI im using UIViewRepresentable) then CoreML proccesing it and returns array with detected objects and confidence. In the second case the Vision framework can recognize objects in live capture. Vision requests made with a Core ML model return results as VNRecognizedObjectObservation objects, which identify objects found in the captured scene and also returning it coordinates.

<h3>Screenshots</h3>
<p align="center">
  <img src="1.GIF" alt="drawing" width="200"/>
  <img src="1.png" alt="drawing" width="200"/>
  <img src="2.png" alt="drawing" width="200"/>
  <img src="3.png" alt="drawing" width="200"/>
 </p>
