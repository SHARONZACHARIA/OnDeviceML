# On Device Machine Learning in Flutter using TFLite model

This repository is to show how to use a textclassification model build on keras can be used on flutter app for on device inference

## Intro

Machine learning can be implemented on mobile platforms using a REST API.But what if we can use a model locally from the mobile device and make inference on it , this would help in offline use of models. Tensor Flow Lite models can be easily loaded on a mobile device and  can be used  as needed. 

* We will see how to make a text classification app which can detect offensive sentences.
* Build a Keras model.
* Save the model and convert it into tflite format.
* Load the model on mobile platform(android).
* Use flutter's platform specific  channel to communicate with java code to make inferences.
