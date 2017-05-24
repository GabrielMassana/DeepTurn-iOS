# DeepTurn-iOS

##   What is it?

DeepTurn is a Swift tool to enable deeplinking in iOS apps.

It is based in [Turnpike](https://cocoapods.org/pods/Turnpike), an Objective-C pod with the same purpose.
The original project was created by James Lawrence Turner.

## Deeplink Concept

The core concept of deeplinking is to allow to open any view of you app from other apps.

With the Associated Domains capability we can easily open the app from anywhere. With Deeplink we can also open any view. 

To use deeplink we need to set up the proper internal architecture. To do so, we will use URL scheme to internally navigate the app.

DeepTurn will help to do it.

To do the job, we will need to set up Associated Domains and Register a Custom URL Scheme. 

## Installation

#### Podfile

```ruby
platform :ios, '9.0'
pod 'DeepTurn'
```

Then, run the following command:

```bash
$ pod install
```

## Setup Associated Domains

Follow [this how to guide](https://blog.branch.io/how-to-setup-universal-links-to-deep-link-on-apple-ios-9/)

You will also need to add this to your Info.plist:

```json
<key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>CFBundleURLName</key>
            <string>com.company.app</string>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>com.company.app</string>
            </array>
        </dict>
    </array>

```
Also, you'll need to catch any URL comming from outside the app in the AppDelegate:
'application(_:open:sourceApplication:annotation:)'


## Example

The example in the code is as simple as possible. If you are going to use DeepTurn, you'll need some type of Manager to handle the whole navigation of your app.

Probably you'll have a strong reference stored of your 'rootViewController'. With the RootViewController, you will be able to push or present your deeplinked view.

Deepturn got three open functions to be used:

- mapRoute(): to set up all the routes the app supports.
- mapDefault(): to set up the default route, in case we try to use deeplink, but the route is unknown.
- resolve(): to push a URL to the system.

```swift
//Code example here

```

## License

DeepTurn-iOS is released under the MIT license. Please see the file called LICENSE.

## Versions

```bash
$ git tag -a 0.1.0 -m 'Version 0.1.0'

$ git push --tags
```

## Author

Gabriel Massana

## Found an issue?

Please open a [new Issue here](https://github.com/GabrielMassana/DeepTurn-iOS/issues/new) if you run into a problem specific to DeepTurn-iOS, have a feature request, or want to share a comment.
