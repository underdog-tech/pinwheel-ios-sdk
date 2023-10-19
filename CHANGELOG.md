# Change Log

All notable changes to this project will be documented in this file.

## 2.4.x Releases

- `2.4.x` Releases - [2.4.0](#240)

---
### [2.4.0](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/2.4.0)

#### Notes

- No changes were made to the API contract.
- Improved SDK performance.
- Binary is now published instead of source code.

## 2.3.x Releases

- `2.3.x` Releases - [2.3.10](#2310) | [2.3.11](#2311) | [2.3.12](#2312) | [2.3.13](#2313) | [2.3.14](#2314) | [2.3.15](#2315)

---
### [2.3.15](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/2.3.15)

#### Added

- Add `card_switch_begin` event.
  - Added by [Lynsey Liu](https://github.com/lynsey-pinwheel) in Pull Request [#77](https://github.com/underdog-tech/pinwheel-ios-sdk/pull/77).
- Add `dd_form_begin`, `dd_form_create` and `dd_form_download` events.
  - Added by [Abigail Walker](https://github.com/abbymwalker) in Pull Request [#78](https://github.com/underdog-tech/pinwheel-ios-sdk/pull/78)
- Add `screen_transition` event.
  - Added by [Elena Churilova](https://github.com/elenachurilova) in Pull Request [#80](https://github.com/underdog-tech/pinwheel-ios-sdk/pull/80)

### [2.3.14](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/2.3.14)

#### Added

- Add target field to input_allocation event.
  - Added by [Lynsey Liu](https://github.com/lynsey-pinwheel) in Pull Request [#67](https://github.com/underdog-tech/pinwheel-ios-sdk/pull/67).

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
