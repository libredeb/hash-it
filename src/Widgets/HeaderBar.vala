/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2016 Juan Pablo Lozano <libredeb@gmail.com>
 */

 using Gtk;

namespace Hashit.Widgets {

    public static Gtk.HeaderBar build_header_bar (Gtk.Window parent, Gtk.Application app) {

        var header_bar = new Gtk.HeaderBar ();
        header_bar.add_css_class ("header_bar");
        header_bar.set_show_title_buttons (true);
        var title = new Gtk.Label (Constants.PROGRAM_NAME);
        header_bar.set_title_widget (title);

        var menu_button = new Gtk.MenuButton () {
            icon_name = "open-menu",
            primary = true,
            tooltip_markup = Granite.markup_accel_tooltip ({"F10"}, "Menu")
        };
        var menu = new Menu ();
        menu.append ("About", "app.about");
        var popover = new Gtk.PopoverMenu.from_model (menu);
        menu_button.set_popover (popover);

        var about_action = new SimpleAction ("about", null);
        about_action.activate.connect (() => {
            var about = Hashit.Widgets.show_about_dialog (parent);
            about.present ();
        });

        // Add action to app
        app.add_action (about_action);

        var open_button = new Button.from_icon_name ("folder-open");
        open_button.set_tooltip_text ("Open File");
        var save_button = new Button.from_icon_name ("document-save-as");
        save_button.set_tooltip_text ("Save results to a file");
        var clear_button = new Button.from_icon_name ("edit-clear");
        clear_button.set_tooltip_text ("Clear");
        header_bar.pack_start (open_button);
        header_bar.pack_start (save_button);
        header_bar.pack_end (menu_button);
        header_bar.pack_end (clear_button);

        // Buttons functions
        open_button.clicked.connect (() => {
            Hashit.Widgets.FileDialog.select_file.begin (parent, (path) => {
                if (path != null) {
                    ((Hashit.App) app).get_file_hash (path);
                } else {
                    stdout.printf ("No file was selected.\n");
                }
            });
        });

        clear_button.clicked.connect (() => {
            ((Hashit.App) app).on_clear_button ();
        });

        return header_bar;
    }
}
