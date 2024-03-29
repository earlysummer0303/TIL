import Foundation

// 초기화와 생성자

/*
 초기화는 클래스, 구조체, 열거형의 인스턴스를 생성하는 과정. 즉 각 저장속성에 대한 초기값을 설정하여 인스턴스를 사용 가능한 상태로 만드는 것.
 (열거형의 경우, 저장속성이 존재하지 않으므로, case 중 한가지를 선택 및 생성하는 과정)
 
 - 결국 생성자의 실행이 완료되었을 때, 인스턴스의 모든 저장속성이 초기값을 가지게된다. (모든 인스턴스 저장속성의 초기값을 지정하는 것이 생성자의 역할이다.)
 
 - 생성자와 반대 개념의 소멸자 (Deinitializer)도 존재한다.
 - 소멸자는 인스턴스가 메모리에서 해제되기 전, 해야할 기능을 정의하는 부분.
 */



// 생성자 구현의 기본

// 클래스, 구조체, 열거형 모두 동일하게 적용된다.
// 아래와 같이 다양한 형태를 가질 수 있음.
class Dog {
    var name: String
    var species: String
    
    // 생성자도 오버로딩을 지원하기 때문에, 한 클래스에 여러개의 생성자를 구현 가능하다. (아규먼트 레이블, 파라미터의 수, 리턴형으로 구분 )
    
    //1. 파라미터를 받지 않고, 직접 리터럴 값으로 초기화.
    init(){ // init() -> 기본 생성자 (Default Initializer), 클래스 안에서 기본 생성자를 따로 구현하지 않더라도, 저장 속성의 기본 값을 지정해주면 기본 생성자가 자동 구현된다.
        name = "쏨이"
        species = "포메라니안"
    }
    
    //2. 하나의 파라미터 값으로 모든 속성을 초기화.
    init(_ str: String){
        name = str
        species = str
    }
    
    // 3. 모든 멤버의 데이터를 파라미터 값으로 받아 속성을 초기화
    init(name: String, species: String){
        self.name = name
        self.species = species
    }
}

// 생성자의 호출

var ssomi = Dog() // 기본 생성자의 호출로 인스턴스 생성, Dog.init() 과 동일한 표현.
var meoggu = Dog.init(name: "먹구", species: "푸들") // 3번 생성자의 호출로 인스턴스 생성.
var dog = Dog("dog") // 2번 생성자의 호출로 인스턴스 생성.


// 참고 - 초기화의 방법
/*
 1) 직접 각 속성에 초기값을 지정해준다.
 2) 생성자를 통해 초기화 한다.
 3) 각 속성을 옵셔널로 선언한다 -> 초기값을 지정해주지않을 경우 nil을 가진다.
 
 -> 따라서 반드시 생성자를 직접 구현 해줘야 하는 것은 아니다.
 1,3번 방법을 사용하면, 생성자를 직접 구현해주지 않아도, 컴파일러가 기본 생성자를 자동구현함.
 ==> ⭐️ 만약, 클래스 내에 코드로 직접 생성자를 구현해 줄 경우에는 컴파일러가 기본 생성자를 자동 구현하지 않음!!!
 */



// 멤버와이즈 이니셜라이져 (Memberwise Initializer) => 구조체의 특별한 생성자.

struct Flower {
    var name: String
    var fetals: Int
    /*
     init(name: String, fetal: Int){
        self.name = name
        self.fetals = fetals
     }
     */ // 멤버와이즈 이니셜라이저가 자동제공된다!
}

// 구조체에서는 모든 멤버를 파라미터로 받는 생성자의 자동 구현을 제공한다. 이 자동제공되는 생성자를 멤버와이즈 생성자라고 한다.
// 단, 구조체 내부에서 직접 생성자를 구현하는 경우, 멤버와이즈 생성자의 자동 구현이 제공되지 않는다.
// 즉, 구조체에서는 기본 생성자 + 멤버와이즈 생성자의 자동구현이 제공되는것.


// 다양한 형태의 멤버와이즈 이니셜라이저 자동 구현.
struct Plant {
    var name: String = ""
    var leafs: Int = 5
    var fetals: Int // 예를 들어서 이렇게 한개의 멤버만 초기값이 주어지지 않은 구조체의 경우.
}

