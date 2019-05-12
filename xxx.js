function* greet1() {
	yield 'hello'
	yield 'world'
	return 1
  }

  function* greet2() {
	var returnValue = yield* greet1()
	console.log(returnValue)
  }

  for (let message of greet2()) {
	console.log("message +" +message);
  }