/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2016 Juan Pablo Lozano <libredeb@gmail.com>
 */
using Gtk;
using GLib;
using Granite;

namespace Hashit.Widgets {

    public class Selection : Box {

        private Gtk.DropDown dropdown;
        private string[] options;

        public Selection () {
            /*
             * Add Checksum Types
             */
            options = {
                "MD5",
                "SHA1",
                "SHA256",
                "SHA512"
            };

            /*
             * INITIALIZE VARIABLES
             */
            dropdown = new Gtk.DropDown.from_strings (options);
            dropdown.selected = 0; // default index selected

            // Connect the signal to a function
            // dropdown.notify["selected"].connect (() => on_dropdown_changed (dropdown));

            // The ComboBox:
            this.append (dropdown);
            this.set_size_request (26, 26);
        }

        public string on_dropdown_changed (Gtk.DropDown dropdown) {
            var index = dropdown.selected;
            string? selected_item = options[index];
            return selected_item;
        }

        public string get_dropdown_value () {
            var index = dropdown.selected;
            return options[index];
        }

    }

}
