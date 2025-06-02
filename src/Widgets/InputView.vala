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

    public class DragAndDrop : Box {
        //Global variables   
        private Label description_label;

        public DragAndDrop () {
            /*
             * CONTAINER BOX
             */
            Box widget_box = new Box (Orientation.HORIZONTAL, 0);

            /*
             * SEPARATORS
             */
            Separator left_separator = new Separator (Gtk.Orientation.HORIZONTAL);
            left_separator.set_hexpand (true);
            Separator right_separator = new Separator (Gtk.Orientation.HORIZONTAL);
            right_separator.set_hexpand (true);
            left_separator.set_opacity (0.0);
            right_separator.set_opacity (0.0);

            /*
             * LABELS
             */
            description_label = new Label ("Drag & Drop File(s)");

            /*
             * ARM THE WIDGET
             */
            widget_box.append (left_separator);
            widget_box.append (description_label);
            widget_box.append (right_separator);

            this.set_size_request (272, 26);

            this.append (widget_box);
            this.homogeneous = true;
        }
    }

}
