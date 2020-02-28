#!/usr/bin/env python

"""
   Copyright 2020 Paul Wallace

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

"""

import argparse
import os
from shutil import copytree, rmtree
import subprocess


plugins = ['com.docsascodeasdocs.dita.doctypes',
           'com.docsascodeasdocs.markdown.dacad-npm']


def uninstall_plugins(dita_dir, verbose):
    """Uninstall the DaCaD project plugins from a DITA-OT instance.
        'dita_dir' is the path to the DITA-OT instance.
        This function will remove the project plugins and then refresh
        the DITA-OT plugins list in 'build.xml'.
    """
    if verbose:
        print("Uninstalling DaCaD project plugins from %s..." % dita_dir)
    for plugin in plugins:
        dita_plugin_path = os.path.abspath(os.path.join(dita_dir,
                                                        'plugins', plugin))
        if os.path.isdir(dita_plugin_path):
            if verbose:
                print("Removing %s..." % plugin)
            rmtree(dita_plugin_path)
        else:
            if verbose:
                print("%s is not installed, nothing to do..." % plugin)
    dita_exe = os.path.join(dita_dir, 'bin', 'dita')
    subprocess.run([dita_exe, '--install']) # update the DITA-OT build.xml file
    if verbose:
        print("Done.")


def install_plugins(dita_dir, verbose):
    """Install the DaCaD project plugins in a DITA-OT instance.
        'dita_dir' is the path to the DITA-OT instance.
        This function copies the project plugins to DITA-OT and then
        runs the 'bin/dita --install' command to refresh the install_plugins
        list in 'build.xml'.
    """
    if verbose:
        print("Installing DaCaD project plugins in %s..." % dita_dir)
    for plugin in plugins:
        plugin_path = os.path.abspath(os.path.join(os.getcwd(), plugin))
        dita_plugin_path = os.path.abspath(os.path.join(dita_dir,
                                                        'plugins', plugin))
        if verbose:
            print("Copying %s to %s..." % (plugin, dita_dir))
        copytree(plugin_path, dita_plugin_path)
    if verbose:
        print("Running the install command...")
    dita_exe = os.path.join(dita_dir, 'bin', 'dita')
    subprocess.run([dita_exe, '--install'])
    if verbose:
        print("DaCaD project plugins have been installed.")


def run(dita_dir, verbose):
    uninstall_plugins(dita_dir, verbose)
    install_plugins(dita_dir, verbose)


if __name__ == '__main__':
    FUNC_MAP = {'install': run, 'uninstall': uninstall_plugins}
    parser = argparse.ArgumentParser(
                        formatter_class=argparse.RawDescriptionHelpFormatter,
                        description='''\
    Refresh the DaCaD project plugins in a DITA-OT instance.
    Default command is 'install'.
    To uninstall plugins only, use the 'uninstall' command:

        $ python copy2dita.py uninstall --dita_dir <path/to/DITA-OT>
                        ''')
    parser.add_argument('command', choices=FUNC_MAP.keys(),
                        default='install', nargs='?')
    parser.add_argument("-d", "--dita-dir", dest='dita_dir',
                        required=True,
                        help='relative path to your DITA-OT instance')
    parser.add_argument("-v", "--verbose", action='store_true',
                        dest='verbose', help='yakkity yak yak')

    args = parser.parse_args()
    dita_dir = args.dita_dir
    verbose = args.verbose
    func = FUNC_MAP[args.command]
    func(dita_dir=dita_dir, verbose=verbose)
