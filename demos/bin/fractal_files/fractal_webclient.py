# Importing standard python libraries
from typing import Union, List
import traceback
import atexit

# Externally installed libraries
from selenium.webdriver.chrome.service import Service
from selenium.common.exceptions import WebDriverException
from selenium import webdriver


class WebClient:
    def __init__(self, default_image_url: str) -> None:
        # Enable changing the options for the chrome driver
        self.options = webdriver.ChromeOptions()

        # Disable "Chrome is being controlled by automated test software" message
        self.options.add_experimental_option("excludeSwitches", ["enable-automation"])

        # Disable “What’s new” tab for profiles instantiated by ChromeDriver
        self.options.add_argument("--disable-features=ChromeWhatsNewUI")

        # Change other important default settings
        if default_image_url:
            self.options.add_argument(f"--app={default_image_url}")
        self.options.add_argument('--start-maximized')
        self.options.headless = False

        # Create a list for potential exceptions
        self.exceptions: List[str] = []
        self.service: Union[Service, None] = None
        self.driver: Union[webdriver.Chrome, None] = None

        # When class shuts down, run this last function
        atexit.register(self.close)

    def get_linux_chromedriver(self) -> bool:
        """As per default, the script tries to open a locally based chromedriver from
        the linux environment, as this script is supposed to be run on the RasQberry"""
        try:
            self.service = Service('/usr/lib/chromium-browser/chromedriver')
            self.driver = webdriver.Chrome(service=self.service, options=self.options)
            return True
        except WebDriverException:
            self.exceptions.append(traceback.format_exc())
            return False

    def get_other_chromedriver(self) -> bool:
        """In case the Linux path chromedriver does not work, this method will attempt
        to open a chromedriver by running the ChromeDriverManager. No local driver needed"""
        try:
            from webdriver_manager.chrome import ChromeDriverManager
            self.service = Service(ChromeDriverManager().install())
            self.driver = webdriver.Chrome(service=self.service, options=self.options)
            return True
        except (WebDriverException, ModuleNotFoundError):
            self.exceptions.append(traceback.format_exc())
            return False

    def get_driver(self) -> webdriver.Chrome:
        """Method that either returns a working driver or terminates the program"""
        if self.get_linux_chromedriver() is True:
            return self.driver
        elif self.get_other_chromedriver() is True:
            return self.driver
        else:
            self.raise_multiple_driver_errors()

    def raise_multiple_driver_errors(self) -> None:
        """Method to recursively throw all errors that have occurred when trying
        to get either the linux or other platform (windows, macos) ChromeDriver.
        In case neither of the methods can provide a ChromeDriver, the WebClient
        class will terminate the entire program and throw the errors causing it"""
        if not self.exceptions:  # list emptied, recursion ends
            return
        try:
            error = self.exceptions.pop()  # pop removes list entries
            raise Exception(error)
        finally:
            self.raise_multiple_driver_errors()  # recursion

    # Final function to ensure the driver closes
    # ------------------------------------------------------------------------------------
    def close(self) -> None:
        try:
            self.driver.quit()
        except AttributeError:
            pass
