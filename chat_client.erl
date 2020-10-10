-module (chat_client).

-compile(export_all).


send_message(RouterPid, Addresse, MessageBody) ->
  message_router:send_chat_message(RouterPid, Addresse, MessageBody).

print_message(MessageBody) ->
  io:format("Received message: ~p~n", [MessageBody]).

start_router()  ->
  message_router:start(fun chat_client:print_message/1).