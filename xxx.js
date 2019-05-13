function* greet1() {
	for(i=0;i<5;i++) {
		yield i;
	}

  }
var xx = greet1();
console.log("ajkfdls" + xx.next().value);
console.log("ajkfdls" + xx.next().value);