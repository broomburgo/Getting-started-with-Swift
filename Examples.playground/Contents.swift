import XCTest

var numbers = Array(1..<100)

var found42 = false

for number in numbers {
	if number == 42 {
		found42 = true
	}
}

if found42 {
	print("insert 42 meme here")
}

//: ---

let text = "42"

let maybeFortyTwo = Int(text) /// Int?

//let eightyFour = maybeFortyTwo * 2 /// ERROR

func optional() {
	guard let fortyTwo = maybeFortyTwo else {
		/// do something else
		return
	}
	
	let eightyFour = fortyTwo * 2 /// Int
}
//: ---

let toInt: (Character) -> Int = { Int(String($0))! }
let isEven: (Int) -> Bool = { $0 % 2 == 0 }

let sumOfEvens = "0123456789"

	.characters
	
	.map(toInt)

	.filter(isEven)
	
	.reduce(0, +)

//: ---

enum HTTPCode: Int {
	case OK = 200
	case notFound = 404
	case internalServerError = 500
}

let receivedCode = HTTPCode(rawValue: 404)!
switch receivedCode {
case .OK:
	print("good job")
default:
	print("BUUUUUUUG")
}

//: ---

enum ConnectionResponse {
	case OK(output: Any)
	case notFound(error: String)
	case internalServerError(error: String)
}

let receivedResponse = ConnectionResponse.notFound(error: "There's nothing here")
switch receivedResponse {
case .notFound(let error):
	print(error)
case .internalServerError(let error):
	print(error)
default:
	print("good job")
}

//: ---

let tableOf3_0 = (1...10).map({ value in
	return value*3
})


let tableOf3_1 = (1...10).map { value in
	return value*3
}

let tableOf3_2 = (1...10).map { $0*3 }

func times3(value: Int) -> Int {
	return value*3
}

let tableOf3_3 = (1...10).map { times3(value: $0) }

let tableOf3_4 = (1...10).map(times3)

//: ---

let maybeEightyFour = maybeFortyTwo.map { $0*2 }

let maybeTrue: Bool? = true

//if maybeTrue { } /// ERROR

if let x = maybeTrue, x == true {
	print("ok great")
}

//: ---

struct Point {
	var x: Int
	var y: Int
}

var current = Point(x: 4, y: 2)
let start = current
current.x *= 3
current.y *= 3
let end = current
let vector = Point(x: end.x - start.x, y: end.y - start.y)
/// Point(x: 8, y: 4)

struct Person {
	var firstName: String
	var lastName: String
	
	func greet(with greeting: String) -> String {
		return "\(greeting) \(firstName) \(lastName)!"
	}
}

let mario = Person(firstName: "Mario", lastName: "Rossi")
print(mario.greet(with: "Da quanto tempo")) /// Da quanto tempo Mario Rossi!

//: ---

struct Company { var name: String }

struct Job { var title: String; var company: Company? }

struct Worker {
	var firstName: String
	var lastName: String
	var job: Job?
}

let luigi = Worker(
	firstName: "Luigi",
	lastName: "Bianchi",
	job: Job(
		title: "Uomo token",
		company: nil))

let luigisCompanyName = luigi.job?.company?.name /// nil

//: ---

class JobRepository {
	var jobs: [Job]
	
	func add(job: Job) {
		jobs.append(job)
	}
	
	init() {
		jobs = []
	}
}

//: ---

//extension JobRepository {
//	func getJob(withTitle required: String) -> Job? {
//		return jobs.first(where: { $0.title == required })
//	}
//}
//
//let noJob = JobRepository().getJob(withTitle: "Plumber") /// nil

//: ---

extension String {
	var reversed: String {
		return String(characters.reversed())
	}
}

//: ---

extension String: Error {}

extension JobRepository {
	func getJob(withTitle required: String) throws -> Job {
		if let first = jobs.first(where: { $0.title == required }) {
			return first
		} else {
			throw "No job with title: \(required)"
		}
	}
}

do {
	let noJob = try JobRepository().getJob(withTitle: "Plumber")
	print("JOB FOUND")
}
catch let error {
	print(error) /// No job with title: Plumber
}

//: ---

class Page {}

enum PresentationStyle {
	case push
	case modal
}

protocol PagePresenter {
	func present(page: Page, style: PresentationStyle)
}

class AppNavigator: PagePresenter {
	func present(page: Page, style: PresentationStyle) {
		/// presentation code
	}
}

extension Page {
	func presentModally(with presenter: PagePresenter) {
		presenter.present(page: self, style: .modal)
	}
}

extension PagePresenter {
	func presentModally(_ page: Page) {
		present(page: page, style: .modal)
	}
}

protocol PageOwner {
	var page: Page { get }
}

extension PageOwner where Self: PagePresenter {
	func presentModally() {
		present(page: page, style: .modal)
	}
}

//: ---

struct Resource<A> {
	let name: String
	let parse: (Any) -> A?
}

let id = Resource<Int>(name: "Identifier") {
	guard let value = $0 as? Int, value > 0 else { return nil }
	return value
}

let possibleIds: [Any] = ["notAnId", 1, 2, 0, -1, "5", 6]
let actualIds = possibleIds.flatMap(id.parse)
print(actualIds) // [1,2,6]

//: ---

extension Int {
	func modulo(_ value: Int) -> Int {
		return self % value
	}
}

func testModulo() {
	XCTAssertEqual(3.modulo(2), 1)
}

testModulo()

//: ---

"OK"