var aPlant = Plant(fetals:0) // 초기값이 주어지지 않은 멤버만 파라미터로 받는 멤버와이즈 생성자 자동 구현 제공.
var bPlant = Plant(name: "냥", leafs: 8, fetals: 4)// 이미 선언시 초기화 된 멤버를 파라미터로 받는 멤버와이즈 생성자 또한 기본 제공.

// 클래스의 생성자

// 지금까지 공부한 init() 으로 시작하는 생성자들은 지정 생성자 (Designated Initializer)
// 클래스에는 이 외에도 편의생성자, 필수생성자, 실패가능 생성자(->구조체에도 있음)가 있음.

// 구조체의 지정 생성자의 구현
// -> 구조체의 지정 생성자는 다른 생성자를 호출하는 방식으로도 가능하다.

struct Plant2 {
    var name: String
    var leafs: Int
    var fetals: Int
    init(){ // 여러개의 지정 생성자를 작성하는 방식
        self.init(name: "", leafs: 0, fetals: 0)
    }
    init(name: String, leafs: Int, fetals: Int){
        self.name = name
        self.leafs = leafs
        self.fetals = fetals
    }
}

// 편의 생성자 (Convenience Initializer)
// -> 다른 생성자를 호출하는 생성자. (구조체에서는 편의생성자 라는 개념이 없음.)
// 앞에 convenience 키워드를 붙여준다.

class Puppy {
    var name: String
    var age: Int
    init(name: String, age: Int){
        self.name = name
        self.age = age
    }
    convenience init(name: String){ // 하나의 멤버의 초기값을 두고, 다른 멤버만 파라미터로 받고 싶을 때 편의 생성자를 사용하기.
        self.init(name: name, age: 0) // 더 간결(편리)하게 새로운 생성자 구현.
    }
}

var kkomi = Puppy(name: "kkomi")
kkomi.age // 자동으로 0

// 편의 생성자의 기능을 지정 생성자로도 구현 가능 하지만, 바람직한 구현이 아님 > 이유는 뒤에서 자세히


// 편의 생성자를 사용하는 이유
/*
 - 편의 생성자는 모든 속성을 초기화 할 필요가 없는 편의적인 성격을 지닌다.
 - 따라서, 초기화 과정을 간편하게 하고, 상속 관계에 있어, 개발자가 실수할 수 있는 여러가지 가능성을 배제하기 위해 도입된 생성자다.
 - 모든 속성자를 초기화 하지 않는다면, 편의생성자로 만드는 편이 복잡도나 실수를 줄이 수 있다.
 - 결국, 가능한 생성자간의 중복을 줄이고, 다른 지정 생성자를 호출하는 패턴으로 구현하는게 좋다.
 
 -> 모든 속성을 파라미터로 받는 지정 생성자를 구현하고, 기타 생성자들은 편의생성자로 구현하는 것을 권장.
 */

// 편의 생성자의 사용예2

class Parent {
    var name: String
    var age: Int
    var sex: String
    init(name: String, age: Int, sex: String){
        self.name = name
        self.age = age
        self.sex = sex
    }
    convenience init(name: String, age: Int){
        self.init(name: name, age: age, sex: "Female")
    } // 편의 생성자를 이용해, sex의 초기값을 "Female"로 지정.
    func doWhenInitiated_p(){
        print("지정생성자를 통한 초기화 완료! - 부모")
    }
}

var jiwooMom = Parent(name: "선주", age: 53)
jiwooMom.sex


// 상속이 일어날때, 지정 생성자는 어떻게 선언해줘야 할까

class Child : Parent {
    var grade: Int
    init(name: String, age: Int, sex: String, grade: Int){
        // 1. 먼저 자식클래스 고유의 속성 초기화.
        self.grade = grade
        // 2. 부모클래스의 생성자를 호출해서 상속받은 속성 초기화.
        // -> 상속받은 속성의 메모리공간을 할당하는 과정으로, 상속받은 속성에 접근하기 전 반드시 선행되어야 한다.
        super.init(name: name, age: age, sex: sex) // 상위클래스지정생성자구현
        self.sex = "Female" // 상위클래스의 생성자를 호출했기 때문에, 이제 접근 가능.
        super.doWhenInitiated_p()
        self.doWhenInitiated_c() // 이렇게 생성자 안에 부모 혹은 자신의 매서드도 호출 가능.
    }
    convenience init(name: String, age: Int){
        self.init(name: name, age: age, sex: "Female", grade: 4)
    }
    func doWhenInitiated_c(){
        print("지정생성자를 통한 초기화 완료! - 자식")
    }
}

