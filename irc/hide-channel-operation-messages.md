# Hide channel operation messages

I tried a new IRC client today ([weechat](https://weechat.org/), and was
immediately overwhelmed by the huge number of `joined` / `quit` messages that
it puts out:

```
 --> | user has joined #channel
 --> | correct_horse_battery_staple has joined #channel
 --> | lurker has joined #channel
 <-- | lurker has quit (Ping timeout: 240)
 --> | troll has joined #channel
 --> | two_cents has joined #channel
user | A message you actually care about
 --> | bad_connection has joined #channel
 <-- | bad_connection has quit (Read error: Connection reset by peer)
 --> | bad_connection has joined #channel
```

These "channel operation" messages are part of the specification of IRC ([RFC
1459][rfc-channel-operation]). Fortunately, Weechat has a number of built-in
_filters_ for these messages (disabled by default). For instance, you can
disable all channel activity messages with the following command:

```
/filter add joinquit * irc_join,irc_part,irc_quit *
```

Even better, you can use the ["smart"
filter](https://weechat.org/files/doc/devel/weechat_user.en.html#irc_smart_filter_join_part_quit)
to only filter out such messages for users that haven't said anything for some
number of minutes:

```
/set irc.look.smart_filter on
/set irc.look.smart_filter_delay 5
/filter add irc_smart * irc_smart_filter *
```

[Source](https://blog.weechat.org/post/2008/10/25/Smart-IRC-join-part-quit-message-filter).

[rfc-channel-operation]: https://tools.ietf.org/html/rfc1459#section-4.2
[weechat]: https://weechat.org/
