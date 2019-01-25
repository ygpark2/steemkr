library steemkr.src.model.blog.content;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';

part 'content.g.dart';

/*
  "active_votes": [
    {
      "voter": "dantheman",
      "weight": "32866333630",
      "rshares": 375241,
      "percent": 100,
      "reputation": 0,
      "time": "2016-04-07T19:15:36"
    },
 */

abstract class ActiveVotes implements Built<ActiveVotes, ActiveVotesBuilder> {
  String get voter;
  JsonObject get weight;
  JsonObject get rshares;
  int get percent;
  int get reputation;
  DateTime get time;

  ActiveVotes._();

  factory ActiveVotes([updates(ActiveVotesBuilder b)]) = _$ActiveVotes;

  static Serializer<ActiveVotes> get serializer => _$activeVotesSerializer;
}

abstract class Content implements Built<Content, ContentBuilder> {
  int get id;
  String get author;
  String get permlink;
  String get category;
  String get parent_author;
  String get parent_permlink;
  String get title;
  String get body;
  String get json_metadata;
  DateTime get last_update;
  DateTime get created;
  DateTime get active;
  DateTime get last_payout;
  int get depth;
  int get children;
  int get net_rshares;
  int get abs_rshares;
  int get vote_rshares;
  String get children_abs_rshares;
  DateTime get cashout_time;
  DateTime get max_cashout_time;
  int get total_vote_weight;
  int get reward_weight;
  String get total_payout_value;
  String get curator_payout_value;
  int get author_rewards;
  int get net_votes;
  String get root_author;
  String get root_permlink;
  String get max_accepted_payout;
  int get percent_steem_dollars;
  bool get allow_replies;
  bool get allow_votes;
  bool get allow_curation_rewards;
  BuiltList<JsonObject> get beneficiaries;
  String get url;
  String get root_title;
  String get pending_payout_value;
  String get total_pending_payout_value;
  BuiltList<ActiveVotes> get active_votes;
  BuiltList<JsonObject> get replies;
  String get author_reputation;
  String get promoted;
  int get body_length;
  BuiltList<JsonObject> get reblogged_by;

  Content._();

  factory Content([updates(ContentBuilder b)]) = _$Content;

  static Serializer<Content> get serializer => _$contentSerializer;
}