// ⭐️ 중요!! -> 부모클래스의 편의생성자는 자식 클래스에서 재정의 할 수 없다.(자식클래스에서 호출 불가.)
var jiwoo = Child(name: "지우", age: 25)



// 상속관계에서의 생성자 위임 규칙 (교재 참고)
/*
 1) 델리게이트 업 (Delegate Up) -> 슈퍼-서브 간 위임규칙
 - 서브클래스의 지정생성자는 슈퍼클래스의 지정생성자를 반드시 호출해야 한다.
    (하위클래스 자신의 속성을 초기화 하고, 상속받은 슈퍼클래스의 저장속성을 초기화 하는 과정.)
 2) 델리게이트 어크로스 (Delegate Across) -> 같은 클래스 내 생성자들간 위임규칙
 - 편의생성자는 동일한 클래스의 다른 지정/편의 생성자를 호출해야하고, 궁극적으로는 반드시 지정생성자를 호출해야 한다.(지정생성자만이 모든 저장속성을 초기화 하므로.)
 */




// 생성자의 상속과 재정의

/*
 - 하위 클래스는 기본적으로 상위클래스 생성자를 상속하지 않고, 하위클래스에서 재정의 하는 것이 원칙이다.
    (상위클래스의 생성자는 하위클래스에 최적화되어 있지 않기 때문)
    --> but, 안전한 경우에는 상위클래스 생성자가 자동 상속 됨.
 - 하위 클래스의 커스텀 생성자를 작성하기 전, 재정의 생성자를 먼저 작성해 주는 것이 좋다 (실수하지 않기 위해)
 */


// 생성자 상속 시 구현 규칙 (상위 클래스와 동일한 이름 및 구조를 가지는 생성자 재정의 관련)

/*
 대원칙 : 1) 상위의 지정생성자(이름 / 파라미터) 와 2) 현재 단계의 저장속성 을 고려해서 구현해야 한다
 
 [상위 지정생성자에 대한 고려]
 
 상위의 편의생성자는 하위에서 재정의 하지 않는것이 원칙. (하위 클래스에서 상위 편의생성자를 호출 할 수 없다.)
 
 - 상위에 어떤 생성자가 존재하는지에 따라
 - (상위) 지정 생성자에 대해 => 1) 하위클래스에서 지정 생성자로 구현 (재정의) => 만약 파라미터가 동일한 형태라면 override 키워드 붙여주기 -> case1
                       => 2) 하위클래스에서 편의 생성자로 구현 가능하다 (재정의) -> case2
                       => 3) 구현하지 않아도 된다 (반드시 재정의 할 필요는 없다.) -> case3
 
 - (상위) 편의 생성자에 대해 => 재정의를 하지 않아도 됨 (호출 불가가 원칙이기 때문에 재정의 제공 안함.)
                       => (만약에 동일한 이름을 구현했다면) 그냥 새로 정의한 것이다.
 
 [현재 단계의 저장속성에 대한 고려]
 
 -1) 지정 생성자 내에서 (필수!!)
    => 자신의 모든 저장 속성을 초기화 해야 한다.
    => 슈퍼클래스의 지정 생성자를 호출해야한다.
 
 -2) 편의 생성자 내에서
    => (최종적으로 몇번의 다른 편의생성자를 거치던) 현재 클래스의 지정생성자를 호출해야 한다.
 
 */

class A{
    var x : Int = 0
} // 이 클래스의 경우, 지정생성자로 init()을 기본적으로 가짐


// case 1 - (상위) 지정 생성자에 대해 => 1) 하위클래스에서 지정 생성자로 재정의
class B: A{
    var y : Int
    override init(){ // 하위클래스의 지정생성자
        // 이 지정생성자의 경우, 상위클래스의 지정생성자 init() 과 함수명,형태가 동일하므로 override 키워드를 붙여준다.
        self.y = 0 // 지정생성자에서 반드시 하위클래스 자신의 모든 저장속성 초기화.
        super.init()// 지정생성자에서 반드시 상위클래스의 지정생성자 호출.
    }
}

