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
color_black = '#373f4c'
color_light_black = '#64626d'
color_red = '#aa3e64'
color_light_red = '#f9afd2'
color_green = '#39acaa'
color_light_green = '#96c7be'
color_yellow = '#9a8e70'
color_light_yellow = '#f2ecba'
color_blue = '#29529c'
color_light_blue = '#86b7df'
color_magenta = '#714161'
color_light_magenta = '#af9098'
color_cyan = '#83cbbf'
color_light_cyan = '#a7e8df'
color_white = '#c0c4c5'
color_light_white = '#ffffff'


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
        status = acpi.split()[2].strip()[:-1].lower()
        if battery[-1] == '%':
            battery = battery[:-1]
        battery = int(battery)
        bat_format = '[<span foreground="' + color_blue + '">Bat:</span>'
        bat_format += ' <span foreground="'
        bat_format += self._get_battery_color(battery, status)
        bat_format += "\">%3d%%" % battery
        if status == 'charging':
            bat_format += '+'
        elif status == 'discharging':
            bat_format += '-'
        elif status == 'full':
            bat_format += '='
        else:
            bat_format += '?'
        bat_format += '</span>]'
        return bat_format

    def _get_battery_color(self, battery, status):
        if status == 'full':
            return color_light_green
        elif battery > 50:
            if not status == 'discharging':
                return color_green
            return color_light_yellow
        elif battery < 50 and battery > 20:
            return color_yellow
        else:
            return color_red

    def _get_uptime(self):
        with open("/proc/uptime") as upfile:
            raw = upfile.read()
            fuptime = int(raw.split('.')[0])

            day = int(fuptime / 86400)
            fuptime = fuptime % 86400
            hour = int(fuptime / 3600)
            fuptime = fuptime % 3600
            minute = int(fuptime / 60)

        return "[<span foreground=\"" + color_blue + "\">Up:</span> " + \
                ("%02d" % day) + "d " + ("%02d" % hour) + "h " + \
                ("%02dm" % minute) + "]"

    def run(self):
        battery = self._get_battery()
        uptime = self._get_uptime()
        while (self._server.is_running()):
            self._counter += 1
            c = call(['xsetroot', '-name', self._get_status(battery, uptime)],
            #c = call(['echo', self._get_status(battery, uptime)],
                    shell=False)

            if c != 0:
                self._server.stop()
            if self._counter >= 30:
                battery = self._get_battery()
                uptime = self._get_uptime()
                self._counter = 0
            time.sleep(1)
            # end while


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
