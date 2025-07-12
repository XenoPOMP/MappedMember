// The Swift Programming Language
// https://docs.swift.org/swift-book

@attached(accessor)
public macro Mapped(_ title: String) = #externalMacro(module: "MappedMemberMacros", type: "Mapped")
