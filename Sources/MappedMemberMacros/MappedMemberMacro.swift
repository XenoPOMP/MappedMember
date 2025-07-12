import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

@main
struct MappedMemberPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
//        StringifyMacro.self,
    ]
}
