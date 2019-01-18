import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'test_class.g.dart';

/*
"id":28,
"name":"steemit",
"owner":{
  "weight_threshold":1,
  "account_auths":[],
  "key_auths":[["STM6Ezkzey8FWoEnnHHP4rxbrysJqoMmzwR2EdoD5p7FDsF64qxbQ",1],["STM7TCZKisQnvR69CK9BaL6W4SJn2cXYwkfWYRicoVGGzhtFswxMH",1]]
},
"active":{
  "weight_threshold":1,
  "account_auths":[],
  "key_auths":[["STM5VkLha96X5EQu3HSkJdD8SEuwazWtZrzLjUT6Sc5sopgghBYrz",1],["STM7u1BsoqLaoCu9XHi1wjWctLWSFCuvyagFjYMfga4QNWEjP7d3U",1]]
},
"posting":{
  "weight_threshold":1,
  "account_auths":[],
  "key_auths":[["STM6kXdRbWgoH9E4hvtTZeaiSbY8FmGXQavfJZ2jzkKjT5cWYgMBS",1],["STM6tDMSSKa8Bd9ss7EjqhXPEHTWissGXJJosAU94LLpC5tsCdo61",1]]
},
"memo_key":"STM5jZtLoV8YbxCxr4imnbWn61zMB24wwonpnVhfXRmv7j6fk3dTH",
"json_metadata":"",
"proxy":"",
"last_owner_update":"2018-05-31T23:32:06",
"last_account_update":"2018-05-31T23:32:06",
"created":"2016-03-24T17:00:21",
"mined":true,
"recovery_account":"steem",
"last_account_recovery":"1970-01-01T00:00:00",
"reset_account":"null",
"comment_count":0,
"lifetime_vote_count":0,
"post_count":1,
"can_vote":true,
"voting_manabar":{
  "current_mana":"69835912701503862",
  "last_update_time":1547349039
},
"voting_power":0,
"balance":"1.002 STEEM",
"savings_balance":"0.000 STEEM",
"sbd_balance":"8716.535 SBD",
"sbd_seconds":"0",
"sbd_seconds_last_update":"2019-01-13T03:37:18",
"sbd_last_interest_payment":"2019-01-13T03:37:18",
"savings_sbd_balance":"0.000 SBD",
"savings_sbd_seconds":"0",
"savings_sbd_seconds_last_update":"1970-01-01T00:00:00",
"savings_sbd_last_interest_payment":"1970-01-01T00:00:00",
"savings_withdraw_requests":0,
"reward_sbd_balance":"0.001 SBD",
"reward_steem_balance":"0.359 STEEM",
"reward_vesting_balance":"730.389810 VESTS",
"reward_vesting_steem":"0.363 STEEM",
"vesting_shares":"90039851836.689703 VESTS",
"delegated_vesting_shares":"20203939135.185841 VESTS",
"received_vesting_shares":"0.000000 VESTS",
"vesting_withdraw_rate":"5254073716.307692 VESTS",
"next_vesting_withdrawal":"2019-01-20T03:12:06",
"withdrawn":0,"to_withdraw":"68302958312000000",
"withdraw_routes":4,
"curation_rewards":0,
"posting_rewards":3548,
"proxied_vsf_votes":["14574552899",0,0,0],
"witnesses_voted_for":0,
"last_post":"2016-03-30T18:30:18",
"last_root_post":"2016-03-30T18:30:18",
"last_vote_time":"2016-12-04T23:10:57",
"post_bandwidth":0,
"pending_claimed_accounts":0,
"vesting_balance":"0.000 STEEM",
"reputation":"12944616889",
"transfer_history":[],
"market_history":[],
"post_history":[],
"vote_history":[],
"other_history":[],"witness_votes":[],"tags_usage":[],"guest_bloggers":[]}
 */
abstract class Account implements Built<Account, AccountBuilder> {
  String get name;
  String get result;

  Account._();

  factory Account([updates(AccountBuilder b)]) = _$Account;

  static Serializer<Account> get serializer => _$accountSerializer;
}
