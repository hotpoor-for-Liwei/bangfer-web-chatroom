// Generated by CoffeeScript 1.12.7
(function() {
  $(function() {
    var base_room, base_rooms, escapeHTML, formatDate, i, imgUrl, initialRoomId, initialRoomImg, initialRoomName, isLoadingMore, len, loadHistory, loadMessage, load_start, members_json, onRoomScroll, roomId, roomName, rooms_info, targetRoomId, time_now;
    $("#hotpoor_shares_qrcode_weixin_area").remove();
    $("#hotpoor_shares").css({
      "position": "relative",
      "paddingBottom": "0px",
      "height": "100%"
    });
    $("#hotpoor_shares").append("<style>\n    .comments_area{\n        width:100%;\n        height:calc(100% - 44px);\n        overflow-y: auto;\n    }\n    .comments_area_tools{\n        width:100%;\n        height:44px;\n        background-color:#f2f2f2;\n        border-top:1px solid #d4d4d4;\n        position:relative;\n    }\n    .comment_content{\n        width: calc(100% - 82px);\n        border-radius: 4px;\n        border: 1px solid #c3c3c3;\n        resize: none;\n        position: absolute;\n        left: 4px;\n        top: 3px;\n        font-size: 14px;\n        padding: 4px;\n        height: 26px;\n    }\n    .comment_submit{\n        width: 60px;\n        height: 32px;\n        font-size: 15px;\n        color: #999999;\n        border-radius: 7px;\n        border: 1px solid #c3c3c3;\n        background-color: #f2f2f2;\n        position: absolute;\n        right: 4px;\n        top: 5px;\n        padding-left: 2px;\n        padding-right: 2px;\n    }\n    .wxmsg{\n        width:100%;\n        padding:5px 0px 10px 0px;\n    }\n    .wxmsg_time{\n        margin: 2px;\n    }\n    .wxmsg_time>div{\n        background-color:rgba(0,0,0,0.2);\n        border-radius:4px;\n        color:white;\n        font-size:12px;\n        padding:1px 5px;\n        width: fit-content;\n    }\n    .wxmsg_head_area{\n        width:100%;\n        position:relative;\n    }\n    .wxmsg_headimg{\n        position:absolute;\n    }\n    .wxmsg_headimg.wxmsg_self{\n        right:5px;\n    }\n    .wxmsg_headimg.wxmsg_other{\n        left:5px;   \n    }\n    .wxmsg_headimg>img{\n        width: 36px;\n        height: 36px;\n        background-color: rgba(255,255,255,0.8);\n        box-shadow: 0px 0px 2px rgba(0,0,0,0.05);\n    }\n    .wxmsg_nickname{\n        font-size:14px;\n        color:#999;\n        font-weight:500;\n    }\n    .wxmsg_nickname.wxmsg_self{\n        text-align:right;\n        padding-right:50px;\n    }\n    .wxmsg_nickname.wxmsg_other{\n        text-align:left;\n        padding-left:50px;\n    }\n    .wxmsg_content{\n        text-align:left;\n        word-break: break-word;\n        background-color: white;\n        padding: 9px;\n        font-size: 14px;\n        line-height: 18px;\n        border-radius: 5px;\n        box-shadow: 0px 0px 2px rgba(0,0,0,0.2);\n        position: relative;\n        width: fit-content;\n        min-width:15px;\n        max-width:500px;\n    }\n    .wxmsg_content.wxmsg_self{\n        margin-right: 50px;\n        margin-left: 60px;\n    }\n    .wxmsg_content.wxmsg_self:before {\n        content: \" \";\n        width: 9px;\n        height: 9px;\n        background-color: white;\n        position: absolute;\n        right: -4px;\n        top: 13px;\n        box-shadow: 1px 1px 1px rgba(0,0,0,0.1);\n        transform: rotate(-45deg);\n    }\n    .wxmsg_content.wxmsg_other{\n        margin-left: 50px;\n        margin-right: 60px;\n    }\n    .wxmsg_content.wxmsg_other:before {\n        content: \" \";\n        width: 9px;\n        height: 9px;\n        background-color: white;\n        position: absolute;\n        left: -4px;\n        top: 13px;\n        box-shadow: -1px 1px 1px rgba(0,0,0,0.1);\n        transform: rotate(45deg);\n    }\n    .wxmsg_content_hqwebimg,.wxmsg_content_hwebimg{\n        max-width:100%;\n        min-width:10px;\n        max-height:200px;\n    }\n    .wxmsg_load_tip{\n        text-align:center;\n        color:#999;\n        font-size:14px;\n        padding:5px;\n    }\n</style>");
    $("#hotpoor_shares").append("<div class=\"comments_area\">\n</div>\n<div class=\"comments_area_tools\">\n    <textarea class=\"comment_content\"></textarea><button class=\"comment_submit\">发送</button>\n</div>");
    $("#hotpoor_shares").on("touchstart", ".comments_area", function(e) {
      var el_now, scrollTop;
      el_now = this;
      console.log(this);
      scrollTop = el_now.scrollTop;
      if (scrollTop === 0) {
        el_now.scrollTop = 1;
      }
      if (el_now.scrollTop + el_now.offsetHeight === el_now.scrollHeight) {
        return el_now.scrollTop = parseInt(el_now.scrollHeight) - parseInt(el_now.offsetHeight) - 1;
      }
    });
    targetRoomId = null;
    initialRoomId = "0cd8429c1da249b6935d7eef72d7fc0b";
    initialRoomImg = "http://image.hotpoor.org/2dd2c53e7c654c66b398e574848d4c34_08aed20957caca43b0df23442de17f6f?imageView2/2/w/200";
    initialRoomName = "夏力维和他的朋友们";
    base_rooms = [[initialRoomId, initialRoomImg, initialRoomName]];
    rooms_info = {};
    for (i = 0, len = base_rooms.length; i < len; i++) {
      base_room = base_rooms[i];
      roomId = base_room[0];
      imgUrl = base_room[1];
      roomName = base_room[2];
      time_now = (new Date()).getTime() / 1000;
      rooms_info[roomId] = {
        "imgUrl": imgUrl,
        "roomName": roomName,
        "createtime": time_now,
        "finishtime": null,
        "room_time_flag": time_now,
        "createuser": null,
        "finishuser": null,
        "createcommentsequence": null,
        "finishcommentsequence": null,
        "latestComment": null,
        "last_comment_id": null,
        "roomNewMsgCount": 0,
        "roomImages": []
      };
    }
    members_json = {};
    load_start = function() {
      $(".comments_area").empty();
      $(".comments_area").attr("data-room-id", roomId);
      $(".comments_area").on("scroll", function(e) {
        return onRoomScroll;
      });
      return $.ajax({
        url: 'http://www.hotpoor.org/api/comment/load',
        type: 'POST',
        dataType: 'json',
        data: {
          app: 'bangfer',
          aim_id: roomId,
          comment_id: rooms_info[roomId].last_comment_id
        },
        success: function(data) {
          var _msg, comment, comments, item_text, j, members_json_new, members_json_now, results;
          console.log(data);
          if (data.info === "ok") {
            rooms_info[roomId].last_comment_id = data.last_comment_id;
            members_json_now = members_json;
            members_json_new = data.members;
            members_json = $.extend({}, members_json_now, members_json_new);
            comments = data.comments;
            results = [];
            for (j = comments.length - 1; j >= 0; j += -1) {
              comment = comments[j];
              _msg = [
                comment[3], {
                  "content": comment[4],
                  "nickname": members_json[comment[1]].nickname,
                  "headimgurl": members_json[comment[1]].headimgurl,
                  "time": comment[2],
                  "user_id": comment[1],
                  "tel": members_json[comment[1]].tel,
                  "plus": comment[5],
                  "sequence": comment[0],
                  "comment_id": data.comment_id
                }, roomId
              ];
              console.log(_msg);
              loadMessage(_msg);
              if (rooms_info[roomId]["latestComment"] == null) {
                rooms_info[roomId]["latestComment"] = _msg;
                item_text = "";
                results.push($(".wxmsg[data-comment-flag=" + rooms_info[roomId].finishcommentsequence + "]")[0].scrollIntoView(false));
              } else {
                results.push(void 0);
              }
            }
            return results;
          }
        },
        error: function(error) {
          return console.log(error);
        }
      });
    };
    $("body").on("click", "#bangfer_shares", function(evt) {
      return $(".wxmsg[data-comment-flag=" + rooms_info[roomId].finishcommentsequence + "]")[0].scrollIntoView(false);
    });
    $("body").on("click", ".wxmsg_content_hqwebimg,.wxmsg_content_hwebimg", function(evt) {
      return wx.previewImage({
        current: $(this).attr("data-uri"),
        urls: rooms_info[roomId].roomImages
      });
    });
    loadMessage = function(msg) {
      var comment_id, comment_sequence, content, content_html, content_type, content_values, error_img, headimg, img_uri, msgType, msg_headimg_hide, msg_html, msg_html_align, msg_nickname_hide, msg_owner, msg_time_hide, nickname, plus, plus_content, plus_content_destination, plus_type, tel, time, timer, user_id;
      msgType = msg[0];
      roomId = msg[2];
      content = msg[1].content;
      content = escapeHTML(content);
      content = content.replace(/\n/g, '<br>');
      headimg = msg[1].headimgurl;
      nickname = msg[1].nickname;
      timer = msg[1].time;
      time = formatDate(timer);
      user_id = msg[1].user_id;
      tel = msg[1].tel;
      plus = msg[1].plus;
      plus_content = escapeHTML(plus.content);
      plus_type = escapeHTML(plus.type);
      if (plus.destination == null) {
        plus_content_destination = "";
      } else {
        plus_content_destination = escapeHTML(plus.destination);
      }
      if (plus_type === "百度语音转文字") {
        plus_content = plus_content.split("百度语音转文字: ")[1];
        if (plus_content_destination.split("百度语音翻译: ").length === 2) {
          plus_content_destination = plus_content_destination.split("百度语音翻译: ")[1];
        }
      }
      comment_id = msg[1].comment_id;
      comment_sequence = msg[1].sequence;
      content_type = content.split("//")[0];
      content_values = content.split("//")[1];
      if (user_id === USER_ID) {
        msg_owner = "wxmsg_self";
        msg_html_align = "right";
      } else {
        msg_owner = "wxmsg_other";
        msg_html_align = "left";
      }
      console.log((rooms_info[roomId].createtime + " - " + timer + " = ") + (rooms_info[roomId].createtime - timer));
      msg_time_hide = "";
      if (rooms_info[roomId].createtime - timer < 300) {
        $(".wxmsg[data-comment-flag=" + rooms_info[roomId].createcommentsequence + "]>.wxmsg_time").hide();
      }
      rooms_info[roomId].createtime = timer;
      rooms_info[roomId].createuser = user_id;
      rooms_info[roomId].createcommentsequence = comment_id + "_" + comment_sequence;
      if (rooms_info[roomId].finishtime == null) {
        rooms_info[roomId].finishtime = timer;
      }
      if (rooms_info[roomId].finishcommentsequence == null) {
        rooms_info[roomId].finishcommentsequence = comment_id + "_" + comment_sequence;
      }
      msg_headimg_hide = "";
      msg_nickname_hide = "";
      error_img = "http://www.hotpoor.org/static/img/tools/error_img_" + parseInt(Math.random() * 10 % 2) + ".png";
      content_html = "" + content;
      if (msgType === "COMMENT") {
        if (content_type === "HQWEBIMG") {
          img_uri = "http://image.hotpoor.org/" + roomId + "_" + content_values + "?imageView2";
          rooms_info[roomId].roomImages.unshift(img_uri);
          content_html = "<img crossorigin=\"Anonymous\" class=\"wxmsg_content_hqwebimg\" data-uri=\"" + img_uri + "\" src=\"http://image.hotpoor.org/" + roomId + "_" + content_values + "?imageView2/2/w/320\" onerror=\"this.src='" + error_img + "'\">";
        } else if (content_type === "HWEBIMG") {
          img_uri = "" + content_values;
          rooms_info[roomId].roomImages.unshift(img_uri);
          content_html = "<img crossorigin=\"Anonymous\" class=\"wxmsg_content_hwebimg\" data-uri=\"" + img_uri + "\" src=\"" + content_values + "\" onerror=\"this.src='" + error_img + "'\" >";
        }
      }
      msg_html = "<div class=\"wxmsg " + msg_owner + "\" data-comment-flag=\"" + comment_id + "_" + comment_sequence + "\" align=\"" + msg_html_align + "\">\n    <div class=\"wxmsg_time\" style=\"" + msg_time_hide + "\" align=\"center\"><div>" + time + "</div></div>\n    <div class=\"wxmsg_head_area\">\n        <div class=\"wxmsg_headimg " + msg_owner + "\"><img src=\"" + headimg + "\"></div>\n    </div>\n    <div class=\"wxmsg_nickname " + msg_owner + "\"><span>" + nickname + "</span></div>\n    <div class=\"wxmsg_content " + msg_owner + "\">" + content_html + "</div>\n</div>";
      return $('.comments_area').prepend(msg_html);
    };
    loadHistory = function(currentRoomId) {
      var isLoadingMore;
      isLoadingMore = true;
      $('.comments_area').prepend("<div class=\"wxmsg_load_tip\">加载中...</div>");
      return $.ajax({
        url: 'http://www.hotpoor.org/api/comment/load',
        type: 'POST',
        dataType: 'json',
        data: {
          app: 'bangfer',
          aim_id: currentRoomId,
          comment_id: rooms_info[currentRoomId].last_comment_id
        },
        success: function(data) {
          var _msg, comment, comments, item_text, j, members_json_new, members_json_now;
          console.log(data);
          if (data.info === "ok") {
            rooms_info[currentRoomId].last_comment_id = data.last_comment_id;
            members_json_now = members_json;
            members_json_new = data.members;
            members_json = $.extend({}, members_json_now, members_json_new);
            comments = data.comments;
            for (j = comments.length - 1; j >= 0; j += -1) {
              comment = comments[j];
              _msg = [
                comment[3], {
                  "content": comment[4],
                  "nickname": members_json[comment[1]].nickname,
                  "headimgurl": members_json[comment[1]].headimgurl,
                  "time": comment[2],
                  "user_id": comment[1],
                  "tel": members_json[comment[1]].tel,
                  "plus": comment[5],
                  "sequence": comment[0],
                  "comment_id": data.comment_id
                }, roomId
              ];
              console.log(_msg);
              loadMessage(_msg);
              if (rooms_info[currentRoomId]["latestComment"] == null) {
                rooms_info[currentRoomId]["latestComment"] = _msg;
                item_text = "";
                $(".wxmsg[data-comment-flag=" + rooms_info[roomId].finishcommentsequence + "]")[0].scrollIntoView(false);
              }
            }
            isLoadingMore = false;
            return $(".wxmsg_load_tip").remove();
          }
        },
        error: function(error) {
          return console.log(error);
        }
      });
    };
    isLoadingMore = false;
    onRoomScroll = function(evt) {
      var cu_el, cu_roomId, cu_scrollTop;
      cu_el = $(evt.currentTarget);
      cu_roomId = cu_roomId.data("room-id");
      cu_scrollTop = cu_el.scrollTop();
      if (cu_scrollTop < 10 && !isLoadingMore) {
        if (rooms_info[cu_roomId].last_comment_id != null) {
          return loadHistory(cu_roomId);
        }
      }
    };
    formatDate = function(now) {
      var comment_time_now, date, hour, minute, month, now_date, year;
      now_date = new Date(now * 1000);
      comment_time_now = new Date;
      year = now_date.getFullYear();
      month = now_date.getMonth() + 1;
      date = now_date.getDate();
      hour = now_date.getHours();
      minute = now_date.getMinutes();
      if (hour < 10) {
        hour = "0" + hour;
      }
      if (minute < 10) {
        minute = "0" + minute;
      }
      if (comment_time_now.getFullYear() === year && comment_time_now.getMonth() + 1 === month && comment_time_now.getDate() === date) {
        return hour + ":" + minute;
      }
      if (comment_time_now.getFullYear() === year) {
        return month + "月" + date + "日 " + hour + ":" + minute;
      }
      return year + "年" + month + "月" + date + "日 " + hour + ":" + minute;
    };
    escapeHTML = function(str) {
      return $('<div></div>').text(str).html();
    };
    return load_start();
  });

}).call(this);
