[![codecov](https://codecov.io/gh/vkaltyrin/todo-app/branch/master/graph/badge.svg)](https://codecov.io/gh/vkaltyrin/todo-app)
[![build](https://app.bitrise.io/app/9f1773480cfe7214/status.svg?token=VFT7EQT-yhjEAgOvYBZQNw&branch=master)]

# Todo App

This project is an example of implementation in Clean Swift architecture.

# Table of contents

* [Notes on implementation](#notes)
  * [General](#general)
  * [Architecture](#architecture)
  * [DI](#di)
  * [Tests](#tests)
  * [UI Tests](#uitests)

## Notes on implementation

### General

<a name="general"/>

Each screen should support use cases for creating, deleting and updating items in the list. 
Task screen also support toggling feature. It's possible to mark task as a completed one.

### Architecture

<a name="architecture"/>

Each screen is represented as a VIP module. Communication between components is done with protocols. 

![Clean architecture](https://cdn-images-1.medium.com/max/2000/1*QV4nxWPd_sbGhoWO-X7PfQ.png)

There is a following idea in the VIP cycle. User produces a sequence of events. View handles it and asks interactor to start a business logic. Interactor holds Services (Storages, Providers, etc). When Interactor receives data from Service then it asks Presenter to map this data to the ViewModel and to present the update on the View. Then this cycle is repeated. ViewController can also ask router to present a screen.

Finally, I modified canonical VIP arhitecture and transfered state to Presenter. This idea improved testability and helped to abstract the UIKit by protocols. The main issue in writing tests for iOS apps usually are tightly coupled UIKit classes. For this reason I developed TableManager protocol and implementation to hide the UITableView logic and to improve testability. 

### DI

<a name="di"/>

At that moment, there is no dependency injection framework. But I consider to add it as a feature improvement.
For each module, there is an Assembly which is supposed to manage dependencies.

### Tests

<a name="tests"/>

Each layer of the app is covered by unit tests. Currently, unit tests are implemented using XCTest.
Mock generation in Swift with Xcode is a pain, that's why I'm using an AppCode IDE which provides the nice open-source plugin for a mock generation.

### UI Tests

<a name="uitests"/>

There is a proof of concept of UI tests using the EarlGrey framework. 
The next improvement in term of UI tests is to add more test cases.
