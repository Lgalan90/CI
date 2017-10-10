#!/bin/bash
sudo apt update
sudo apt-get update
sudo apt-get install openjdk-8-jre -y
sudo apt-get install unzip
sudo apt install xvfb -y
crontab -l | { cat; echo "@reboot sh -c 'Xvfb :90 -ac -screen 0 1024x768x8 > /tmp/xvfb.log 2>&1 &'"; } | crontab -
sudo apt-get install firefox -y
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update
sudo apt-get install google-chrome-stable -y
sudo wget https://github.com/mozilla/geckodriver/releases/download/v0.18.0/geckodriver-v0.18.0-linux64.tar.gz
tar -xvzf geckodriver-v0.18.0-linux64.tar.gz
sudo rm geckodriver-v0.18.0-linux64.tar.gz
sudo chmod +x geckodriver
sudo cp geckodriver /usr/local/bin/
mkdir /usr/lib/selenium
cd /usr/lib/selenium
sudo wget http://selenium-release.storage.googleapis.com/3.6/selenium-server-standalone-3.6.0.jar
sudo ln -s selenium-server-standalone-3.6.0.jar selenium-server-standalone.jar
sudo mkdir -p /var/log/selenium
sudo chmod a+w /var/log/selenium
sudo nano /etc/init.d/selenium 
sudo cat > /etc/init.d/selenium <<'endmsg'
#!/bin/bash

case "${1:-''}" in
    'start')
        if test -f /tmp/selenium.pid
        then
            echo "Selenium is already running."
        else
            export DISPLAY=localhost:99.0
            xvfb-run -a --server-args="-screen 0, 1366x768x24" java -jar /usr/lib/selenium/selenium-server-standalone.jar > /var/log/selenium/output.log 2> /var/log/selenium/error.log & echo $! > /tmp/selenium.pid
            echo "Starting Selenium..."

            error=$?
            if test $error -gt 0
            then
                echo "${bon}Error $error! Couldn't start Selenium!${boff}"
            fi
        fi
    ;;
    'stop')
        if test -f /tmp/selenium.pid
        then
            echo "Stopping Selenium..."
            PID=`cat /tmp/selenium.pid`
            kill -3 $PID
            if kill -9 $PID ;
                then
                    sleep 2
                    test -f /tmp/selenium.pid && rm -f /tmp/selenium.pid
                else
                    echo "Selenium could not be stopped..."
                fi
        else
            echo "Selenium is not running."
        fi
        ;;
    'restart')
        if test -f /tmp/selenium.pid
        then
            kill -HUP `cat /tmp/selenium.pid`
            test -f /tmp/selenium.pid && rm -f /tmp/selenium.pid
            sleep 1
            export DISPLAY=localhost:99.0
            xvfb-run -a --server-args="-screen 0, 1366x768x24" java -jar /usr/lib/selenium/selenium-server-standalone.jar > /var/log/selenium/output.log 2> /var/log/selenium/error.log & echo $! > /tmp/selenium.pid
                echo "Reload Selenium..."
        else
            echo "Selenium isn't running..."
        fi
        ;;
    *)      # no parameter specified
        echo "Usage: $SELF start|stop|restart"
        exit 1
    ;;
esac
endmsg
sudo chmod 755 /etc/init.d/selenium
sudo update-rc.d selenium defaults
sudo reboot