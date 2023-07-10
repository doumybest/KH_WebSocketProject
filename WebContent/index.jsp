<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>

	<input type="text" id="sender" size="10" placeholder="보내는사람이름">
	<input type="text" id="receiver" size="10" placeholder="받는사람이름">
	<input type="text" id="msg" placeholder="전송할 메세지">
	
	<button onclick="sendMsg();">전송</button>
	
	<div id = "msgContainer">
	
	</div>
	
	<script>
		// 웹소켓 서버에 연결
		// WebSocket 객체 생성 ==> 연결요청 보냄.
		// 192.168.30.141 == localhost
		const socket = new WebSocket("ws://192.168.30.180:8081/<%= request.getContextPath() %>/chatting.do");
		
		// socket 설정하기
		// 1. 소켓에 접속 후 실행되는 이벤트 핸들러 등록.
		socket.onopen = function(e){
			console.log("웹소켓 접속 성공");
			console.log(e);
		}
		
		// 2. 웹소켓 서버로 메세지를 전송하는 함수.
		const sendMsg = () => {
			// 발송자, 수신자, 메세지내용
			// 메세지 객체를 만든 후, JSON.stringify() 함수를 이용하여 JSON 오브젝트로 만들어준 후 전송할것
			
			let msg = {
				sender : $("#sender").val(),
				receiver : $("#receiver").val(),
				msg : $("#msg").val()
			}
			
			socket.send(JSON.stringify(msg));
		}
		
		// 3. 웹소켓 서버에서 sendXXX메소드를 실행하면 실행되는 함수
		socket.onmessage = function(e){
			
			console.log("메세지 수신됨.");
			
			console.log(e.data); // e.data 속성안에 서버가 전달한 데이터가 담겨있음.
			
			console.log(JSON.parse(e.data)); // JSON 형태를 java데이터 형식으로 바꿔 키:밸류로 전달
			
			let msg = JSON.parse(e.data);
			
			if(msg["sender"] == $("#sender").val()){
				$("#msgContainer").append($("<p>").text("<"+msg["sender"]+"> "+msg["msg"]).css("text-align","left"));
			}else{
				$("#msgContainer").append($("<p>").text("<"+msg["sender"]+"> "+msg["msg"]).css("text-align","right"));				
			}
		}
			
	</script>

</body>
</html>