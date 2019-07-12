package xyz.lbhxyz.doMain;

import javax.servlet.http.Cookie;

public class CookieUtils {
    /**
     * 根据指定名称获取Cookie对象
     *
     * @param cookies
     * @param cookieName
     * @return
     */
    public static Cookie findCookie(Cookie[] cookies, String cookieName) {
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookieName.equals(cookie.getName())) {
                    return cookie;
                }
            }
        }
        return null;
    }
}