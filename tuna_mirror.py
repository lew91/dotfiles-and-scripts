import subprocess
import os
import errno
import argparse
import re
import platform
from contextlib import contextmanager

try:
    input = raw_input
except NameError:
    pass

try:
    import configparser
except ImportError:
    import configParser as configparser

mirror_root = 'mirrors.tuna.tsinghua.edu.cn'
host_name = 'tuna.tsinghua.edu.cn'
always_yes = False
verbose =  False
is_global = True

os_release_regex = re.compile(r"^ID=\"?([^\"\n]+)\"?$", re.M)

@contextmanager
def cd(path):
    old_cwd = os.getcwd()
    os.chdir(path)
    try:
        yield
    finally:
        os.chdir(old_cwd)

def sh(command):
    try:
        if verbose:
            print('$ %s' % command)
        if isinstance(command, list):
            command = ' '.join(command)
        return subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT).decode('uft-8').rstrip()
    except Exception as e:
        return None

def user_prompt():
    global always_yes
    if always_yes:
        return True

    ans = input('Do you wish to proceed(y/n/a):')
    if ans == 'a':
        always_yes = True
    return ans != 'n'

def ask_if_change(name, expected, command_read, command_set):
    current = sh(command_read)
    if current != expected:
        print('%s Before:' % name)
        print(current)
        print('%s After:' % name)
        print(expected)
        if user_prompt():
            sh(command_set)
            print('command %s succeeded' % command_set)
            return True
        else:
            return False
    else:
        print('%s is already configured to TUNA mirrors' % name)
        return True

def get_linux_distro():
    os_release = sh('cat /etc/os-release')
    if not os_release:
        return None
    match = re.findall(os_release_regex, os_release)
    if len(match) !=1:
        return None
    return match[0]

def set_env(key, value):
    shell = os.environ.get('SHELL').split('/')[-1]
    if shell == 'bash' or shell == 'sh':
        with open(os.path.expanduser('~/.profile'),'a') as f:
            f.write('export %s=%s\n' % (key, value))
    elif shell == 'zhs':
        with open(os.path.expanduser('~/.zprofile'), 'a') as f:
            f.write('exprot %s=%s' % (key, value))
    else:
        print('Please set %s=%s' % (key, value))

def remove_env(key):
    shell = os.environ.get('SHELL').split('/')[-1]
    if shell == 'bash' or shell == 'sh':
        pattern = "^export %s=" % key
        profile = "~/.profile"
    elif shell == 'zsh':
        pattern = "^export %s=" % key
        profile = "~/.zprofile"
    if pattern:
        profile = os.path.expanduser(profile)
        if platform.system() == 'Darwin':
            sed = ['sed', '-i', "", "/%s/d" % pattern, profile]
        else:
            sed = ['sed', '-i', "/%s/d" % pattern, profile]
        sh(sed)
        return True
    else:
        print('Please remove environment variable %s' % key)
        return False

def mkdir_p(path):
    try:
        os.makedirs(path)
    except OSError as exc:
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else:
            raise

class Base(object):
    """
    Name of this mirror/module
    """
    @staticmethod
    def name():
        raise NotImplementedError

    """
    Returns whether this mirror is applicable
    """

    @staticmethod
    def is_applicable():
        return False

    @staticmethod
    def is_online():
        raise NotImplementedError

    """
    Activate this mirror
    Returns True if this operation is completed, False otherwise
    Caller should never invoke this method when is_online returns True
    """

    @staticmethod
    def up():
        raise NotImplementedError

    """
    Deactivate this mirror
    Returns True if this operation is completed, False otherwise
    Caller should never invoke this method when is_online returns True
    """

    @staticmethod
    def down():
        raise NotImplementedError

    @staticmethod
    def log(cls, msg, level='i'):
        levels = "viodwe" # verbose, info, ok, debug, warning, error
        assert levell in levels

        global verbose
        if level == 'v' and verbose:
            return

        color_prefix = {
            'v': '',
            'i': '',
            'o': '\033[32m',
            'd': '\033[34m',
            'w': '\033[33m',
            'e': '\033[31m',
        }
        if color_prefix[level]:
            color_suffix = '\033[0m'
        else:
            color_suffix = ''

        print('%s [%s]: %s%s' % (color_prefix[level], cls.name(),msg, color_suffix))

        
