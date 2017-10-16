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
            height:calc(100% - 40px);
        }
        .comments_area_tools{
            width:100%;
            height:40px;
            background-color:#f2f2f2;
            border-top:1px solid #d4d4d4;
        }
        .comment_content{
            width: calc(100% - 82px);
            border-radius: 4px;
            border: 1px solid #c3c3c3;
            resize: none;
            position: absolute;
            left: 4px;
            top: 2px;
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
            bottom: 5px;
            padding-left: 2px;
            padding-right: 2px;
        }
    </style>
    """
    $("#hotpoor_shares").append """
        <div class="comments_area"></div>
        <div class="comments_area_tools">
            <textarea class="comment_content"></textarea><button class="comment_submit">发送</button>
        </div>
    """