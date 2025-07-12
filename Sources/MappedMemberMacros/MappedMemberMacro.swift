import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct Mapped: PeerMacro {
    public static func expansion(of node: SwiftSyntax.AttributeSyntax, providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {
        guard
              // Parse string argument
              let arguments = node.arguments,
              let expression = arguments.as(LabeledExprListSyntax.self)?.first?.expression,
              let string = expression.as(StringLiteralExprSyntax.self),
              // Parse type annotation
              declaration.is(VariableDeclSyntax.self),
              let decl = declaration.as(VariableDeclSyntax.self),
              let type = decl.bindings.first?.typeAnnotation?.type else {
            return []
        }
        
        return [
            """
            {
                get { self[keyPath: \(raw: string.segments)] }
                set { self[keyPath: \(raw: string.segments)] = newValue }
            }
            
            private var \(string.segments): \(type)
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
