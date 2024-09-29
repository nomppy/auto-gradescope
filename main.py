import json
from time import sleep
from selenium import webdriver
from selenium.webdriver import Keys, ActionChains
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options

from baml_py import Image
from baml_client.sync_client import b

question = '2.3.30'
solution = """
    solution "$2. 3. \textbf{30 a See Figure }2. 44.$ Figure 2.44: for Problem 2.4.30.  The vectors $\vec{x}$ and $T(\vec{x})$ have the same length (since reflections leave the length unchanged), and they enclose an angle of $2(\alpha+\beta)=2\cdot30^\circ=60^\circ$ b Based on the answer in part (a), we conclude that $T$ is a rotation through $60^\circ.$ c The matrix of $T$ is $\begin{bmatrix}\cos(60^\circ)&-\sin(60^\circ)\\\sin(60^\circ)&\cos(60^\circ)\end{bmatrix}=\begin{bmatrix}\frac{1}{2}&-\frac{\sqrt{3}}{2}\\\frac{\sqrt{3}}{2}&\frac{1}{2}\end{bmatrix}.$"
"""

def load_cookies(filename):
    with open(filename, 'r') as cookiesfile:
        cookies = json.load(cookiesfile)
    return cookies

base = 'https://www.gradescope.com'
target = 'https://www.gradescope.com/courses/818618/questions/39149037/submissions/2410136796/grade'
cookies = load_cookies('cookies.json')

options = Options()
options.add_experimental_option("detach", True)

driver = webdriver.Chrome(options=options)

driver.get(base)
for ck in cookies:
    driver.add_cookie(ck)

driver.get(target)
wait = WebDriverWait(driver, 10)
wait.until(EC.presence_of_element_located((By.CLASS_NAME, 'pv--viewport')))

def yay():
    ActionChains(driver).send_keys('1').perform()

def gg_gonext():
    ActionChains(driver).send_keys('z').perform()

# for some reason the first time you send input gradescope errors and makes you refresh
gg_gonext()
driver.refresh()
gg_gonext()

while True:
    image_url = driver.find_element(By.XPATH, "//div[@class='pv--viewport']/img").get_attribute("src")
    img = Image.from_url(image_url)
    res = b.GradeQuestion(img, question=question, solution=solution)
    if all(sp.correct for sp in res.answers):
        print('all right!')
        yay()
        sleep(0.1)
    gg_gonext()


