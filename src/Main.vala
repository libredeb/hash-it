/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2016 Juan Pablo Lozano <libredeb@gmail.com>
 */

//Importing libraries
using Gtk;
using GLib;
using Granite;

public static int main (string[] args)
{
    Gtk.init ();
    var app = Hashit.App.get_instance ();
    
	string css_file = "/usr/share/hashit/ui/gtk-widgets.css";
	var css_provider = new Gtk.CssProvider ();

	css_provider.load_from_path (css_file);

	Gtk.StyleContext.add_provider_for_display (
        Gdk.Display.get_default (),
        css_provider,
        Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
    );
    
    app.run (args);
    return 0;
}
