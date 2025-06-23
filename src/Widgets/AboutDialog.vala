/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2016 Juan Pablo Lozano <libredeb@gmail.com>
 */

using Gtk;

namespace Hashit.Widgets {

    public static Gtk.AboutDialog show_about_dialog (Gtk.Window parent) {
        var about = new Gtk.AboutDialog ();
        about.set_transient_for (parent);
        about.set_modal (true);
        about.set_program_name (Constants.PROGRAM_NAME);
        about.set_version (Config.PACKAGE_VERSION);
        about.set_copyright (Constants.APP_YEARS);
        about.set_logo_icon_name (Constants.EXEC_NAME);
        about.set_license ("GPL v3");
        about.set_license_type (Gtk.License.GPL_3_0);
        about.set_comments ("The most intuitive and simple hash tool checker");
        about.set_authors (
            {
                "Juan Pablo Lozano <libredeb@gmail.com>"
            }
        );
        about.set_artists (
            {
                "Ivan Matias Suarez <ivan.msuar@gmail.com>"
            }
        );
        about.set_website ("https://github.com/libredeb/hash-it");
        return about;
    }
}
