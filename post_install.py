#!/usr/bin/env python3

import os
import subprocess

hicolor = os.path.join(os.environ['MESON_INSTALL_PREFIX'], 'share', 'icons', 'hicolor')
schemas = os.path.join(os.environ['MESON_INSTALL_PREFIX'], 'share', 'glib-2.0', 'schemas')

if not os.environ.get('DESTDIR'):
    print('Updating icon cache...')
    if subprocess.call(['gtk-update-icon-cache', '-q', '-t' ,'-f', hicolor]) == 0:
        print('Done')
    else: 
        print('Error')
    
    print('Updating GLib Schemas...')
    if subprocess.call(['glib-compile-schemas', schemas]) == 0:
        print('Done')
    else: 
        print('Error')
