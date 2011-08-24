// password close enough
// author: terrence pietrondi

function KeyboardCharacters(){
	this.boardStrings = undefined;
	this.boardArrays = undefined;
	this.lookupCache = undefined;
	this.buildBoards();
	this.buildWhatsAroundCache();
}

KeyboardCharacters.prototype.buildBoards = function (){
	this.boardStrings = new Array(new Array(), new Array(), new Array());
	this.boardsArrays = new Array(new Array(), new Array(), new Array());
	
	this.boardStrings[0] = "qwertyuiop";
	this.boardStrings[1] = "asdfghjkl";
	this.boardStrings[2] = "zxcvbnm";
	
	this.boardsArrays[0] = this.boardStrings[0].split("");
	this.boardsArrays[1] = this.boardStrings[1].split("");
	this.boardsArrays[2] = this.boardStrings[2].split("");
};

KeyboardCharacters.prototype.buildWhatsAroundCache = function (){
	var row = 0; var col = 0;
	this.lookupCache = {};
	for(row=0; row<this.boardsArrays.length; row++){
		console.log("buildWhatsAroundCache - next row is %s",row);
		for(col=0; col<this.boardsArrays[row].length; col++){
			console.log("buildWhatsAroundCache - next col is %s",col);
			var next = this.boardsArrays[row][col];
			console.log("buildWhatsAroundCache - next value %s at %s x %s",next,row,col);
			var whatsAround = this.getWhatsAround(next);
			console.log("buildWhatsAroundCache - whats around %s is %o",next,whatsAround);
			this.lookupCache[next] = whatsAround;
		}
	}
	console.log("buildWhatsAroundCache - look up cache %o",this.lookupCache);
}

KeyboardCharacters.prototype.isAround = function(source,target){
	var sourceCords = this.getIndexOf(source);
	
	var check = undefined;
	try {	check 	= this.boardsArrays[sourceCords[0] - 1][sourceCords[1]]; } catch (err) { }
	if( check == target) { return true; }
	try {	check 	= this.boardsArrays[sourceCords[0] + 1][sourceCords[1]]; } catch (err) { }
	if( check == target) { return true; }
	try {	check 	= this.boardsArrays[sourceCords[0]][sourceCords[1] + 1]; } catch (err) { }
	if( check == target) { return true; }
	try {	check 	= this.boardsArrays[sourceCords[0]][sourceCords[1] - 1]; } catch (err) { }
	if( check == target) { return true; }
	try {	check 	= this.boardsArrays[sourceCords[0] - 1][sourceCords[1] + 1]; } catch (err) { }
	if( check == target) { return true; }
	try {	check 	= this.boardsArrays[sourceCords[0] + 1][sourceCords[1] - 1]; } catch (err) { }
	if( check == target) { return true; }
	try {	check 	= this.boardsArrays[sourceCords[0] - 1][sourceCords[1] - 1]; } catch (err) { }
	if( check == target) { return true; }
	try {	check 	= this.boardsArrays[sourceCords[0] + 1][sourceCords[1] + 1]; } catch (err) { }
	if( check == target) { return true; }
	
	return false;
};

KeyboardCharacters.prototype.getWhatsAround = function(source){
	var sourceCords = this.getIndexOf(source);
	
	var whatsAround = new Array();
	var nextAround = undefined;
	try {	nextAround 	= this.boardsArrays[sourceCords[0] - 1][sourceCords[1]]; } catch (err) { nextAround = undefined; }
	if( nextAround != undefined) { whatsAround.push(nextAround); }
	try {	nextAround 	= this.boardsArrays[sourceCords[0] + 1][sourceCords[1]]; } catch (err) { nextAround = undefined; }
	if( nextAround != undefined) { whatsAround.push(nextAround); }
	try {	nextAround 	= this.boardsArrays[sourceCords[0]][sourceCords[1] + 1]; } catch (err) { nextAround = undefined; }
	if( nextAround != undefined) { whatsAround.push(nextAround); }
	try {	nextAround 	= this.boardsArrays[sourceCords[0]][sourceCords[1] - 1]; } catch (err) { nextAround = undefined; }
	if( nextAround != undefined) { whatsAround.push(nextAround); }
	try {	nextAround 	= this.boardsArrays[sourceCords[0] - 1][sourceCords[1] + 1]; } catch (err) { nextAround = undefined; }
	if( nextAround != undefined) { whatsAround.push(nextAround); }
	try {	nextAround 	= this.boardsArrays[sourceCords[0] + 1][sourceCords[1] - 1]; } catch (err) { nextAround = undefined; }
	if( nextAround != undefined) { whatsAround.push(nextAround); }
	try {	nextAround 	= this.boardsArrays[sourceCords[0] - 1][sourceCords[1] - 1]; } catch (err) { nextAround = undefined; }
	if( nextAround != undefined) { whatsAround.push(nextAround); }
	try {	nextAround 	= this.boardsArrays[sourceCords[0] + 1][sourceCords[1] + 1]; } catch (err) { nextAround = undefined; }
	if( nextAround != undefined) { whatsAround.push(nextAround); }
	
	whatsAround.sort();
	return whatsAround;
};

