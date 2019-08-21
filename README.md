
# On Device Machine Learning in Flutter using TFLite model

This repository is to show how to use a textclassification model build on keras can be used on flutter app for on device inference.


## Intro

Machine learning can be implemented on mobile platforms using a REST API.But what if we can use a model locally from the mobile device and make inference on it , this would help in offline use of models. Tensor Flow Lite models can be easily loaded on a mobile device and  can be used  as needed. 

![](https://github.com/SHARONZACHARIA/OnDeviceML/blob/master/1_jM9g4p6g8k3FYquSG5l1gw.jpeg)

We will see how to make a text classification app which can detect offensive sentences.
* Build a Keras model.
* Save the model and convert it into tflite format.
* Load the model on mobile platform(android).
* Use flutter's platform specific  channel to communicate with java code to make inferences.

#### Keras
Keras is an open-source neural-network library written in Python. It is capable of running on top of TensorFlow, Microsoft Cognitive Toolkit, Theano, or PlaidML. Designed to enable fast experimentation with deep neural networks, it focuses on being user-friendly, modular, and extensible.

#### TFLite
TensorFlow Lite is a set of tools to help developers run TensorFlow models on mobile, embedded, and IoT devices. It enables on-device machine learning inference with low latency and a small binary size.

#### Flutter
Flutter is an open-source mobile application development framework created by Google. It is used to develop applications for Android and iOS, as well as being the primary method of creating applications for Google Fuchsia. 
