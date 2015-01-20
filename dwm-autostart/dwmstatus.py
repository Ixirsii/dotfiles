#!/usr/bin/python3

import argparse
import os
import socket
import sys
import threading
import time
from datetime import datetime
from subprocess import call,check_output


address = ('127.0.0.1', 17926)
# Dark Colors
color_black = '#404040'
color_red = '#ffb191'
color_green = '#9edb8f'
color_yellow = '#da9667'
color_blue = '#98a7ba'
color_magenta = '#e2c2c5'
color_cyan = '#a7d1cf'
color_white = '#ababab'
# Light Colors
color_light_black = '#606060'
color_light_red = '#992f3a'
color_light_green = '#4f7b60'
color_light_yellow = '#993c15'
color_light_blue = '#383c57'
color_light_magenta = '#ad7381'
color_light_cyan = '#5f8282'
color_light_white = '#f6f6f6'


class StatusBar(threading.Thread):
    def __init__(self, server):
        threading.Thread.__init__(self)
        self._counter = 0
        self._server = server

    def _get_status(self, battery, uptime):
        return ' '.join([
            uptime,
            battery,
            "{:%a %b %e, %Y @ %H:%M:%S}".format(datetime.now()).strip(),
        ])

    def _get_battery(self):
        acpi = check_output("acpi", universal_newlines=True)
        battery = acpi.split()[3].strip()[:-1]
        status = acpi.split()[2].strip()[:-1]
        if battery[-1] == '%':
            battery = battery[:-1]
        battery = int(battery)
        bat_format = '[Bat: <span foreground="'
        bat_format += self._get_battery_color(battery)
        bat_format += '">' + self._get_battery_str(battery) + '%'
        if status.lower() == 'charging':
            bat_format += '+'
        elif status.lower() == 'discharging':
            bat_format += '-'
        else:
            bat_format += '='
        bat_format += '</span>]'
        return bat_format

    def _get_battery_color(self, battery):
        if battery > 50:
            return color_green
        elif battery < 50 and battery > 20:
            return color_yellow
        else:
            return color_red

    def _get_battery_str(self, battery):
        if battery == 100:
            return str(battery)
        elif battery > 90:
            return ' ' + str(battery)
        elif battery > 10:
            return ' ' + str(battery)
        else:
            return '  ' + str(battery)

    def _get_uptime(self):
        with open("/proc/uptime") as upfile:
            raw = upfile.read()
            fuptime = int(raw.split('.')[0])

            day = int(fuptime / 86400)
            fuptime = fuptime % 86400
            hour = int(fuptime / 3600)
            fuptime = fuptime % 3600
            minute = int(fuptime / 60)

            return "[Up: " + ("%02d" % day) + ":" + ("%02d" % hour) + ":" + \
                    ("%02d" % minute) + "]"

    def run(self):
        battery = self._get_battery()
        uptime = self._get_uptime()
        while (self._server.is_running()):
            self._counter += 1
            c = call(['xsetroot', '-name', self._get_status(battery, uptime)],
                    shell=False)
            if c != 0:
                self._server.stop()
            if self._counter >= 30:
                battery = self._get_battery()
                uptime = self._get_uptime()
                self._counter = 0
            # end while
            time.sleep(1)

class Server():
    def __init__(self):
        self._paused = False
        self._statusbar = StatusBar(self)
        self._running = True
        self._chdir()
        self._open_socket()

    def _chdir(self):
        os.setsid()
        os.umask(0)
        #sys.stdout.close()
        #sys.stderr.close()

    def _listen(self):
        self._s.listen(1)
        try:
            while self._running:
                self._c, self._addr = self._s.accept()
                self._process()
                self._c.close()
            self._s.close()
        except:
            e = sys.exc_info()
            sys.stderr.write(str(e[1]))
            sys.stderr.write(str(e[2]))

    def _open_socket(self):
        try:
            self._s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self._s.bind(address)
        except socket.error as msg:
            sys.stderr.write('[Error ' + str(msg.errno) + ']: ' + msg.strerror)
            sys.exit(1)

    def _process(self):
        cmd = self._c.recv(10)
        if cmd == b'stop':
            self.stop()
        elif cmd == b'pause':
            self.pause()
        elif cmd == b'resume':
            self.resume()

    def is_running(self):
        return self._running and not self._paused

    def pause(self):
        self._paused = True

    def resume(self):
        self._paused = False

    def run(self):
        self._statusbar.start()
        self._listen()

    def stop(self):
        self._running = False


def fork():
    try:
        pid = os.fork()
    except OSError:
        sys.stderr.write('Fork Failed\n')
        sys.exit(1)
    if pid == 0:
        start_server()
    sys.exit()


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('cmd', nargs='?',
            choices=['start', 'stop', 'pause', 'resume'])
    parser.add_argument('--version', action='version', version='%(prog)s 1.0')
    return parser.parse_args()


def start_server():
    server = Server()
    server.run()


def main():
    args = parse_args()
    is_server = False
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    e = s.connect_ex(address)
    if e != 0 and (args.cmd is None or args.cmd == 'start'):
        is_server = True
    elif e == 0 and args.cmd == 'start':
        sys.exit()
    elif e == 0 and args.cmd is None:
        args.cmd = 'stop'
    if is_server:
        fork()
    s.sendall(args.cmd.encode('utf-8'))
    s.close()


if __name__ == '__main__':
    main()

## ######################################################################## ##
##                                   EOF                                    ##
## ######################################################################## ##
