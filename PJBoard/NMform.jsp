<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
		
		*{ margin:0; padding: 0;}
        body{background-color: #F5F6F7;}
        form{margin-top: 60px;margin-left: 38%;}
        ul,li{ list-style: none; margin-left: auto; margin-right: auto;}
        li{margin-bottom: 20px; text-align: left;}
        .box{width: 450px; height: 50px; border: 1px solid #666; padding: 10px;}
        .pbox{width: 120px; height: 50px; border: 1px solid #666; padding: 10px;}
       .necessary{font-size: small; color:red;}
   		button{background:#00C850; color:white; width: 450px; border: 1px solid #666; height:50px; font-size: x-large; }
</style>
</head>
<body>
	<jsp:include page = "./Common2/Link.jsp" />
	
	<script>
	function validateForm(form) {
		/*
			<form>태그 하위의 각 input 태그에 입력값이 있는지 확인하여 만약
			빈값이라면 경고창, 포커스 이동, 폼값전송 취소 처리를 한다.
		*/
		if(!form.id.value){
			alert("아이디를 입력하세요.");
			return false;
		}
		if(form.pass.value == ""){
			alert("패스워드를 입력하세요.");
			return false;
		}
		if(form.name.value == ""){
			alert("이름를 입력하세요.");
			return false;
		}
		if(form.phone.value == ""){
			alert("핸드폰 번호를 입력하세요.");
			return false;
		}
		if(form.email.value == ""){
			alert("이메일를 입력하세요.");
			return false;
		}
		if(form.gender.value == ""){
			alert("성별를 골라주세요.");
			return false;
		}
			
	}
	</script>
	<script>
		 const hypenTel = (target) => {
		 target.value = target.value
		   .replace(/[^0-9]/g, '')
		   .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
		}

</script>
	<h2 align="center">회원가입 페이지</h2>
	<form action="NMprocess.jsp" method="post" onsubmit="return validateForm(this);">
            <ul>
                <li><span >아이디</span><br><input type = "text" name="id" placeholder = "아이디를 입력하세요" class = 'box'/>
                <br><span class = 'necessary' >필수 정보입니다.</span></li>
               		
                <li><span >패스워드</span><br><input type = "password" name="pass" placeholder = "패스워드를 입력하세요" class = 'box'/>
                    <br><span class = 'necessary' >필수 정보입니다.</span></li>
    			       	
           		<li><span >이름</span><br><input type = "text" name="name" placeholder = "이름을 입력하세요" class = 'box'/>
                <br><span class = 'necessary' >필수 정보입니다.</span></li>
           	
                 <li><span >이메일</span><br><input type = "text" name="email" placeholder = "이메일을 입력하세요" class = 'box'/>
                <br><span class = 'necessary' >필수 정보입니다.</span></li>
                
                 <li><span >전화번호 </span><br><input type = "text" name="phone" 
                 placeholder = "전화번호를 입력하세요" class = 'box' oninput="hypenTel(this)" maxlength="13"/>
                <br><span class = 'necessary' >필수 정보입니다.</span></li>
                
                <li><span >성별</span><br> 
                남자<input type ="radio" name="gender" value="m"/>
                여자<input type="radio" name="gender" value="f" />
                <br><span class = 'necessary' >필수 정보입니다.</span> </li>
                 <li><input type="submit" value="가입" style="background:#00C850; color:white; width: 450px; border: 1px solid #666; height:50px; font-size: x-large;" /></li>
        </ul>
        </form>
	
</body>
</html>