//case 2 = (상위) 지정 생성자에 대해 => 2) 하위클래스에서 편의 생성자로 재정의
class C: A{
    var z : Int
    init(z:Int){ // 지정생성자의 형식이 상위클래스의 지정생성자와 다르다.
        self.z = z
        super.init()
    }
    override convenience init(){ // 편의생성자의 함수명 및 형식이, 상위클래스의 지정생성자 init() 와 동일하므로 override 키워드를 붙여준다.
        self.init(z: 0) //편의생성자에서는 최종적으로 반드시 지정생성자를 호출해야 한다.
    }
}


// case 3 = (상위) 지정 생성자에 대해 => 3) 재정의하지 않아도 된다 (반드시 상위클래스의 지정생성자와 같은 형식의 재정의 지정생성자를 정의할 필요는 없음.)

class D: A{
    var a: Int
    var b: Int
    init(a: Int, b: Int){
        self.a = a
        self.b = b
        super.init()
    }
}

// 참고) 만약, 상위 클래스에 기본 생성자 init()만 존재하는 경우, 하위클래스 지정생성자에서 상위클래스의 지정생성자를 호출 할 필요가 없다. (암시적 요청)

class E: A{
    var e: String
    init(e: String){
        self.e = e
        //super.init()
        // 상위클래스 지정생성자 호출 생략 가능.
    }
}

// 지정생성자 / 편의생성자 상속의 예외사항
// 생성자는 상속받는 것이 아닌, 재정의 하는것이 원칙이지만 예외가 있음 (클래스의 생성자 자동 상속 규칙)


// 1. 상위 클래스의 모든 '지정생성자'를 자동 상속 받는 예외상황
/*
 1) 하위클래스에서 선언한 새로운 저장 속성이 아예 없거나,
 2) 하위클래스의 모든 저장 속성의 초기값을 선언하며 초기화 하는 경우
 
 상위클래스의 지정생성자를 모두 자동으로 상속받는다. (인스턴스 생성의 실패 가능성이 없기 때문에)
 */

// 1-1)

class F{
    var f = 0
}

class G :F{
    // 하위클래스의 새로운 저장 속성이 없는 경우, 새로운 생성자의 정의 및 상위 클래스의 생성자 재정의를 할 필요가 없음.
    func iamG() {
        print("I AM G")
    }
}

var instanceOfG = G() // 자동 상속된 지정생성자로 인스턴스 생성.

// 1-2)

class H{
    var h : Int
    init(h: Int){
        self.h = h
    }
}

class I: H{
    var i = 0
    var ii = 1 // 하위클래스의 새로운 저장 속성이 모두 선언시 초기화 될 경우 , 상위클래스의 모든 지정생성자 (+ 편의 생성자가 있다면 그 또한 포함)을 자동상속받는다.
}

var i = I(h: 5) // 자동상속된 지정생성자로 인스턴스 생성



// 2. 상위 클래스의 모든 '편의 생성자'를 자동 상속 받는 예외상황
/*
 1) 상위클래스의 모든 지정 생성자를 자동 상속받는 경우( = 1번 케이스), 상위클래스에 편의생성자가 있다면 상위클래스의 모든 편의 생성자 또한 자동상속됨
 2) 상위클래스의 모든 지정생성자를 하위클래스에서 재정의 했을 경우, 상위클래스에 편의생성자가 있다면 상위클래스의 모든 편의 생성자들은 자동 상속된다.
 
 상위클래스의 지정생성자를 모두 자동으로 상속받는다. (인스턴스 생성의 실패 가능성이 없기 때문에)
 */

//2 -1)

class J{ // 편의생성자가 있는 상위클래스
    var j: Int
    var jj: Int
    init(j: Int, jj: Int){
        self.j = j
        self.jj = jj
    }
    convenience init(jj: Int){
        self.init(j: 8, jj: jj)
    }
}

// 상위클래스의 생성자 -> (지정)init(j,jj), (편의)init(jj)
class K: J{
    var k = 9 // 모든 저장속성이 초기화 되어 상위클래스의 지정생성자를 자동 상속받음
}

var instanceOfK = J(jj: 7) // 상위클래스의 편의생성자 또한 자동 상속받아 인스턴스 생성.


//2- 2)

class L: J{
    var l: Int
    override init(j:Int, jj:Int){
        self.l = 0
        super.init(j: j, jj: jj)
        print("상위클래스의 모든 지정생성자를 재정의했습니다.") // 상위클래스의 모든 지정생성자를 재정의함.
    }
}

var instanceOfL = L(jj: 7) // 상위클래스의 편의생성자를 자동 상속받아 인스턴스 생성.



