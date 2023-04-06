import Foundation

public struct PinwheelDDFormCreate: PinwheelEventPayload {
    public init(url: String) {
        self.url = url
    }

    public let url: String
}
