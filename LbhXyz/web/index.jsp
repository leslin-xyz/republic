<!DOCTYPE html>
<%@ page import="xyz.lbhxyz.doMain.CookieUtils" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>欢迎来到小站</title>
  <style>
    body{
      margin: 1px;
      padding: 1px;
      background:url("img/1.jpg");
      background-size: cover;
     .img-responsive
    }
    p{
      color: green;
      text-align: right;
      float: right;
      margin: 1px;
      padding: 1px;
    }
    /*#time{
      color: red;
      text-align: center;
    }*/
  </style>
</head>
<body>
<p>
  <span id="time"><font color="green" size="30">5</font></span>秒后自动跳转到首页...
</p>
<script>
  var sec = 5;
  var time = document.getElementById("time");
  function change() {
    sec--;
    if (sec <= 0) {
      location.href = "http://localhost:1119/LX/HomePage.html"

    }else{
      time.innerHTML = sec + "";
    }
  }
  setInterval(change, 1000);
</script>

<div id="java_jb">

  <%

    //设置响应的消息体的数据格式以及编码
    response.setContentType("text/html;charset=utf-8");

    //1.获取所有Cookie
    javax.servlet.http.Cookie[] cookies = request.getCookies();

    javax.servlet.http.Cookie lastTime = CookieUtils.findCookie(cookies, "LastTime");

    if (lastTime == null) {

      //设置Cookie的value, 获取当前时间的字符串，发送第一次的LastTime
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");

      String format = sdf.format(new Date());

      //URL编码
      String encode = URLEncoder.encode(format);

      //设置cookie的存活时间
      lastTime = new javax.servlet.http.Cookie("LastTime", encode);
      lastTime.setMaxAge(60 * 60 * 24 * 365);

      //发送cookie
      response.addCookie(lastTime);

      //显示第一次访问本站
      response.getWriter().write("感谢您访问本站");

    } else {

      //Cookie不为空，不是第一次访问,那么将上次访问的时间进行URL解码,并输出到页面
      String timeValue = lastTime.getValue();

      String decode = URLDecoder.decode(timeValue);

      response.getWriter().write("欢迎回来,您上次访问的时间为:" + decode);


      //设置Cookie的value, 获取当前时间的字符串，重新设置Cookie的值，重新发送cookie
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");
      String format = sdf.format(new Date());

      //URL编码
      String encode = URLEncoder.encode(format);

      //设置cookie的存活时间
      lastTime.setMaxAge(60 * 60 * 24 * 365);

      //创建新的Cookie 覆盖原先的cookie
      lastTime = new javax.servlet.http.Cookie("LastTime", encode);
      response.addCookie(lastTime);
    }
  %>

</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>