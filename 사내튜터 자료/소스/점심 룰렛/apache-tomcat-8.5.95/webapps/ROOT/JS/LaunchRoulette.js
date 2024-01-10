
window.onload = function(){
	theWheel.numSegments = theWheel.segments.length - 1
	powerSelected(3);	//power 3으로 설정
	selectMenuList();	//메뉴목록 조회
	
	$('#addItemInput').on({
		keyup : function(e){
			if (e.key === 'Enter') {
        		addItem();
    		}
		}
	})
}

//메뉴목록 조회
function selectMenuList() {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "/JSP/selectMenuList.jsp", true);
    xhr.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
			let menuList = JSON.parse(this.responseText);
            for(var i in menuList){
				let menuNm = menuList[i].MENU_NM
				let menuNo = menuList[i].MENU_NO
				addMenu(menuNm, menuNo)
			}
        }
    };
    xhr.send();
}

//목록 추가 버튼
function addItem(){
	var menuNm = document.getElementById("addItemInput").value;
	let menuNo = 0;
	for(let i in segments){
		if(segments[i].menuNo >= menuNo){
			menuNo = segments[i].menuNo + 1;
		}
	}

	addMenu(menuNm, menuNo)		//메뉴 목록 추가
	
	document.getElementById("addItemInput").value = '';
	
	insertMenu(menuNo, menuNm);	//메뉴 DB insert
}

//메뉴 목록 추가
function addMenu(menuNm, menuNo){
	let colorCode = "#" + Math.round(Math.random() * 0xffffff).toString(16);
	
	segments.push({'fillStyle' : colorCode, 'text' : menuNm, 'menuNo' : menuNo})
	numSegments = segments.length;
	
	theWheel = new Winwheel({
	    'numSegments'  : numSegments,     // Specify number of segments.
	    'outerRadius'  : 212,   // Set outer radius so wheel fits inside the background.
	    'textFontSize' : 28,    // Set font size as desired.
	    'segments'     : segments,       // Define segments including colour and text.
	    'animation'    : animation,          // Specify the animation to use.
	    'pins'         : pins // Number of pins. They space evenly around the wheel.
	});
	
	$('#btnTable').append('<tr><td><p>'+ menuNm +'</p></td>' 
						+ '<td><button id="'+ menuNo +'" type="button" class="btn btn-danger" onclick="removeItem(this)">삭제</button></td>'
						+ '</tr>');	
}

//메뉴 DB insert
function insertMenu(menuNo, menuNm) {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "/JSP/insertMenu.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            console.log(this.responseText);
        }
    };
    xhr.send("menuNo=" + menuNo + "&menuNm=" + menuNm);
}

//삭제 버튼
function removeItem(obj){
	let menuNo = $(obj).attr('id');
	for(let i in segments){
		if(segments[i].menuNo == menuNo){
			segments.splice(i,1);
		}
	}
	numSegments = segments.length;
	
	theWheel = new Winwheel({
	    'numSegments'  : numSegments,    // Specify number of segments.
	    'outerRadius'  : 212,   		 // Set outer radius so wheel fits inside the background.
	    'textFontSize' : 28,    		 // Set font size as desired.
	    'segments'     : segments,       // Define segments including colour and text.
	    'animation'    : animation,      // Specify the animation to use.
	    'pins'         : pins 			 // Number of pins. They space evenly around the wheel.
	});	
	
	$(obj).parent().parent().remove();
	
	deleteMenu(menuNo);
}

//메뉴 DB delete
function deleteMenu(menuNo) {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "/JSP/deleteMenu.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            console.log(this.responseText);
        }
    };
    xhr.send("menuNo=" + menuNo);
}
