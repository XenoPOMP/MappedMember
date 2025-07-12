import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct Mapped: AccessorMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingAccessorsOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.AccessorDeclSyntax] {
        guard let title = node.arguments?.as(LabeledExprListSyntax.self)?.first?.expression else {
            return []
        }
        
        return [
            """
            get { self[keyPath: \(title)] }
            """,
            """
            set { self[keyPath: \(title)] = newValue }
            """
        ]
    }
  }

@main
struct MappedMemberPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        Mapped.self
    ]
}
