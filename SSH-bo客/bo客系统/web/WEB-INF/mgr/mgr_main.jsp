<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
    String ctx = request.getContextPath();
    pageContext.setAttribute("ctx", ctx);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>博客后台管理系统</title>
    <link rel="stylesheet" href="${ctx }/css/style.css"
          type="text/css" />
    <link rel="stylesheet" href="${ctx }/css/amazeui.min.css" />
    <link rel="stylesheet" href="${ctx }/css/pageStyle.css">

</head>
<body style="background:#f3f3f3;">

<div class="main_top">
    <div class="am-cf am-padding am-padding-bottom-0">
        <div class="am-fl am-cf"><strong class="am-text-primary am-text-lg">文章管理
        </strong><small></small></div>
    </div>
    <hr>
    <div class="am-g">
        <div class="am-u-sm-12 am-u-md-6">
            <div class="am-btn-toolbar">
                <div class="am-btn-group am-btn-group-xs">
                    <button id="add" class="am-btn am-btn-default">
                        <span class="am-icon-plus"></span> 新增</button>
                </div>
            </div>
        </div>
        <div class="am-u-sm-12 am-u-md-3">

        </div>
        <div class="am-u-sm-12 am-u-md-3">
            <div class="am-input-group am-input-group-sm">
                <input type="text" class="am-form-field" id="input_search" value="<s:property value="#parameters.keyWord"/>">
                <span class="am-input-group-btn">
                    <button class="am-btn am-btn-default" type="button" id="input_search_btn">搜索</button>
                </span>
            </div>
        </div>
    </div>
</div>

<div class="goods_list">
    <ul class="title_ul">
        <li>序号</li>
        <li>标题</li>
        <li>学科</li>
        <li>编辑</li>
        <li>删除</li>
    </ul>

    <s:iterator value="list" >
        <ul class="list_goods_ul">
            <li><s:property value="article_id"/></li>
            <li><s:property value="article_title"/></li>
            <li><s:property value="category.cname "/></li>
            <li>
                <a href="${ctx}/article_edit?article_id=<s:property value="article_id"/>">
                <img class="img_icon" src="${ctx }/images/edit_icon.png" alt=""></a>
            </li>
            <li>
                <a href="${ctx}/article_delete?article_id=<s:property value="article_id"/> ">
                    <img class="img_icon" src="${ctx }/images/delete_icon.png" alt="">
                </a>
            </li>
        </ul>
    </s:iterator>
    <!--分页-->
    <div id="page" class="page_div"></div>
</div>

<script src="${ctx}/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/js/paging.js"></script>
<script>
    
    //分页
    $("#page").paging({
        pageNo:<s:property value="currentPage"/>,
        totalPage:<s:property value="totalPage"/>,
        totalSize:<s:property value="totalCount"/>,
        callback: function(num) {
            var keyWord = $("#input_search").val();
         $(window).attr('location','${ctx }/article_pageList?currPage='+num+"&keyWord="+keyWord);
        }
    });

    $("#add").click(function () {
        $(window).attr('location','${ctx }/location_add');
    });

    $("#input_search_btn").click(function () {
        var keyWord = $("#input_search").val();
        $(window).attr('location','${ctx }/article_pageList?keyWord='+keyWord);
    })
</script>

</body>
</html>