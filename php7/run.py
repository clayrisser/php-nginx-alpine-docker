#!/usr/bin/env python

import sys
import os
import subprocess
import signal
from functools import partial

def main(argv):
    os.system('php-fpm7 &')
    server = subprocess.Popen(['nginx'], shell=True)
    signal.signal(signal.SIGINT, partial(signal_handler, server))
    print('server running at localhost:8888')
    server.wait()

def signal_handler(process, signal_int, frame):
    process.send_signal(signal.SIGTERM)

main(sys.argv);
