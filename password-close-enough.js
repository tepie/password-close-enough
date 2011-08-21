// password close enough
// author: terrence pietrondi

function KeyboardCharacters(){
	this.boardStrings = undefined;
	this.boardArrays = undefined;
	this.buildBoards();
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


function PasswordCloseEnough(username,password,submit){
	this.username = username;
	this.password = password;
	this.submit = submit;
	
	this.characterBoard = new KeyboardCharacters();
	this.digitBoard = new KeyboardDigits();
	this.wordPattern = /[a-z]/;
	this.digitPattern = /[0-9]/;
	this.status = undefined;
}

PasswordCloseEnough.prototype.setup = function(){
	this.status = $('<div id="password-close-enough-status" />');
	this.status.appendTo($('body'));
	this.submit.click( {callingReference: this}, this.eventCallback);
};

PasswordCloseEnough.prototype.eventCallback = function(e){
	
	var lCalRef = e.data.callingReference;
	var usersActualPassword = fakePasswordStorageClearText[lCalRef.username.val()];
	if(usersActualPassword == undefined){
		lCalRef.status.html('<p class="close-enough">username not found in database</p>');
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
				lCalRef.status.html('<p class="close-enough">attempt and original are close enough</p>');	
			} else {
				lCalRef.status.html('<p class="close-enough">attempt and original are NOT close enough</p>');	
			}
			
		} else {
			lCalRef.status.html('<p class="close-enough">original and attempt lengths do not match</p>');
		}
	}
};

