/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2016 Juan Pablo Lozano <libredeb@gmail.com>
 */
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
