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
            height: 30px;
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

    roomId = "0cd8429c1da249b6935d7eef72d7fc0b"
    rooms_info = {}
    members_json = {}
    load_start = ()->
        $(".comments_area").empty()
        $.ajax
            url: 'http://www.hotpoor.org/api/comment/load'
            type: 'POST'
            dataType: 'json'
            data:
                app: WX_APP
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
                    for comment in comments
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
            error: (error)->
                console.log(error)
    load_start()

