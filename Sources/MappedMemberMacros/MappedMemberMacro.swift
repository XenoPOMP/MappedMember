import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct Mapped {}

extension Mapped: PeerMacro {
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
            private var \(string.segments): \(type)
            """
        ]
    }
}

extension Mapped: AccessorMacro {
    static public func expansion(of node: AttributeSyntax, providingAccessorsOf declaration: some DeclSyntaxProtocol, in context: some MacroExpansionContext) throws -> [AccessorDeclSyntax] {
        guard
              // Parse string argument
              let arguments = node.arguments,
              let expression = arguments.as(LabeledExprListSyntax.self)?.first?.expression,
              let string = expression.as(StringLiteralExprSyntax.self)
        else {
            return []
        }
        
        return [
            """
            get { self[keyPath: \\.\(raw: string.segments)] }
            """,
            """
            set { self[keyPath: \\.\(raw: string.segments)] = newValue }
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
