import Foundation

class GestaltTweaks {
    
    let bridge = WorseQueryBridge()
    
    func applySystemFeatureFlags(dictionary: [String: Any], targetPath: String) -> Bool {
        print("[GestaltTweaks] Pre-processing dictionary configuration for target path...")
        
        // Route parameter compilation down to the modified Objective-C bridge stream
        let success = bridge.writeExploitData(dictionary, toPath: targetPath)
        
        if success {
            print("[GestaltTweaks] Data written cleanly. Flushing local framework caches...")
            invalidateSystemCache(isFeatureFlagsPath: targetPath.contains("FeatureFlags"))
        }
        
        return success
    }
    
    private func invalidateSystemCache(isFeatureFlagsPath: Bool) {
        // Forces background preference tasks to recycle so changes load instantly
        let targetProcessName = isFeatureFlagsPath ? "com.apple.preferences.FeatureFlags.xpc" : "MobileGestaltHelper"
        
        let process = Process()
        process.launchPath = "/usr/bin/killall"
        process.arguments = ["-9", targetProcessName]
        
        DispatchQueue.global(qos: .utility).async {
            process.launch()
            process.waitUntilExit()
            print("[GestaltTweaks] System cache invalidation cycle finished.")
        }
    }
}
