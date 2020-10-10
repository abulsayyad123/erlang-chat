-module (message_router).

-compile(export_all).

start(PrintFunc) ->
  spawn(message_router, route_message, [PrintFunc]).

stop(RouterPid) ->
  RouterPid ! shutdown.

send_chat_message(RouterPid, Addressee, MessageBody)  ->
  RouterPid ! { send_chat_msg, Addressee, MessageBody }.

route_message(PrintFunc) ->
  receive
    {send_chat_msg, Adresse, MessageBody} ->
      Adresse ! {received_chat_msg, MessageBody},
      route_message(PrintFunc);
    {received_chat_msg, MessageBody} ->
      PrintFunc(MessageBody);
    {shutdown}  ->
      io:format("Shutting Down the process~n");
    Oops ->
      io:format("Warning! Received: ~p~n", [Oops]),
      route_message(PrintFunc)
  end.