//Copyright 2009 Nicholas C. Zakas. All rights reserved.
//MIT-Licensed, see source file
//http://www.nczonline.net/blog/2009/09/01/computer-science-in-javascript-binary-search/
//https://github.com/nzakas/computer-science-in-javascript
KeyboardCharacters.prototype.binarySearch = function(items, value){

    var startIndex  = 0,
        stopIndex   = items.length - 1,
        middle      = Math.floor((stopIndex + startIndex)/2);

    while(items[middle] != value && startIndex < stopIndex){

        //adjust search area
        if (value < items[middle]){
            stopIndex = middle - 1;
        } else if (value > items[middle]){
            startIndex = middle + 1;
        }

        //recalculate middle
        middle = Math.floor((stopIndex + startIndex)/2);
    }

    //make sure it's the right value
    return (items[middle] != value) ? -1 : middle;
}

KeyboardCharacters.prototype.rowSearch = function(value){
	var returnResult = new Array();
	for(row=0; row<this.boardStrings.length; row++){
		var indexOfHere = this.binarySearch(this.boardStrings[row],value);
		if( indexOfHere != -1){
			returnResult[0] = row;
			returnResult[1] = indexOfHere;
			break;
		}
	}
	
	return returnResult;
};

KeyboardCharacters.prototype.getIndexOf = function(value){
	var returnResult = new Array();
	for(row=0; row<this.boardStrings.length; row++){
		var indexOfHere = this.boardStrings[row].indexOf(value);
		if( indexOfHere != -1){
			returnResult[0] = row;
			returnResult[1] = indexOfHere;
			break;
		}
	}
	
	return returnResult;
};

function KeyboardDigits(){
	KeyboardCharacters.call(this);
}

KeyboardDigits.prototype = new KeyboardCharacters();
KeyboardDigits.prototype.constructor = KeyboardDigits;
KeyboardDigits.prototype.__proto__.buildBoards = KeyboardDigits.prototype.buildBoards;

KeyboardDigits.prototype.buildBoards = function (){
	this.boardStrings = new Array(new Array());
	this.boardsArrays = new Array(new Array());
	
	this.boardStrings[0] = '1234567890';
	this.boardsArrays[0] = this.boardStrings[0].split("");
};


function PasswordCloseEnough(username,password,submit,closeEnoughStatus){
	this.username = username;
	this.password = password;
	this.submit = submit;
	
	this.characterBoard = new KeyboardCharacters();
	this.digitBoard = new KeyboardDigits();
	this.wordPattern = /[a-z]/;
	this.digitPattern = /[0-9]/;
	this.status = closeEnoughStatus;
}

PasswordCloseEnough.prototype.setup = function(){
	this.submit.click( {callingReference: this}, this.eventCallback);
};

PasswordCloseEnough.prototype.eventCallback = function(e){
	
	var lCalRef = e.data.callingReference;
	var usersActualPassword = fakePasswordStorageClearText[lCalRef.username.val()];
	if(usersActualPassword == undefined){
		lCalRef.status.html('username not found in database');
	} else {
		if(lCalRef.password.val().length == usersActualPassword.length ){
			var originalArray = usersActualPassword.toLowerCase().split("");
			var attemptArray = lCalRef.password.val().toLowerCase().split("");
			
			var closeEnough = true;
			var cnt = 0;
			
			while(closeEnough && cnt < originalArray.length){
				if(originalArray[cnt] != attemptArray[cnt] ){ 
					if( lCalRef.wordPattern.test(originalArray[cnt])  && lCalRef.wordPattern.test(attemptArray[cnt])) {
						if(	!lCalRef.characterBoard.isAround(originalArray[cnt],attemptArray[cnt])) {
							closeEnough = false;
							break;
						} 
					} else if( lCalRef.digitPattern.test(originalArray[cnt])  && lCalRef.digitPattern.test(attemptArray[cnt])) {
						if(	!lCalRef.digitBoard.isAround(originalArray[cnt],attemptArray[cnt])) {
							closeEnough = false;
							break;
						} 
					} else {
						closeEnough = false;
						break;
					}
				} // else characters match
				cnt++;
			}
				
			if(closeEnough){
				lCalRef.status.html('attempt and original are close enough');	
			} else {
				lCalRef.status.html('attempt and original are NOT close enough');	
			}
			
		} else {
			lCalRef.status.html('original and attempt lengths do not match');
		}
	}
};

