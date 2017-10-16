$ ->
    $("#hotpoor_shares_qrcode_weixin_area").remove()
    $("#hotpoor_shares").css
        "position":"relative"
        "paddingBottom":"0px"
        "height":"100%"
    $("#hotpoor_shares").append """
    <style>
        .comments_area{

        }
        .comments_area_tools{
            position:fixed;
            bottom:0px;
            width:100%;
            height:40px;
            background-color:#f2f2f2;
            border-top:1px solid #999;
        }
    </style>
    """
    $("#hotpoor_shares").append """
        <div class="comments_area"></div>
        <div class="comments_area_tools">
            <textarea></textarea><button>发送<button>
        </div>
    """