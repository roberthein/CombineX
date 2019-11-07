# CombineX([中文](README.zh_cn.md))

[![Github CI Status](https://github.com/cx-org/CombineX/workflows/CI/badge.svg)](https://github.com/cx-org/CombineX/actions)
[![release](https://img.shields.io/github/release-pre/cx-org/combinex)](https://github.com/cx-org/CombineX/releases)
![install](https://img.shields.io/badge/install-spm%20%7C%20cocoapods%20%7C%20carthage-ff69b4)
![platform](https://img.shields.io/badge/platform-ios%20%7C%20macos%20%7C%20watchos%20%7C%20tvos%20%7C%20linux-lightgrey)
![license](https://img.shields.io/github/license/cx-org/combinex?color=black)
[![dicord](https://img.shields.io/badge/chat-discord-9cf)](https://discord.gg/9vzqgZx)

`CombineX` is an open source implementation for Apple's [Combine](https://developer.apple.com/documentation/combine). Its API is consistent with `Combine`, which can be used as a `Combine` polyfill on iOS 8, macOS 10.10 and Linux to help you get rid of system limitations and platform limitations.

🐱

> Disclaimer: we are doing our best to move toward the goal of "Exactly the Same", but we must admit that there is still a long way to go. Therefore, we do not recommend using 'CombineX' in a serious production environment. It is encouraged to use `CombineX` in experimental personal projects. Welcome to feedback your experience! Our plan is to release a trustable 0.9.0 by the end of 2019, when 1.0.0 will be just one step away.

## Support

- iOS 8+ / macOS 10.10+ / tvOS 9+ / watchOS 2+
- Linux

## What is Combine

`Combine` is a reactive framework launched by Apple at WWDC 2019, which refers to the interface design of [ReactiveX](http://reactivex.io/) and provides Apple's preferred implementation for Swift asynchronous programming. It will definitely be the cornerstone of Swift programming in the foreseeable future.

## What is CombineX

`CombineX` is an open source implementation of `Combine`. In addition to having an API consistent with `Combine`, it has the following advantages:

### 1. Systems and Platforms

- `Combine` has very high system version restrictions: macOS 10.15+, iOS 13+. This means, even if your app only needs to be compatible with three versions forward, it will take three or four years before you can use `Combine`. 
- `Combine` is exclusive to the Apple platform and does not support Linux, so you can't share codebases between apple and linux.

`CombineX` can help you get rid of these limitations, it supports macOS 10.10+, iOS 8+ and Linux.

### 2. Open source

`Combine` is closed source, it is like `UIKit`, `MapKit`, etc., updated with the update of Xcode. When you encounter a bug, "you should have encountered a system library bug", debugging is very annoying, but more annoying is the slow official response, usually, you can't do anything but wait for the next regular update of Xcode.

`CombineX` is completely open source, in addition to being able to debug line by line, you can also get faster community response!

### 3. Extensions

With `CombineX`, you are free to develop `Combine` related frameworks without worrying about system version and platform limitations:

- [CXCocoa](https://github.com/cx-org/CXCocoa): provides `Combine` extensions to `Cocoa`, such as `KVO+Publisher`, `Method Interception`, `UIBinding`, `Delegate Proxy`, etc. Based on `CombineX` by default, you are free to switch to `Combine`.
- [CXExtensions](https://github.com/cx-org/CXExtensions): provides a collection of useful extensions for `Combine`, such as `IgnoreError`, `DelayedAutoCancellable`, etc. Based on `CombineX` by default, you are free to switch to `Combine`.

## Join Us

Want to get involved? Awesome! **`CombineX` really needs your help now**! 🆘🆘🆘

#### Project Management

We need help with project management!

`CombineX` is the first time I organize such a large open source project. It is based on a whim, driven by my enthusiasm for Swift and open source. I like writing code and implementing things, but now, I spend more time on organizing and deploying than writing code. We really need someone to help manage the entire project, including [cx-org] (https://github.com/cx-org) and [cx-community] (https://github.com/cx-community).

#### Looking for bugs

You can help `CombineX` find bugs.

`CombineX` uses tests to ensure that it is consistent with the behavior of `Combine`. But at the moment, the number of tests is far from enough, and there are still many edge cases that are not considered. You can add more tests to improve the quality of `CombineX`. First, make sure the `Specs` scheme passes your test. If the `CombineX` scheme doesn't pass, you've found a `CombineX` bug! You can give us feedback via issue, or - fix it directly!

#### Improving implementation

`CombineX` was originally a side project of me. Due to time, there are a lot of things that can be done better. Currently, only the implementation of the functions is guaranteed. You can improve them, whether it is about performance, security, or readability. I will also focus on this part next.

#### Participating in the discussion of issue and pr

You can also participate in the discussion of the issue and pr, answer other people's questions, and review the code.

Participation doesn't have to be related to the code, and it's even simpler, star! then tell your friends!

### Contribution flow

Open `Package.swift` directly with xcode 11, don't use `CombineX.xcodeproj`, it only exists for carthage.

## Installation

### Swift Package Manager(Recommended)

```swift
dependencies.append(
    .package(url: "https://github.com/cx-org/CombineX", .branch("master"))
)
```

### CocoaPods

```ruby
pod 'CombineX', :git => 'https://github.com/cx-org/CombineX.git', :branch => 'master'
```

### Carthage

```carthage
github "cx-org/CombineX" "master"
```
