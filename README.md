# PinwheelSDK

The Pinwheel SDK is used to open up as a modal in your application. Through the modal, end-users can select their employer, authenticate with their payroll platform login credentials, and authorize the direct deposit change.

## Usage

The Pinwheel iOS SDK's main interface is a `UIViewController` that you can integrate into your app as you would any `UIViewController`, e.g. presented as a modal, or used with a `UINavigationController`. Additionally, you can implement the `PinwheelDelegate` protocol to receive events throughout the `PinwheelViewController`'s lifecycle.

### Installation

The Pinwheel iOS SDK is available via [CocoaPods](https://cocoapods.org/).

To install the SDK with CocoaPods, add `PinwheelSDK` as one of your target dependencies in your Podfile:

```ruby
use_frameworks!

target 'MyApp' do
    pod 'PinwheelSDK'
end
```

Please be sure to run `pod update` and use `pod install --repo-update` to ensure you have the most recent version of the SDK installed.

### Link Token

To initialize the `PinwheelViewController`, a short-lived Link token will need to be generated first. Your server can generate the Link token by sending a POST request to the `/v1/link_tokens` endpoint with details about the direct depoist update. Your mobile app should fetch the link token from your server. DO NOT ever send this request from the client side and publicly expose your api_secret.

The link token returned is valid for 15 minutes, after which it expires and can no longer be used to initialize the `PinwheelViewController`. The expiration time is returned as a unix timestamp.

### PinwheelViewController

The PinwheelViewController is a `UIViewController` that you can integrate into your app's flow like so:

```swift
import PinwheelSDK

let pinwheelVC = PinwheelViewController(token: linkToken, delegate: self)
self.present(pinwheelVC!, animated: true)
```

With the `PinwheelViewController`, end-users can select their employer, authenticate with their payroll platform login credentials, and authorize the direct deposit change. Throughout the authorization process, events will be emitted to the `onEvent` callback. Upon a successful authorization, the `onSuccess` callback will be called. `onExit` will be called when it is time to close the dialog, and you should remove the PinwheelLink component from your view hierarchy.

## PinwheelDelegate

The `PinwheelDelegate` protocol is set up such that every event goes through the required `onEvent(name: event:)` handler, and optional convenience methods are provided for the `.exit`, `.success`, `.login`, and `.error` events. Note that the `onEvent(name: event:)` handler will still be called alongside the convenience methods.   

### `onEvent(name: PinwheelEventType, event: PinwheelEventPayload)`

Callback whenever a user interacts with the modal (e.g. logs in, or initiates a switch). See the [events section](https://getpinwheel.stoplight.io/docs/api/docs/guides/Link.md#events) of the Link documentation.

### `onExit(_ error: PinwheelError?)`

Optional callback whenever a user exits the modal either explicitly or if an error occurred that crashed the modal. Error codes can be seen [here](https://getpinwheel.stoplight.io/docs/api/docs/guides/Link.md#errors-1).

### `onSuccess(_ result: PinwheelSuccessPayload)`

Optional callback whenever a user completes a Link flow successfully. Note: This is simply a front end callback only. If a user begins a job, closes the app, and the job completes successfully this callback will not be called.

### `onLogin(_ result: PinwheelLoginPayload)`

Optional callback for when a user logs in successfully.

### `onError(_ error: PinwheelError)`

Optional callback for when an error occurs.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first. Then, add your API secret to the top of the LinkToken.swift file. In your app, you should fetch the Link token from your server, and you should never include your API secret in your app.

## Author

[Pinwheel](https://getpinwheel.com)

## License

PinwheelSDK is available under the MIT license. See the LICENSE file for more info.
