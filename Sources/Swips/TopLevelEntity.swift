/// Represents a Top-Level entity that has a static address
/// in the compiled binary.
protocol TopLevelEntity {
    /// The label that will resolve to this entity.
    var label: String { get }
}
