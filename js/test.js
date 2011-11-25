var before = {
    setup: function() {
        characterBoard = new KeyboardCharacters();
        digitBoard = new KeyboardDigits();
    }
};


module('character board', before);

test('testing "q" - upper left edge of board', 3, function() {
	var result = characterBoard.isAround("q","w");
	ok(result,"should result true");
	result = characterBoard.isAround("q","s");
	ok(result,"should result true");
	result = characterBoard.isAround("q","a");
	ok(result,"should result true");
});

test('testing "m" - bottom right edge of board', 3, function() {
	var result = characterBoard.isAround("m","k");
	ok(result,"should result true");
	result = characterBoard.isAround("m","j");
	ok(result,"should result true");
	result = characterBoard.isAround("m","n");
	ok(result,"should result true");
});

module('digit board', before);

test('testing "1" - upper left edge of board', 1, function() {
	var result = digitBoard.isAround("1","2");
	ok(result,"should result true");
});

