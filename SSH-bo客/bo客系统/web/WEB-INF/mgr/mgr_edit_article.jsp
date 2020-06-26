<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
    pageContext.setAttribute("ctx", ctx);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>博客后台管理系统</title>
    <link rel="stylesheet" href="${ctx }/css/style.css" type="text/css" />
    <link rel="stylesheet" href="${ctx }/css/amazeui.min.css" />
    <script type="text/javascript" charset="utf-8" src="${ctx }/js/umedit/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx }/js/umedit/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="${ctx }/js/umedit/lang/zh-cn/zh-cn.js"></script>
    <script src="${ctx }/js/jquery.min.js"></script>
    <style>
        .update_pic{
            margin-bottom: 150px;
        }
        #imageview{
            width: 300px;
            height: 250px;
        }
    </style>
</head>
<body>


<div class="main_top">
    <div class="am-cf am-padding am-padding-bottom-0">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">修改文章
        </strong><small></small></div>
    </div>
    <hr>
    <form id="blog_form" action="${ctx}/article_update" method=post  enctype="multipart/form-data">
        <div class="edit_content">
            <div class="item1">
                <div>
                    <span>文章标题：</span>
                    <input type="text" class="am-form-field" name="article_title" style="width: 300px"
                           value="<s:property value="article_title"/>"
                    >&nbsp;&nbsp;
                </div>
            </div>

            <input type="text" name="article_desc" id="article_desc" style="display: none;">


            <div class="item1">
                <span>所属分类：</span>
                <select id="category_select" name="category.parentid" style="width: 150px">&nbsp;&nbsp;

                </select>

                <select id="skill_select" name="category.cid" style="width: 150px">&nbsp;&nbsp;

                </select>

            </div>

            <div class="item1 update_pic" >
                <span>摘要图片：</span>
                <img src="${ctx}/upload/<s:property value="article_pic"/>" id="imageview" class="item1_img"  >
                <label for="fileupload" id="label_file">上传文件</label>
                <input type="file" name="upload" id="fileupload"/>
            </div>

            <div id="editor" name="article_content" style="width:900px;height:400px;"></div>
            <input type="hidden" id="resContent" value="<s:property value="article_content"/> ">
            <input type="hidden"  name="article_id" value=<s:property value="article_id"/>>
            <input type="hidden" name="article_pic" value="<s:property value="article_pic"/> ">

            <button class="am-btn am-btn-default" type="button" id="send" style="margin-top: 10px;">
                修改</button>
        </div>

    </form>

</div>
<script>
    $(function () {



        //发送请求获取分类数据
        $.post("${pageContext.request.contextPath}/article_getCategory",{"parentid":0},function (data) {
            console.log(data);
            // $("#category_select").empty();
            //遍历数组
            $(data).each(function (i,obj) {
                console.log(obj.cname);
                $("#category_select").append("<option value="+obj.cid+">"+obj.cname+"</option>");
            })
            $("#category_select option[value=<s:property value="category.parentid"/>]").prop("selected",true);
        },"json");


        var parentid =<s:property value="category.parentid"/>
        //发送请求获取分类数据
        $.post("${pageContext.request.contextPath}/article_getCategory",{"parentid":parentid},function (data) {
            $("#skill_select").empty();
            $(data).each(function (i,obj) {
                console.log(obj.cname);
                $("#skill_select").append("<option value="+obj.cid+">"+obj.cname+"</option>");
            })


            $("#skill_select option[value=<s:property value="category.cid"/>]").prop("selected",true);

        },"json");


        //监听分类select改变
        $("#category_select").on("change",function () {
            //获取当前选定的cid
            var cid =$("#category_select").val();
            // alert(cid);
            $.post("${pageContext.request.contextPath}/article_getCategory",{"parentid":cid},function (data) {
                console.log(data);
                //遍历数组
                //清空之前的标签
                $("#skill_select").empty();
                $(data).each(function (i,obj) {
                    console.log(obj.cname);
                    $("#skill_select").append("<option value="+obj.cid+">"+obj.cname+"</option>");
                })
            },"json");
        });


        /*原理是把本地图片路径："D(盘符):/image/..."转为"http://..."格式路径来进行显示图片*/
        $("#fileupload").change(function() {
            var $file = $(this);
            var objUrl = $file[0].files[0];
            //获得一个http格式的url路径:mozilla(firefox)||webkit or chrome
            var windowURL = window.URL || window.webkitURL;
            //createObjectURL创建一个指向该参数对象(图片)的URL
            var dataURL;
            dataURL = windowURL.createObjectURL(objUrl);
            $("#imageview").attr("src",dataURL);
            console.log($('#imageview').attr('style'));
            if($('#imageview').attr('style') === 'display: none;'){
                $('#imageview').attr('style','inline');
                $('#imageview').width("300px");
                $('#imageview').height("200px");
                $('.update_pic').attr('style', 'margin-bottom: 80px;');
            }
        });

        //初始化富文本编辑器
        var ue =UE.getEditor('editor');
        ue.ready(function () {
            ue.execCommand("inserthtml",$("#resContent").val());
        })
        $("#send").click(function () {
            //设置文本的描述
            //获取富文本正文
            var text= ue.getContentTxt();
            //截取描述
            text=text.substring(0,150)+"...";
            //设置描述
            $("#article_desc").val(text);
            //提交表单
            $("#blog_form").submit();
        })

    });







</script>

</body>
</html>