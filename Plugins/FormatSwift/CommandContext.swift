import PackagePlugin
#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin
#endif

// MARK: - CommandContext

protocol CommandContext {
    var pluginWorkDirectory: Path { get }
    func tool(named name: String) throws -> PluginContext.Tool
}

// MARK: - PluginContext + CommandContext

extension PluginContext: CommandContext { }

#if canImport(XcodeProjectPlugin)
extension XcodePluginContext: CommandContext { }
#endif
