import re
import os
import time
import json
from pathlib import Path
from playwright.sync_api import Playwright, sync_playwright, TimeoutError

def login_with_cookie_or_password(page, context, username, password):
    """先尝试cookie登录，失败后执行密码登录流程"""
    cookie_file = Path("deepnote_cookies.json")
    cookie_login_successful = False
    
    # 先尝试使用cookie登录
    if cookie_file.exists():
        try:
            print("尝试使用cookie登录")
            with open(cookie_file, "r") as f:
                cookies = json.load(f)
            context.add_cookies(cookies)
            
            # 通过导航到登录页面测试cookies是否有效
            if page.url != "https://deepnote.com/sign-in":
                page.goto("https://deepnote.com/sign-in", wait_until="domcontentloaded")
            
            # 等待看是否重定向到工作区
            try:
                page.wait_for_url("**/workspace/**", timeout=10000)
                current_url = page.url
                if re.match(r"https://deepnote.com/workspace/.*", current_url):
                    print("Cookie登录成功，导航到工作区")
                    cookie_login_successful = True
            except TimeoutError:
                print("Cookie登录失败，URL未变更为工作区")
        except Exception as e:
            print(f"加载或使用cookies时出错: {str(e)}")
    else:
        print("未找到cookie文件，将使用密码登录")
    
    # 如果cookie登录失败，执行密码登录
    if not cookie_login_successful:
        print("执行密码登录流程")
        
        # 导航到DeepNote登录页面
        if page.url != "https://deepnote.com/sign-in":
            page.goto("https://deepnote.com/sign-in", wait_until="domcontentloaded")
        
        # 适当延迟确保页面元素加载
        time.sleep(3)
        
        # 尝试找到GitHub登录按钮
        github_button = None
        selectors = [
            "text=Continue with GitHub",
            "text=GitHub",
            '//button[contains(., "GitHub")] | //a[contains(., "GitHub")]',
            'button:has-text("GitHub")'
        ]
        
        for selector in selectors:
            try:
                if selector.startswith("text="):
                    github_button = page.get_by_text(selector[5:])
                elif selector.startswith("//"):
                    github_button = page.locator(selector)
                else:
                    github_button = page.locator(selector)
                
                if github_button.is_visible(timeout=2000):
                    github_button.click()
                    print("点击GitHub登录按钮")
                    break
            except:
                continue
        
        if github_button is None:
            print("无法找到GitHub登录按钮")
            return False
            
        # 等待页面导航完成
        page.wait_for_load_state("domcontentloaded", timeout=10000)
        time.sleep(2)
        
        # 寻找并填写用户名
        username_selectors = [
            'input[name="login"]',
            '#login_field',
            'input[placeholder*="username"]'
        ]
        
        for selector in username_selectors:
            try:
                username_field = page.locator(selector)
                if username_field.is_visible(timeout=2000):
                    username_field.fill(username)
                    print("已输入用户名")
                    break
            except:
                continue
        
        # 寻找并填写密码
        password_selectors = [
            'input[name="password"]',
            '#password',
            'input[type="password"]'
        ]
        
        for selector in password_selectors:
            try:
                password_field = page.locator(selector)
                if password_field.is_visible(timeout=2000):
                    password_field.fill(password)
                    print("已输入密码")
                    break
            except:
                continue
        
        # 点击登录按钮
        login_selectors = [
            'button:has-text("Sign in")',
            'input[value="Sign in"]',
            '//button[contains(text(), "Sign in")]',
            'form button[type="submit"]'
        ]
        
        for selector in login_selectors:
            try:
                sign_in_button = page.locator(selector)
                if sign_in_button.is_visible(timeout=2000):
                    sign_in_button.click()
                    print("已点击登录按钮")
                    break
            except:
                continue
        
        # 等待登录后的导航
        page.wait_for_load_state("domcontentloaded", timeout=15000)
        
        # 保存成功登录后的cookies
        try:
            page.wait_for_url("**/workspace/**", timeout=10000)
            cookies = context.cookies()
            with open(cookie_file, "w") as f:
                json.dump(cookies, f)
            print("已将cookies保存到文件")
        except TimeoutError:
            print("登录可能失败，URL未变更为工作区")
    
    # 检查最终登录状态
    try:
        page.wait_for_url("**/workspace/**", timeout=5000)
        current_url = page.url
        if re.match(r"https://deepnote.com/workspace/.*", current_url):
            print("登录成功，导航到工作区")
            return True
        else:
            print("登录可能失败，URL未变更为工作区")
            return False
    except TimeoutError:
        print("登录可能失败，URL未变更为工作区")
        return False

