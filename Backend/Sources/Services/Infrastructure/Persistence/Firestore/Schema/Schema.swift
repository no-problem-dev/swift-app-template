import FirestoreSchema

@FirestoreSchema
public struct TodoAppSchema {
    @Collection("users", model: FirestoreProfile.self)
    enum Users {}
}
