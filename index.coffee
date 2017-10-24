$ ->
    $("#hotpoor_shares_qrcode_weixin_area").remove()
    $("#hotpoor_shares").css
        "position":"relative"
        "paddingBottom":"0px"
        "height":"100%"
    $("#hotpoor_shares").append """
    <style>
        .comments_area{
            width:100%;
            height:calc(100% - 44px);
            overflow-y: auto;
        }
        .comments_area_tools{
            width:100%;
            height:44px;
            background-color:#f2f2f2;
            border-top:1px solid #d4d4d4;
            position:relative;
        }
        .comment_content{
            width: calc(100% - 82px);
            border-radius: 4px;
            border: 1px solid #c3c3c3;
            resize: none;
            position: absolute;
            left: 4px;
            top: 3px;
            font-size: 14px;
            padding: 4px;
            height: 26px;
        }
        .comment_submit{
            width: 60px;
            height: 32px;
            font-size: 15px;
            color: #999999;
            border-radius: 7px;
            border: 1px solid #c3c3c3;
            background-color: #f2f2f2;
            position: absolute;
            right: 4px;
            top: 5px;
            padding-left: 2px;
            padding-right: 2px;
        }
        .wxmsg{
            width:100%;
            padding:5px 0px 10px 0px;
        }
        .wxmsg_time{
            margin: 2px;
        }
        .wxmsg_time>div{
            background-color:rgba(0,0,0,0.2);
            border-radius:4px;
            color:white;
            font-size:12px;
            padding:1px 5px;
            width: fit-content;
        }
        .wxmsg_head_area{
            width:100%;
            position:relative;
        }
        .wxmsg_headimg{
            position:absolute;
        }
        .wxmsg_headimg.wxmsg_self{
            right:5px;
        }
        .wxmsg_headimg.wxmsg_other{
            left:5px;   
        }
        .wxmsg_headimg>img{
            width: 36px;
            height: 36px;
            background-color: rgba(255,255,255,0.8);
            box-shadow: 0px 0px 2px rgba(0,0,0,0.05);
        }
        .wxmsg_nickname{
            font-size:14px;
            color:#999;
            font-weight:500;
        }
        .wxmsg_nickname.wxmsg_self{
            text-align:right;
            padding-right:50px;
        }
        .wxmsg_nickname.wxmsg_other{
            text-align:left;
            padding-left:50px;
        }
        .wxmsg_content{
            text-align:left;
            word-break: break-word;
            background-color: white;
            padding: 9px;
            font-size: 14px;
            line-height: 18px;
            border-radius: 5px;
            box-shadow: 0px 0px 2px rgba(0,0,0,0.2);
            position: relative;
            width: fit-content;
            min-width:15px;
            max-width:500px;
        }
        .wxmsg_content.wxmsg_self{
            margin-right: 50px;
            margin-left: 60px;
        }
        .wxmsg_content.wxmsg_self:before {
            content: " ";
            width: 9px;
            height: 9px;
            background-color: white;
            position: absolute;
            right: -4px;
            top: 13px;
            box-shadow: 1px 1px 1px rgba(0,0,0,0.1);
            transform: rotate(-45deg);
        }
        .wxmsg_content.wxmsg_other{
            margin-left: 50px;
            margin-right: 60px;
        }
        .wxmsg_content.wxmsg_other:before {
            content: " ";
            width: 9px;
            height: 9px;
            background-color: white;
            position: absolute;
            left: -4px;
            top: 13px;
            box-shadow: -1px 1px 1px rgba(0,0,0,0.1);
            transform: rotate(45deg);
        }
        .wxmsg_content_hqwebimg,.wxmsg_content_hwebimg{
            max-width:100%;
            min-width:10px;
            max-height:200px;
        }
        .wxmsg_load_tip{
            text-align:center;
            color:#999;
            font-size:14px;
            padding:5px;
        }
    </style>
    """
    $("#hotpoor_shares").append """
        <div class="comments_area">
        </div>
        <div class="comments_area_tools">
            <textarea class="comment_content"></textarea><button class="comment_submit">发送</button>
        </div>
    """
    $("#hotpoor_shares").on "touchstart",".comments_area",(e)->
        el_now = this
        scrollTop = el_now.scrollTop
        if scrollTop==0
            el_now.scrollTop = 1
        if el_now.scrollTop+el_now.offsetHeight==el_now.scrollHeight
            el_now.scrollTop = (parseInt(el_now.scrollHeight)-parseInt(el_now.offsetHeight)-1)

    targetRoomId = null
    initialRoomId = "0cd8429c1da249b6935d7eef72d7fc0b"
    initialRoomImg = "http://image.hotpoor.org/2dd2c53e7c654c66b398e574848d4c34_08aed20957caca43b0df23442de17f6f?imageView2/2/w/200"
    initialRoomName = "夏力维和他的朋友们"
    isLoadingMore = false
    base_rooms = [
        [
            initialRoomId
            initialRoomImg
            initialRoomName
        ]
    ]

    rooms_info = {}

    for base_room in base_rooms
        roomId = base_room[0]
        imgUrl = base_room[1]
        roomName = base_room[2]
        time_now = (new Date()).getTime() / 1000
        rooms_info[roomId] =
            "imgUrl": imgUrl
            "roomName": roomName
            "createtime": time_now
            "finishtime": null
            "room_time_flag": time_now
            "createuser":null
            "finishuser":null
            "createcommentsequence":null
            "finishcommentsequence":null
            "latestComment": null
            "last_comment_id": null
            "roomNewMsgCount": 0
            "roomImages":[]
    members_json = {}
    load_start = ()->
        $(".comments_area").empty()
        $(".comments_area").attr("data-room-id",roomId)
        $(".comments_area").on "scroll",(e)->
            onRoomScroll(e)
        $.ajax
            url: 'http://www.hotpoor.org/api/comment/load'
            type: 'POST'
            dataType: 'json'
            data:
                app: 'bangfer'
                aim_id: roomId
                comment_id: rooms_info[roomId].last_comment_id
            success: (data)->
                console.log data
                if data.info == "ok"
                    rooms_info[roomId].last_comment_id = data.last_comment_id
                    members_json_now = members_json
                    members_json_new = data.members
                    members_json = $.extend({}, members_json_now,members_json_new)
                    comments = data.comments
                    for comment in comments by -1
                        _msg = [comment[3],{
                            "content": comment[4],
                            "nickname": members_json[comment[1]].nickname,
                            "headimgurl": members_json[comment[1]].headimgurl,
                            "time": comment[2],
                            "user_id": comment[1],
                            "tel": members_json[comment[1]].tel,
                            "plus": comment[5],
                            "sequence": comment[0],
                            "comment_id": data.comment_id,
                        },roomId]
                        console.log _msg
                        loadMessage(_msg)
                        if not rooms_info[roomId]["latestComment"]?
                            rooms_info[roomId]["latestComment"] = _msg
                            item_text = ""
                            $(".wxmsg[data-comment-flag=#{rooms_info[roomId].finishcommentsequence}]")[0].scrollIntoView(false)
            error: (error)->
                console.log(error)
    $("body").on "click","#bangfer_shares",(evt)->
        $(".wxmsg[data-comment-flag=#{rooms_info[roomId].finishcommentsequence}]")[0].scrollIntoView(false)
    $("body").on "click",".wxmsg_content_hqwebimg,.wxmsg_content_hwebimg",(evt)->
        wx.previewImage
            current: $(this).attr("data-uri"), #当前显示图片的http链接
            urls: rooms_info[roomId].roomImages #需要预览的图片http链接列表
    loadMessage = (msg)->
        msgType = msg[0]
        roomId = msg[2]
        content = msg[1].content
        content = escapeHTML(content)
        content = content.replace(/\n/g, '<br>')
        headimg = msg[1].headimgurl
        nickname = msg[1].nickname
        timer = msg[1].time
        time = formatDate(timer)
        user_id = msg[1].user_id
        tel = msg[1].tel
        plus = msg[1].plus
        plus_content = escapeHTML(plus.content)
        plus_type = escapeHTML(plus.type)

        if not plus.destination?
            plus_content_destination = ""
        else
            plus_content_destination = escapeHTML(plus.destination)

        if plus_type == "百度语音转文字"
            plus_content = plus_content.split("百度语音转文字: ")[1]
            if plus_content_destination.split("百度语音翻译: ").length==2
                plus_content_destination = plus_content_destination.split("百度语音翻译: ")[1]
        comment_id = msg[1].comment_id
        comment_sequence = msg[1].sequence

        content_type = content.split("//")[0]
        content_values = content.split("//")[1]

        if user_id == USER_ID
            msg_owner = "wxmsg_self"
            msg_html_align = "right"
        else
            msg_owner = "wxmsg_other"
            msg_html_align = "left"
        console.log "#{rooms_info[roomId].createtime} - #{timer} = "+(rooms_info[roomId].createtime - timer)
        msg_time_hide = ""
        if rooms_info[roomId].createtime - timer < 300
            $(".wxmsg[data-comment-flag=#{rooms_info[roomId].createcommentsequence}]>.wxmsg_time").hide()

        rooms_info[roomId].createtime = timer
        rooms_info[roomId].createuser = user_id
        rooms_info[roomId].createcommentsequence = comment_id+"_"+comment_sequence
        if not rooms_info[roomId].finishtime?
            rooms_info[roomId].finishtime = timer
        if not rooms_info[roomId].finishcommentsequence?
            rooms_info[roomId].finishcommentsequence = comment_id+"_"+comment_sequence

        msg_headimg_hide = ""
        msg_nickname_hide = ""
        error_img = "http://www.hotpoor.org/static/img/tools/error_img_"+parseInt(Math.random()*10%2)+".png"
        content_html = "#{content}"
        if msgType == "COMMENT"
            content_values = content.split(content_type+"//")[1]
            if content_type == "HQWEBIMG"
                img_uri = "http://image.hotpoor.org/#{roomId}_#{content_values}?imageView2"
                rooms_info[roomId].roomImages.unshift(img_uri)
                content_html = """
                    <img crossorigin="Anonymous" class="wxmsg_content_hqwebimg" data-uri="#{img_uri}" src="http://image.hotpoor.org/#{roomId}_#{content_values}?imageView2/2/w/320" onerror="this.src='#{error_img}'">
                """
            else if content_type == "HWEBIMG"
                img_uri = "#{content_values}"
                rooms_info[roomId].roomImages.unshift(img_uri)
                content_html = """
                    <img crossorigin="Anonymous" class="wxmsg_content_hwebimg" data-uri="#{img_uri}" src="#{content_values}" onerror="this.src='#{error_img}'" >
                """

        msg_html = """
            <div class="wxmsg #{msg_owner}" data-comment-flag="#{comment_id}_#{comment_sequence}" align="#{msg_html_align}">
                <div class="wxmsg_time" style="#{msg_time_hide}" align="center"><div>#{time}</div></div>
                <div class="wxmsg_head_area">
                    <div class="wxmsg_headimg #{msg_owner}"><img src="#{headimg}"></div>
                </div>
                <div class="wxmsg_nickname #{msg_owner}"><span>#{nickname}</span></div>
                <div class="wxmsg_content #{msg_owner}">#{content_html}</div>
            </div>
        """
        
        $('.comments_area').prepend msg_html
    loadHistory = (currentRoomId)->
        isLoadingMore = true
        $('.comments_area').prepend """
        <div class="wxmsg_load_tip">加载中...</div>
        """
        $.ajax
            url: 'http://www.hotpoor.org/api/comment/load'
            type: 'POST'
            dataType: 'json'
            data:
                app: 'bangfer'
                aim_id: currentRoomId
                comment_id: rooms_info[currentRoomId].last_comment_id
            success: (data)->
                console.log data
                if data.info == "ok"
                    rooms_info[currentRoomId].last_comment_id = data.last_comment_id
                    members_json_now = members_json
                    members_json_new = data.members
                    members_json = $.extend({}, members_json_now,members_json_new)
                    comments = data.comments
                    commentsequence_flag = rooms_info[roomId].createcommentsequence
                    for comment in comments by -1
                        _msg = [comment[3],{
                            "content": comment[4],
                            "nickname": members_json[comment[1]].nickname,
                            "headimgurl": members_json[comment[1]].headimgurl,
                            "time": comment[2],
                            "user_id": comment[1],
                            "tel": members_json[comment[1]].tel,
                            "plus": comment[5],
                            "sequence": comment[0],
                            "comment_id": data.comment_id,
                        },roomId]
                        console.log _msg
                        loadMessage(_msg)
                        $(".wxmsg[data-comment-flag=#{commentsequence_flag}]")[0].scrollIntoView(true)
                        if not rooms_info[currentRoomId]["latestComment"]?
                            rooms_info[currentRoomId]["latestComment"] = _msg
                            item_text = ""
                            $(".wxmsg[data-comment-flag=#{rooms_info[roomId].finishcommentsequence}]")[0].scrollIntoView(false)
                    $(".wxmsg_load_tip").text("加载成功！")
                    setTimeout ()->
                        $(".wxmsg_load_tip").remove()
                        isLoadingMore = false
                    , 1000
                    
            error: (error)->
                console.log(error)

    onRoomScroll = (evt)->
        cu_el = $(evt.currentTarget)
        cu_roomId = cu_el.data("room-id")
        cu_scrollTop = cu_el.scrollTop()
        if cu_scrollTop <5 and !isLoadingMore
            if rooms_info[cu_roomId].last_comment_id?
                loadHistory(cu_roomId)

    formatDate = (now)->
        now_date = new Date(now * 1000)
        comment_time_now = new Date
        year = now_date.getFullYear()
        month = now_date.getMonth() + 1
        date = now_date.getDate()
        hour = now_date.getHours()
        minute = now_date.getMinutes()
        if hour < 10
            hour = "0" + hour
        if minute < 10
            minute = "0" + minute
        if comment_time_now.getFullYear() == year and comment_time_now.getMonth() + 1 == month and comment_time_now.getDate() == date
            return hour + ":" + minute
        if comment_time_now.getFullYear() == year
            return month + "月" + date + "日 " + hour + ":" + minute
        return year + "年" + month + "月" + date + "日 " + hour + ":" + minute

    escapeHTML = (str)->
        return $('<div></div>').text(str).html()
    load_start()

