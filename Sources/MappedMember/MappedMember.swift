// The Swift Programming Language
// https://docs.swift.org/swift-book

@attached(peer, names: arbitrary)
public macro Mapped(_ title: String) = #externalMacro(module: "MappedMemberMacros", type: "Mapped")
