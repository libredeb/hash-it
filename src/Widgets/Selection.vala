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
        //Global variables
        private Gtk.ListStore list_types;
		private Gtk.TreeIter item;
        private Gtk.ComboBox list_box;

        public Selection () {
            /*
             * INITIALIZE VARIABLES
             */
            list_types = new Gtk.ListStore (1, typeof (string));

            /*
             * Add Checksum Types
             */
            list_types.append (out item);
		    list_types.set (item, 0, "MD5");
		    list_types.append (out item);
		    list_types.set (item, 0, "SHA1");
            list_types.append (out item);
		    list_types.set (item, 0, "SHA256");
		    list_types.append (out item);
		    list_types.set (item, 0, "SHA512");
        
            // The ComboBox:
		    list_box = new Gtk.ComboBox.with_model (list_types);
		    this.pack_start (list_box, true, true, 0);
            this.set_size_request (26, 26);

		    Gtk.CellRendererText renderer = new Gtk.CellRendererText ();
		    list_box.pack_start (renderer, true);
		    list_box.add_attribute (renderer, "text", 0);
		    list_box.active = 0;
        }

        public string get_active_item () {
            Value type;

            list_box.get_active_iter (out item);
			list_types.get_value (item, 0, out type);

            return (string) type;
        }

    }

}
