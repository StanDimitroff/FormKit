import FormKit

struct User: Bindable, FormModel {
  typealias Model = Self

  var name: String
  var age: Int
}


struct Student: FormModel {
  var classNumber: Int
  var subject: String
}
