package com.kh.websocket;

import javax.websocket.Decoder.Text;
import javax.websocket.EndpointConfig;

import com.google.gson.Gson;

public class JsonDecoder implements Text<Message>{

	// decoder를 작성하면 사용자가 jsp에서 보낸 요청을 바로 chattingserver에 넘기는게 아니라 decoder를 거쳐감.
	// decoder를 사용하려면 chattingserver 경로에 추가로 decoder 달아줘야함.
	// 여기서 decode로 message 객체 만들어서 chattingserver에 넘겨줌
	
	@Override
	public void destroy() {
		
	}
	
	
	@Override
	public void init(EndpointConfig arg0) {
		
	}
	
	@Override
	public boolean willDecode(String msg) {
		return true;
	}
	
	@Override
	public Message decode(String msg) {
		return new Gson().fromJson(msg, Message.class);
	}



}
