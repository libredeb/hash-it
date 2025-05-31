# Project name and programming language
project(
    'com.github.libredeb.hashit',
    'vala', 'c',
    version: '0.1.2',
    meson_version: '>=0.56.0'
)

# Include the translations module
i18n = import('i18n')
# Set our translation domain
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')

PROJECT_NAME = 'hashit'
prefix = get_option('prefix')
libdir = join_paths(prefix, get_option('libdir'))
datadir = join_paths(prefix, get_option('datadir'))

VAPI_DIR = join_paths(meson.project_source_root(), 'vapi')
vala = meson.get_compiler('vala')

# Global configuration data - matches vapi/config.vapi strings
conf = configuration_data()
conf.set_quoted('PROJECT_NAME', PROJECT_NAME)
conf.set_quoted('PACKAGE_LIBDIR', libdir)
conf.set_quoted('PACKAGE_SHAREDIR', datadir)
conf.set_quoted('PACKAGE_VERSION', meson.project_version())

config_h = configure_file(
	output: 'config.h',
	configuration: conf
)

config_dep = declare_dependency(
	dependencies: vala.find_library('config', dirs: VAPI_DIR),
	sources: config_h
)

config_inc_dir = include_directories('.')

ValaArgs = [
    '--pkg=config',
    '--vapidir=' + VAPI_DIR,
    '--target-glib=2.50',
]

# Create a new executable, list the files we want to compile, list the dependencies we need, and install
executable(
    meson.project_name(),
    'src/Widgets/HeaderBar.vala',
    'src/Widgets/InputView.vala',
    'src/Widgets/Selection.vala',
    'src/Constants.vala',
    'src/Application.vala',
    'src/Settings.vala',
    'src/Main.vala',
    dependencies: [
        dependency('glib-2.0'),
        dependency('gtk+-3.0'),
        dependency('gio-2.0'),
        dependency('granite'),
        # Similar to add options "-X -lm" in cmake to use Math.pow()
        meson.get_compiler('c').find_library('m', required: false)
    ],
    c_args: [
        '-w'
    ],
    vala_args: ValaArgs,
    include_directories: config_inc_dir,
    install: true
)

# Install CSS file
install_data(
    join_paths('data', 'gtk-widgets.css'),
    install_dir: join_paths(datadir, PROJECT_NAME, 'ui')
)

# Install app icons
icon_sizes = ['16', '24', '32', '48', '64', '128']
foreach i : icon_sizes
    install_data(
        join_paths('data', 'icons', i, 'hashit.svg'),
        install_dir: join_paths(datadir, 'icons', 'hicolor', i + 'x' + i, 'apps')
    )
    install_data(
        join_paths('data', 'icons', i, 'hashit.svg'),
        install_dir: join_paths(datadir, 'icons', 'hicolor', i + 'x' + i + '@2', 'apps')
    )
endforeach

# Install our .desktop file so the Applications Menu will see it
i18n.merge_file(
    input: 'data' / 'com.github.libredeb.hashit.desktop.in',
    output: meson.project_name() + '.desktop',
    po_dir: meson.project_source_root() / 'po',
    type: 'desktop',
    install: true,
    install_dir: get_option('datadir') / 'applications'
)

# Install our .appdata.xml file so AppCenter will see it
i18n.merge_file(
    input: 'data' / 'com.github.libredeb.hashit.appdata.xml.in',
    output: meson.project_name() + '.metainfo.xml',
    po_dir: meson.project_source_root() / 'po',
    install: true,
    install_dir: get_option('datadir') / 'metainfo'
)

# Install gfx icon files
install_data(
    join_paths('data', 'gfx', 'result-error.svg'),
    install_dir: join_paths(datadir, 'hashit', 'gfx')
)
install_data(
    join_paths('data', 'gfx', 'result-ok.svg'),
    install_dir: join_paths(datadir, 'hashit', 'gfx')
)
install_data(
    join_paths('data', 'gfx', 'result-status.svg'),
    install_dir: join_paths(datadir, 'hashit', 'gfx')
)

meson.add_install_script('post_install.py')

subdir('po')