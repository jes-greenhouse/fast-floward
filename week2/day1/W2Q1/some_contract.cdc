access(all) contract SomeContract {
    pub var testStruct: SomeStruct

    pub struct SomeStruct {
        // 4 Variables
        //
        pub(set) var a: String

        pub var b: String

        access(contract) var c: String

        access(self) var d: String

        // 3 Functions
        //
        pub fun publicFunc() {}

        access(self) fun privateFunc() {}

        access(contract) fun contractFunc() {}


        pub fun structFunc() {
            // Area 1
            // Variables that can be read: a, b, c, d
            log(self.a)
            log(self.b)
            log(self.c)
            log(self.d)
            // Variables that can be modified: a, b, c, d
            self.a = "1"
            self.b = "2"
            self.c = "3"
            self.d = "4"
            // Functions that can be accessed: publicFunc, privateFunc, contractFunc
            self.publicFunc()
            self.privateFunc()
            self.contractFunc()
        }

        init() {
            self.a = "a"
            self.b = "b"
            self.c = "c"
            self.d = "d"
        }
    }

    pub resource SomeResource {
        pub var e: Int

        pub fun resourceFunc() {
            // Area 2
            // Variables that can be read: a, b, c
            var someStruct = SomeStruct()
            log(someStruct.a)
            log(someStruct.b)
            log(someStruct.c)
            // Variables that can be modified: a
            someStruct.a = "1"
            // Functions that can be accessed: publicFunc, contractFunc
            someStruct.publicFunc()
            someStruct.contractFunc()
        }

        init() {
            self.e = 17
        }
    }

    pub fun createSomeResource(): @SomeResource {
        return <- create SomeResource()
    }

    pub fun questsAreFun() {
        // Area 3
        // Variables that can be read: a, b, c
        var someStruct = SomeStruct()
        log(someStruct.a)
        log(someStruct.b)
        log(someStruct.c)
        // Variables that can be modified: a
        someStruct.a = "1"
        // Functions that can be accessed: publicFunc, contractFunc
        someStruct.publicFunc()
        someStruct.contractFunc()
    }

    init() {
        self.testStruct = SomeStruct()
    }
}