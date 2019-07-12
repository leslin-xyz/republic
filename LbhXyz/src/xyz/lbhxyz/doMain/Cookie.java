package xyz.lbhxyz.doMain;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * cookie小案例
 * 记录用户浏览器访问服务器的时间,并在首页展示出来
 */
@WebServlet("/CD03")
class Cookie extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

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
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
