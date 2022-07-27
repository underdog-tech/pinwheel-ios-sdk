# Change Log

All notable changes to this project will be documented in this file.

## 2.3.x Releases

- `2.3.x` Releases - [2.3.10](#2310) | [2.3.11](#2311)

---
### [2.3.13](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/2.3.13)

#### Added

- Add support for input_allocation event.
  - Added by [Robby Abaya](https://github.com/rawbee) in Pull Request [#63](https://github.com/underdog-tech/pinwheel-ios-sdk/pull/63).

### [2.3.12](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/2.3.11)

#### Fixed

- Fixed a memory leak bug where the Pinwheel object was retaining a reference to its delegate.
  - Added by [Robby Abaya](https://github.com/rawbee) in Pull Request [#54](https://github.com/underdog-tech/pinwheel-ios-sdk/pull/62).

#### Added

- Added additional safety around local storage access.
  - Added by [Robby Abaya](https://github.com/rawbee) in Pull Request [#50](https://github.com/underdog-tech/pinwheel-ios-sdk/pull/62).

- Added additional configuration options to support different Pinwheel environments.
  - Added by [Robby Abaya](https://github.com/rawbee) in Pull Request [#50](https://github.com/underdog-tech/pinwheel-ios-sdk/pull/60).

- Added additional device metadata information
  - Added by [Robby Abaya](https://github.com/rawbee) in Pull Request [#49](https://github.com/underdog-tech/pinwheel-ios-sdk/pull/60).

### [2.3.11](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/2.3.11)

#### Fixed

- Fixed bug where PinwheelEventType.inputRequired was not being sent.
  - Added by [Robby Abaya](https://github.com/rawbee) in Pull Request [#54](https://github.com/underdog-tech/pinwheel-ios-sdk/pull/54).

### [2.3.10](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/2.3.10)

#### Added

- PinwheelEventType.inputRequired
  - Added by [Robby Abaya](https://github.com/rawbee) in Pull Request [#50](https://github.com/underdog-tech/pinwheel-ios-sdk/pull/50).

#### Updated

- Move webview initialization earlier in lifecycle
  - Added by [Robby Abaya](https://github.com/rawbee) in Pull Request [#49](https://github.com/underdog-tech/pinwheel-ios-sdk/pull/49).
