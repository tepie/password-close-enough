// password close enough
// author: terrence pietrondi

function KeyboardCharacters(){
	this.boardsArrays = undefined;
	this.lookupCache = undefined;
	this.buildBoards();
	this.buildWhatsAroundCache();
}

KeyboardCharacters.prototype.buildBoards = function (){
	this.boardsArrays = new Array(new Array(), new Array(), new Array());
	
	this.boardsArrays[0] = ["q","w","e","r","t","y","u","i","o","p"];
	this.boardsArrays[1] = ["a","s","d","f","g","h","j","k","l"];
	this.boardsArrays[2] = ["z","x","c","v","b","n","m"];
};

KeyboardCharacters.prototype.buildWhatsAroundCache = function (){
	var row = 0; var col = 0;
	this.lookupCache = {};
	for(row=0; row<this.boardsArrays.length; row++){
		for(col=0; col<this.boardsArrays[row].length; col++){
			var next = this.boardsArrays[row][col];
			var whatsAround = this.getWhatsAround(next);
			this.lookupCache[next] = whatsAround;
		}
	}
	
	this.boardArrays = undefined;
}

KeyboardCharacters.prototype.isAround = function(source,target){
	var whatsAroundSource = this.lookupCache[source];
	if(whatsAroundSource != undefined){
		var targetIndex = binarySearch(whatsAroundSource,target);
		if( targetIndex != -1){
			return true;
		} else {
			return false;
		}
	} else {
		return false;
	}
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

KeyboardCharacters.prototype.getIndexOf = function(value){
	var returnResult = new Array();
	for(row=0; row<this.boardsArrays.length; row++){
		var indexOfHere = $.inArray(value,this.boardsArrays[row]);
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
	this.boardsArrays = new Array(new Array());
	this.boardsArrays[0] = ["1","2","3","4","5","6","7","8","9","0"];
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
						// pass, we don't have anything to pass for thes characters
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

