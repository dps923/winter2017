# Exploring Media and Motion Frameworks

## AVFoundation Framework

On iOS the AV Foundation framework is used for playing sound and video.<br>
The name `AV` is is referring to `Audio/Visual`. 

It is also used for recording and editing sound and video, although we won't be covering that.

https://developer.apple.com/av-foundation/<br>
That link is for future reference and isn't required reading, but it gives you an idea of the comprehensiveness of the API. 

Fortunately, simple media playback -and control of the playback- is straightforward.

Today's sample code `PlayMusic` focuses on playing an mp3 in an app.

https://github.com/garvankeeley/winter2017/blob/edits/notes/week_12/PlayMusic/PlayMusic/ViewController.swift

It has a button for playing/pausing the sound playback, as well as volume.<br>
Please review the view controller class in the code to see how audio playback is performed.

Read this excellent summary of this topic:<br>
https://www.hackingwithswift.com/example-code/media/how-to-play-sounds-using-avaudioplayer

### Playing video

AVPlayer is component to use for this (instead of AVAudioPlayer which we used above).

https://developer.apple.com/reference/avfoundation/avplayer

AVPlayerViewController is a view controller that AVFoundation provides for playing back video full screen, with common video controls (start/stop, volume, time slider, etc.)

https://developer.apple.com/reference/avkit/avplayerviewcontroller

In your UIViewController you would have code like:

```swift
// AVKit is needed to get the handy user interface components for AVFoundation
import AVKit
```
```swift
let url = URL(string: "http://example.com/movie.mov")
let player = AVPlayer(url: url!)

let playerViewController = AVPlayerViewController()
playerViewController.player = player

// UIViewController.present(...) is used in code for showing modal view controllers.
// Alternatively, a modal presentation is setup in the storyboard, and this code
// would be in prepareForSegue, which you are more familiar with.
present(playerViewController, animated: true) {
    playerViewController.player?.play()
}

```

AVPlayer is a nonvisual object -on its own it can't present video on the screen.

> AVKit: The best way to present your video content is by using the AVKit framework’s AVPlayer​View​Controller class in iOS and tvOS or the AVPlayer​View class in macOS.
> These classes present the video content, along with playback controls and other media features giving you a full-featured playback experience.
(Quote from the above apple docs.)


## Device motion sensors using Core Motion framework

From the docs at https://developer.apple.com/reference/coremotion:

## Overview

The Core Motion framework lets your application receive motion data from device hardware and process that data. The framework supports accessing both raw and processed accelerometer data using Block object interfaces. For devices with a built-in gyroscope, you can retrieve the raw gyro data as well as processed data reflecting the attitude and rotation rates of the device. You can use both the accelerometer and gyro-based data for games or other apps that use motion as input or as a way to enhance the overall user experience.

### Important

To access motion and fitness data specifically, it must include NSMotionUsageDescription in the app's Info.plist.

https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW21

We will focus on **Accelerometer** and **Gyroscope**. 

#### Accelerometer

This measures the effect of gravity on the device.

#### Gyroscope

This measures the rate of rotation movement of the device.

<br>
Read up to and include 'Adding the Gyroscope' here:
http://nshipster.com/cmdevicemotion/

Note particularly the diagram showing the X,Y, and Z axis that these sensors provide data for, and descriptions of the sensors.

Today's sample for this is `MotionSwift`, all the interesting code is in the view controller:
https://github.com/garvankeeley/winter2017/blob/edits/notes/week_12/MotionSwift/MotionSwift/ViewController.swift

It shows the effect of these sensors by displaying the X,Y,Z values for the accelerometer and gyroscope.