def is_app_running(page):
    """检查应用是否正在运行"""
    try:
        running_text = page.locator("text=/Running/").first
        return running_text.is_visible(timeout=3000)
    except Exception:
        return False

def try_click_run_button(page):
    """尝试点击Run按钮"""
    run_selectors = [
        'button:has-text("Run")', 
        '//button[contains(text(), "Run")]',
        'button:has-text("run")',
        'button:has-text("Start")'
    ]
    
    for selector in run_selectors:
        try:
            run_button = page.locator(selector)
            if run_button.is_visible(timeout=2000):
                run_button.click()
                print("点击了运行按钮")
                return True
        except Exception:
            continue
    
    print("未找到'Run'按钮")
    return False

def run(playwright: Playwright) -> None:
    # 从环境变量获取凭据
    try:
        credentials = os.environ.get('GT_PW', '')
        username, password = credentials.split(' ', 1)
    except ValueError:
        print("错误: GT_PW环境变量设置不正确。格式应为'username password'")
        return
    
    # 从环境变量获取URL
    url = os.environ.get('DEEP_URL', '')
    if not url:
        print("警告: DEEP_URL环境变量未设置。登录后将不导航。")
    
    # 启动浏览器，降低性能需求
    browser = playwright.firefox.launch(
        headless=True,
        firefox_user_prefs={
            "browser.cache.disk.enable": False,
            "browser.cache.memory.enable": False,
            "browser.sessionhistory.max_entries": 2,
            "media.autoplay.default": 5,  # 禁用自动播放
            "image.animation_mode": "none",  # 禁用动画
            "permissions.default.image": 2  # 禁用图片加载
        }
    )
    context = browser.new_context(
        viewport={"width": 800, "height": 600},  # 缩小默认视口
        java_script_enabled=True,  # 必须启用JavaScript
        is_mobile=False,
        has_touch=False,
        user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) Firefox/100.0"
    )
    
    # 降低资源使用，减少请求
    context.route("**/*.{png,jpg,jpeg,gif,svg,css,woff,woff2,ttf,otf}", lambda route: route.abort())
    context.route("**/(analytics|tracker|telemetry|logging|stats)/**", lambda route: route.abort())
    
    # 创建新页面
    page = context.new_page()
    
    try:
        login_attempts = 0
        max_login_attempts = 3
        app_running = False
        
        # 登录循环
        while login_attempts < max_login_attempts and not app_running:
            login_attempts += 1
            print(f"登录尝试 {login_attempts}/{max_login_attempts}")
            
            if not page or page.is_closed():
                page = context.new_page()
            
            # 执行登录
            login_successful = login_with_cookie_or_password(page, context, username, password)
            
            if login_successful:
                # 导航到指定URL（如果提供）
                if url:
                    try:
                        page.goto(url, wait_until="domcontentloaded", timeout=20000)
                        print(f"已导航到指定的deepnode保活链接")
                    except TimeoutError:
                        print(f"导航到deepnode保活链接时超时，但继续执行")
                
                # 检查应用是否正在运行
                app_running = is_app_running(page)
                
                # 如果应用未运行，尝试点击"Run"按钮
                if not app_running:
                    try_click_run_button(page)
                    
                    # 检查应用是否正在运行
                    time.sleep(10)  # 减少等待时间
                    app_running = is_app_running(page)
                
                if app_running:
                    print("应用已成功运行！")
                    break
                else:
                    print(f"应用未运行，将重试。尝试 {login_attempts}/{max_login_attempts}")
            else:
                print(f"登录失败，将重试。尝试 {login_attempts}/{max_login_attempts}")
        
        # 最终检查
        if app_running:
            print("脚本执行成功：应用正在运行")
        else:
            print(f"脚本执行失败：在{max_login_attempts}次尝试后应用仍未运行")
    
    finally:
        # 关闭浏览器
        if 'page' in locals() and page and not page.is_closed():
            page.close()
        if 'context' in locals() and context:
            context.close()
        if 'browser' in locals() and browser:
            browser.close()
        print("浏览器已关闭")

if __name__ == "__main__":
    with sync_playwright() as playwright:
        run(playwright)
