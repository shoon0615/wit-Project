<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%	request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>kakao page</title>

<script type="text/javascript" src="/wit/resources/js/jquery-3.1.1.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>Kakao.init('da5ed75e6d7f9bcac9abaeae41fd1108');</script>

<script type="text/javascript">
function sendLink() {
	alert("A");
	 Kakao.Link.createTalkLinkButton({
		  container: '#kakao-link-btn',
		  label: "메시지 / 링크주소",
		  image: {
		      src: 'http://www.mhomepage.com/img/t_logo.gif',
		      width: '300',
		      height: '80'
		  },
		  webButton: {
		    text: 'M홈페이지',
		    url: 'www.naver.com'  //등록한 사이트주소여야함
		  }
		});
	}

	function sendTest() {
		alert("B");
	    Kakao.Link.sendTalkLink({
	      label: '안녕하세요, 꽃다운 ' + Math.floor(Math.random()*(70)+ 15) + '살 개발자입니다.',
	
	      webLink: {
	
	          text:'앱이름',
	
	          url:'www.naver.com'
	
	      }
	    });
	  }
</script>

</head>
<body onload="sendLink()">

<a id="kakao-link-btn" href="javascript:sendTest()">
      <img src="http://dn.api1.kage.kakao.co.kr/14/dn/btqa9B90G1b/GESkkYjKCwJdYOkLvIBKZ0/o.jpg" />
    </a>



</body>
</html>