/* Copyright 2016 Juan Pablo Lozano
*
* This file is part of Hashit.
*
* Hashit is free software: you can redistribute it
* and/or modify it under the terms of the GNU General Public License as
* published by the Free Software Foundation, either version 3 of the
* License, or (at your option) any later version.
*
* Hashit is distributed in the hope that it will be
* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
* Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with Hashit. If not, see http://www.gnu.org/licenses/.
*/

//Importing libraries GTK+, GLib and Granite
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
