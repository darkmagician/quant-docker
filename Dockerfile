FROM python:3.6

# install google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get -y update
RUN apt-get install -y google-chrome-stable

# install chromedriver
RUN apt-get install -yqq unzip
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

# install image libs
RUN apt-get -y install zlib1g-dev libjpeg-dev tesseract-ocr tesseract-ocr-eng

# clean
RUN apt-get clean

# set display port to avoid crash
ENV DISPLAY=:99

# pip install
RUN RUN TABULATE_INSTALL=lib-only;pip install -r requirements.txt


ENV PYTHONIOENCODING=UTF-8
ENV TZ=Asia/Shanghai
ENV TESSDATA_PREFIX=/usr/share/tesseract-ocr/tessdata