// 필수생성자 (Required Initializer)

// 필수 생성자란, 하위클래스에서 반드시 재정의 되어야 하는 생성자 이며, 앞에 required 키워드를 붙여 구현한다.
// 애플이 미리 만들어놓은 프레임워크의 경우, 필수 생성자로 구현된 기능들이 있음!
// 단, 하위 클래스에 새로 구현(재정의)한 지정생성자가 없을 경우, 상위클래스의 필수생성자가 자동 상속 되어, 하위클래스에서 필수 생성자를 구현할 필요가 없어진다.

class M {
    var m: Int
    required init(m: Int){
        self.m = m
    }
}

class N: M {
    var n: Int
    init(n: Int){
        self.n = n
        super.init(m: 0)
    }
    required init(m: Int) { // 하위클래스에서 필수 생성자를 재정의 할때는 앞에 override 키워드를 붙여 줄 필요가 없다.
        self.n = 9
        super.init(m: m)
    }
} // 하위클래스에 새로 구현한 지정생성자가 존재할 경우, 반드시 상위클래스의 필수생성자를 구현해줘야 한다.

class O: M {
    var o = 7 // 저장속성 초기화
} // 자동상속된 required init(m:) 가짐.

var instanceOfO2 = O(m: 8)


// 실패 가능 생성자

// 인스턴스 생성을 실패할 가능성을 용인 할 수 있는 생성자, 인스턴스 생성을 실패할 경우 nil을 반환한다. (단, 파라미터 옆에 반환형을 표시하진 않는다.) (옵셔널)
/*
 - 클래스, 열거형, 구조체 모두 실패 가능 생성자를 가질 수 있다.
 - 실패 가능 생성자가 필요한 이유?
    => 실패가 불가능하게 만들어서 아예 에러가 나고 앱이 꺼지는 것 보다는, 실패 가능성이 있을수 있는 생성자를 정의하고, 그에 맞는 예외처리를 하는것이 바람직하므로.
 - 생성자에 ? 을 붙여서 init?(파라미터) 형태로 정의한다.
 - ⭐️ 다만 같은 클래스/열거형/구조체 내에서 동일한 파라미터를 가지는 생성자가 없어야 한다. (오버로딩이 되버릴 경우. 실패가능 생성자의 실패 여부를 구분할 수가 없기 때문.)
 - 실패가능 생성자를 통해 생성된 인스턴스는 해당 타입의 옵셔널 형태이다
 */

struct Animal {
    let species: String
    init?(species: String){
        if species.isEmpty { // error 상황이라고 할때
            return nil
        }
        self.species = species
    }
}

let cat = Animal(species: "cat") // Animal? 타입
let dDog = Animal(species: "")   // Animal? 타입, nil


//⭐️ 실패가능 생성자의 호출(위임) 규칙

/*
 
 실패 불가능한 생성자는 다른 실패가능 생성자를 호출(=위임) 불가능하다!
 (Delegate Up, Delegate Across 모두 마찬가지)
 
 */

//Delegate Up 상황 (상속관계) 에서의 실패 가능 생성자 호출 예제

class Bread {
    var color: String
    init?(color: String){ // 실패가능 생성자 구현
        if color.isEmpty { // 에러처리
            return nil
        }
        self.color = color
    }
}

class ChocoBread: Bread {
    var chocochips: Int
    init?(color: String, chocochips: Int){ // 하위클래스의 '실패가능생성자' 가 상위 클래스의 '실패가능 생성자' 를 호출한 것이므로 올바른 코드.
        if chocochips <= 0 { return nil} // 에러처리
        self.chocochips = chocochips
        super.init(color: color)
    }
}

// 인스턴스를 생성하는 상황 예제

//1. 상위클래스의 실패가능 생성자를 통한 인스턴스 생성 -> 에러조건을 만족할 경우 인스턴스 생성 실패

if let bread = Bread(color: "") {
    print("빵 생성 완료, 빵 색상 - \(bread.color)")
}
else {
    print("빵 생성 불가 - 빵 색상 지정 안됨")
}

// 상위 클래스에서 상속받은 멤버가 nil일 경우 -> 인스턴스 생성 실패 (nil)

if let chocobread = ChocoBread(color: "", chocochips: 5){
    print("인스턴스 생성됨, 초코칩 개수는 \(chocobread.chocochips)개")
}
else {
    print("빵 생성 불가 - 빵 색상 지정 안됨")
}

