// The Swift Programming Language
// https://docs.swift.org/swift-book

@attached(peer, names: arbitrary) @attached(accessor)
public macro Mapped(_ title: String) = #externalMacro(module: "MappedMemberMacros", type: "Mapped")
