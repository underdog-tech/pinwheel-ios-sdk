import Foundation

public struct PinwheelDDFormCreatePayload: PinwheelEventPayload {
    public init(url: String) {
        self.url = url
    }

    public let url: String
}
