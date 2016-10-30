enum DataDeclarationKind {
    case byte([Int8])
    case halfword([Int16])
    case word([Int32])
    case ascii(String, terminated: Bool)
    case space(Int)
}
