import Foundation

final class GestaltTweaks {
    func applySystemFeatureFlags(
        dictionary: [String: Any],
        targetPath: String
    ) -> Bool {
        NSLog(
            "[GestaltTweaks] System modification is unavailable in this jailed build."
        )

        return false
    }
}
