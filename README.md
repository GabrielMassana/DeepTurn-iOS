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
`application(_:open:sourceApplication:annotation:)`


## Example

The example in the code is as simple as possible. If you are going to use DeepTurn, you'll need some type of Manager to handle the whole navigation of your app.

Probably you'll have a strong reference stored of your `rootViewController`. With the RootViewController, you will be able to push or present your deeplinked view.

Deepturn got three open functions to be used:

- mapRoute(): to set up all the routes the app supports.
- mapDefault(): to set up the default route, in case we try to use deeplink, but the route is unknown.
- resolve(): to push a URL to the system.

```swift
// Setting up the Routes

Deepturn.mapRoute(withFormat: "other/viewController/:red/:green/:blue", toDestination: {
            (request: RouteRequest?) in
            
            guard let routeParameters = request?.routeParameters,
                let queryParameters = request?.queryParameters,
                let red = routeParameters["red"],
                let green = routeParameters["green"],
                let blue = routeParameters["blue"],
                let floatRed = Float(red),
                let floatGreen = Float(green),
                let floatBlue = Float(blue) else {
                
                    return
            }
            
            let color = UIColor(red: CGFloat(floatRed) / 255.0,
                                green: CGFloat(floatGreen) / 255.0,
                                blue: CGFloat(floatBlue) / 255.0,
                                alpha: 1.0)

            
            let isAnimated = queryParameters["is_animated"]
            var animated = true
            
            if isAnimated == "false" {
                
                animated = false
            }
            
            let otherViewController = OtherViewController(nibName: nil,
                                                          bundle: nil)
            
            otherViewController.view.backgroundColor = color
            
            rootViewController.present(otherViewController,
                                       animated: animated,
                                       completion: nil)
        })


        Deepturn.mapDefault { (request: RouteRequest?) in
            
        }
        
        
```

Calling a 
```swift
// Calling to resolve a URL 

        let red = String(arc4random_uniform(256))
        let green = String(arc4random_uniform(255))
        let blue = String(arc4random_uniform(255))
        
        var animated = true
        
        if arc4random_uniform(2) == 0 {
            
            animated = false
        }
        
        if let url = URL(string: "other/viewController/\(red)/\(green)/\(blue)/?is_animated=\(animated)") {
            
            Deepturn.resolve(url: url)
        }
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
