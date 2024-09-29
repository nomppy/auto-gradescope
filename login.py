import json
from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait

def save_cookies(filename, cookies):
    with open (filename, 'w') as filehandler:
        json.dump(cookies, filehandler)

driver = webdriver.Chrome()
driver.get('https://www.gradescope.com/login')

plsrememberme = WebDriverWait(driver, timeout=120).until(lambda d: d.get_cookie('remember_me'))['value']
cks = driver.get_cookies()
save_cookies('cookies.json', cks)
print('cookies saved! you can now start the main script')

