# Change Log

All notable changes to this project will be documented in this file.

## 3.0.x Releases

- `3.0.x` Releases - [3.0.0](#300) | [3.0.1](#301) | [3.0.2](#302) | [3.0.3](#303) | [3.0.4](#304)

---

### [3.0.4](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/3.0.4)

#### Notes

- Add `NSPrivacyCollectedDataTypePaymentInfo` entry to privacy manifest

### [3.0.3](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/3.0.3)

#### Notes

- Add privacy manifest

### [3.0.2](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/3.0.2)

#### Notes

- Expand internal functionality to support a broader range of platforms and increase conversion rate.

### [3.0.1](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/3.0.1)

#### Notes

- Internal contract changes to standardize UI.

### [3.0.0](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/3.0.0)

This new major version bump introduces an updated API to support partner-based switches.

*Deprecated events have been removed and we have updated the success event to match the current standard switch schema (used in the `direct_deposit_switch.added` webhook and the `input_allocation` event).*

#### Changed
- The `action` field in `input_allocation` event is now optional.
- The `params` field in the `success` event uses the `input_allocation` schema with fields `action` and `allocation`.

#### Removed
- Removed `input_amount` event.


## 2.4.x Releases

- `2.4.x` Releases - [2.4.0](#240) | [2.4.1](#241) | [2.4.2](#242) | [2.4.3](#243) | [2.4.4](#244) | [2.4.5](#245) | [2.4.6](#246) | [2.4.7](#247) | [2.4.8](#248) | [2.4.9](#249)

---

### [2.4.9](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/2.4.9)

#### Notes

- Add `NSPrivacyCollectedDataTypePaymentInfo` entry to privacy manifest

### [2.4.8](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/2.4.8)

#### Notes

- Add privacy manifest

### [2.4.7](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/2.4.7)

#### Notes

- Expand internal functionality to support a broader range of platforms and increase conversion rate.

### [2.4.6](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/2.4.6)

#### Notes

- Internal contract changes to standardize UI.

### [2.4.5](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/2.4.5)

#### Notes

- Internal contract changes.

### [2.4.4](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/2.4.4)

#### Notes

- Adding more support for consumption by Pinwheel's React Native SDK.

### [2.4.3](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/2.4.3)

#### Notes

- Adding support for consumption by Pinwheel's React Native SDK.

### [2.4.2](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/2.4.2)

#### Notes

- Display context to user when showing external website.

### [2.4.1](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/2.4.1)

#### Notes

- **Increased Platform Support**: 🌌 Enabled broader platform support and conversion increasing functionality under the hood.

### [2.4.0](https://github.com/underdog-tech/pinwheel-ios-sdk/releases/tag/2.4.0)

#### Notes

We're thrilled to announce the latest version of our SDK! While you'll find that our familiar API contract remains unchanged, there's a host of improvements that make this upgrade indispensable:

- **Enhanced Redundancy**: 🛡️ We've fortified our systems, ensuring smoother recovery from integration failures for a significant percentage of our traffic.
- **Superior Uptime**: 🦾 Reliability is a top priority. This upgrade brings even more robust uptime for DDS integrations.
- **Increased Conversion**: ↗️ We are leveraging system level features to increase conversion.
- **Easy Upgrade**: 🥧 No changes were made to the API contract. Easy as pie.

*Note*: Binary is now published instead of source code.


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
