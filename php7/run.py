#!/usr/bin/env python

import sys
import os
import subprocess
import signal
from functools import partial

def main(argv):
    if os.environ['DEBUG'] == 'true':
        debug_mode();
    if os.path.exists('/app/start.sh'):
        os.system('sh /app/start.sh')
    os.system('php-fpm7 &')
    server = subprocess.Popen(['nginx'], shell=True)
    signal.signal(signal.SIGINT, partial(signal_handler, server))
    print('server running at localhost:8888')
    server.wait()

def signal_handler(process, signal_int, frame):
    process.send_signal(signal.SIGTERM)

def debug_mode():
    pass

main(sys.argv);
