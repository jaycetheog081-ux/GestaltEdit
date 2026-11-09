// MARK: - Editor Support Types

enum GestaltTweakCategory: String, CaseIterable, Identifiable {
    case region
    case appearance
    case system

    var id: String { rawValue }

    var label: String {
        switch self {
        case .region: "Region"
        case .appearance: "Appearance"
        case .system: "System"
        }
    }
}

enum GestaltTweakID: String, Hashable, Identifiable {
    case enableLiquidGlassLowPerformance
    case disableLiquidGlassLowPerformance

    var id: String { rawValue }
}

struct GestaltTweakDefinition: Identifiable {
    let id: GestaltTweakID
    let category: GestaltTweakCategory
    let title: String
    let detail: String
    let isRisky: Bool
    let previewKey: String
    let previewValue: Any
}

enum GestaltTweakCatalog {
    static let definitions: [GestaltTweakDefinition] = []

    static func definition(
        for id: GestaltTweakID
    ) -> GestaltTweakDefinition? {
        definitions.first { $0.id == id }
    }
}

struct DynamicIslandOption: Identifiable {
    let subtype: Int
    let title: String

    var id: Int { subtype }

    static let all: [DynamicIslandOption] = []
}

// MARK: - Local Plist Editing

extension GestaltPlist {
    mutating func apply(
        definition: GestaltTweakDefinition
    ) throws {
        setCacheExtra(
            definition.previewValue,
            forKey: definition.previewKey
        )
    }

    mutating func setDynamicIslandSubtype(
        _ subtype: Int
    ) throws {
        setCacheExtra(
            subtype,
            forKey: "ArtworkDeviceSubType"
        )
    }

    mutating func setModelName(
        _ name: String
    ) throws {
        setCacheExtra(
            name,
            forKey: "GestaltEditPreviewModelName"
        )
    }
}
