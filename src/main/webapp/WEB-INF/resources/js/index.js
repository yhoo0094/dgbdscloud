window.addEventListener('DOMContentLoaded', function()
{
		//클라우드 지식 기타 활성화 여부
        $('input[type="radio"][name="cloudInt"]').on({
			click: function(){
				if ($('#cloudIntEtcChk').is(':checked')) {
                	$('#cloudIntEtc').removeAttr('disabled');
	            } else {
	                $('#cloudIntEtc').attr('disabled', 'disabled');
	            }
			}
		})
		
		//사번 숫자만 입력
		$('.onlyNum').on({
			keyup: function() {
		        var value = $(this).val();
		        $(this).val(value.replace(/[^\d]/g, ''));	// 숫자가 아닌 문자를 제거
		    }
		})
});

function insertAns(){
	//유효성 검증
	var isValid = true;
	$('.required').each(function(idx, item){
		if($(item).val() == '' || $(item).val() == null){
			isValid = false;
			alert($(item).attr('title') + "을 입력해주세요.");
			$(item).focus();
			return false;
		}
	});
	if (!isValid) {return false;}
	
	var empNum = $('#empNum').val()
	var regex = /^\d{7}$/;
	if (!regex.test(empNum)) {
	    alert("잘못된 사번 형식입니다.");
	    $('#empNum').focus();
	    return false;
	}
	
	if(!confirm("제출하시겠습니까?")){return false}; 
	
	var param = {};
	$.each($('#qForm').serializeArray(), function() {
        param[this.name] = this.value;
    });
    
    $.ajax({
	    url: '/insertAns.do',
	    type: 'POST',
	    data: param,
	    contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
	    dataType: 'json',
	    success: function (result) {
			if(result.RESULT == 'SUCCESS'){
				alert('제출 완료하였습니다. 참여해주셔서 감사합니다.');
	        	window.location.reload();
			} else {
				alert(result.MSG);
			}
	    }
    });	
}