// 상위클래스의 실패가능 생성자, 하위클래스의 실패 가능 생성자 모두 예외조건이 아닐 경우 -> 하위클래스 인스턴스 생성 성공

if let chocobread2 = ChocoBread(color: "yellow", chocochips: 5){
    print("인스턴스 생성됨, 빵 색상은",chocobread2.color,"초코칩 개수는 \(chocobread2.chocochips)")
}
else {
    print("빵 생성 실패")
}

//⭐️ 실패가능 생성자의 재정의 규칙

/*
 - 상위클래스의 실패가능 생성자를 하위클래스에서 실패 불가능 생성자로 재정의 가능 => 강제 언래핑 활용 가능
 - ☑️ 상위의 실패 불가능 생성자를 하위클래스에서 실패 가능 생성자로 재정의하는것은 불가능.
 */

class Book {
    var title: String
    var quantity: Int
    init(title: String, quantity: Int){
        self.title = title
        self.quantity = quantity
    }
    init?(title: String){
        if title.isEmpty{
            return nil
        }
        self.title = title
        self.quantity = 1
    }
}

// 상위클래스의 실패가능 생성자를 하위클래스 실패불가능 생성자로 재정의 => 가능
class Note: Book {
    var isStringNote = true
    override init (title: String){ // 형태는 상위클래스의 실패가능 생성자와 동일하나, 내부에서는 상위클래스의 실패불가능 생성자를 호출하는 방식으로 실패 불가능 생성자로 재정의
        super.init(title: title, quantity: 7)
    }
}

var noteBook = Note(title: "지우의 노트")
print(noteBook.title, noteBook.quantity, noteBook.isStringNote)

// 상위클래스의 실패가능 생성자를 하위클래스 실패가능 생성자로 재정의시, 하위클래스 생성자에서 상위클래스 실패가능 생성자를 호출하는 경우 -> 강제 언래핑 사용 가능
class Photobook: Book {
    var year = 2022
    override init(title: String){
        super.init(title: title)!
    }
}


// 상위클래스의 실패불가능 생성자를 하위클래스에서 실패 가능 생성자로 재정의하는것은 불가능
/*
class Diary: Book {
    var isEternal = true
    override init?(title: String, quantity: Int){ // 불가능 (Failable initializer cannot override a non-failable initializer)
        ...
    }
}
*/

// ⭐️참고! 실패가능 생성자 (init?)는 init!와 거의 동일하다고 봐도 무방하다.

/*
 그렇기 때문에,
 init? => init! 위임 가능
 init! => init? 위임 가능
 
 init? => init! 재정의 가능
 init! => init? 재정의 가능
 
 */



// 소멸자 (Deinitializer)
// 메모리에 있던 인스턴스가 사라질 때 (메모리 해제 될 때) 호출되는 함수.
/*
 소멸자는 인스턴스가 힙 메모리에서 해제되기 직전, 정리가 필요한 내용을 구현하는 메서드.
 소멸자는 클래스에만 존재하는 메소드로,클래스 정의시 클래스에는 최대 1개의 소멸자를 정의 가능 (⭐️한개 이상 정의 불가!!)
 소멸자는 파라미터(매개 변수)를 사용하지 않음 -> 따라서, 파라미터를 넣는 괄호 작성 x => deinit(){} 아니고, deinit{}
 deinit 키워드를 사용해서 구현!
 
 소멸자(초기화 해제) 작동 방식 => ARC 부분에서 자세히
 
 소멸자는 직접 호출 할 수 없으며, 인스턴스가 메모리에서 제거되기 직전에 호출된다.
 */

class Aclass {
    var x = 0
    deinit {
        print("인스턴스가 메모리에서 해제되었습니다.")
    }
}

var acac: Aclass? = Aclass() // acac를 옵셔널로 선언
acac = nil // acac에 nil 할당 = acac의 메모리 공간을 비움 => deinitializer 실행됨.


// 소멸자의 상속
/*
 - 상위클래스의 소멸자는 해당 하위클래스에 상속됨.
 - 상위클래스 소멸자는 하위클래스 소멸자의 구현이 끝날 때 자동 호출됨.
 - 상위클래스 소멸자는 하위클래스가 자체적인 소멸자를 제공하지 않더라도 항상 호출됨.
 */
