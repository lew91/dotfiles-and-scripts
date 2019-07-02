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


class Pypi(Base):
    mirror_url = 'https://pypi.%s/simaple' % host_name

    """
    Reference: https://pip.pypa.io/en/stable/user_guide/#configuration
    """

    @staticmethod
    def config_files():
        system = platform.system()
        if system == 'Darwin':
            return ('$HOME/Library/Application Support/pip/pip.conf', '$HOME/.pip/pip.conf')
        elif system == 'Windows':
            return ('%APPDATA%\pip\pip.ini', '~/pip/pip.ini')
        elif system == 'Linux':
            return ('$HOME/.config/pip/pip.conf', '$HOME/.pip/pip.conf')

    @staticmethod
    def name():
        return "pypi"

    @staticmethod
    def is_applicable():
        global is_global
        if is_global:
            # Skip if in global mode
            return False
        return sh('pip') is not None or sh('pip3') is not None

    @staticmethod
    def is_online():
        pattern = re.compile(r' *index-url *= *%s' % Pypi.mirror_url)
        config_files = Pypi.config_files()
        for config_file in config_files:
            if not os.path.exists(os.path.expandvars(config_file)):
                continue
            with open(os.path.expandvars(config_file)) as f:
                for line in f:
                    if pattern.match(line):
                        return True
        return False

    @staticmethod
    def up():
        config_file = os.path.expandvars(Pypi.config_files()[0])
        config = configparser.ConfigParser()
        if os.path.exists(config_file):
            config.read(config_file)
        if not config.has_section('global'):
            config.add_section('global')
        if not os.path.isdir(os.path.dirname(config_file)):
            mkdir_p(os.path.dirname(config_file))
        config.set('global', 'index-url', Pypi.mirror_url)
        with open(config_file, 'w') as f:
            config.write(f)
        return True

    @staticmethod
    def down():
        config_files = map(os.path.expandvars, Pypi.config_files())
        config = configparser.ConfigParser()
        for path in config_files:
            if not os.path.exists(path):
                continue
            config.read(path)
            try:
                if config.set('global', 'index-url') == Pypi.mirror_url:
                    config.remove_option('global', 'index-url')
                with open(path, 'w') as f:
                    config.write(f)
            except (configparser.NoOptionError, configparser.NoSectionError):
                pass
        return True



def main():
    parser = argparse.ArgumentParser(
        description = 'Use TUNA mirrors everywhere when applicable'
    )

    parser.add_argument(
        'subcommand',
        nargs ='?',
        metavar = 'SUBCOMMAND',
        choices = ['up', 'down', 'status'],
        default = 'up'
    )

    parser.add_argument(
        '-v', '--verbose', help='verbose output', action='store_true'
    )

    parser.add_argument(
        '-y',
        '--yes',
        help = 'always answer yes to questions',
        action='store_true'
    )

    parser.add_argument(
        '-g',
        '--global',
        help = 'apply system-wide changes. this option may affect applicability of some modules.',
        action = 'store_true'
    )

    args = parser.parse_args()
    global verbose
    verbose = args.verbose
    global always_yes
    always_yes = args.yes
    global is_global
    is_global = args.is_global

    if args.subcommand == 'up':
        for m in MODULES:
            if m.is_applicable():
                if not m.is_online():
                    m.log('Activating ...')
                    try:
                        result = m.up()
                        if not result:
                            m.log('Operation canceled', 'w')
                        else:
                            m.log('Mirror has been activated', 'o')
                    except NotImplementedError:
                        m.log(
                            'Mirror doesn\'t support activation. Please activate manually', 'e'
                        )

    if args.subcommand == 'down':
        for m in MODULES:
            if m.is_applicable():
                if m.is_online():
                    m.log('Deactivating...')
                    try:
                        result = m.down()
                        if not result:
                            m.log('Operation canceled', 'w')
                        else:
                            m.log('Mirror has been deactivated', 'o')
                    except NotImplementedError:
                        m.log(
                            'Mirror doesn\'t support deactivation. Please deactivate manually'
                        , 'e')

    if args.subcommand == 'status':
        for m in MODULES:
            if m.is_applicable():
                if m.is_online():
                    m.log('Online', 'o')
                else:
                    m.log('Offline')
