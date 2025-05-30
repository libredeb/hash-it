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

public static int main (string[] args)
{
    Gtk.init (ref args);//Initializes GTK+

	string css_file = "/usr/share/hashit/ui/gtk-widgets.css";//CSS file path
	var css_provider = new Gtk.CssProvider ();//Create a new CSS Provider

	try
	{
		css_provider.load_from_path (css_file);//Load the CSS file from the above path (string)
		Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default(), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_USER);//Establece un contexto de estilo y la prioridad
	  } catch (Error e) {//Capturing Error
	  	stderr.printf ("COM.HASHIT.CORE: [ERROR LOADING CSS STYLES [%s]]\n", e.message);
	  	stderr.printf (">>> Check path: /usr/share/hashit/ui/gtk-widgets.css\n");
	}

    var app = new Hashit.App ();
    
    return app.run (args);
}
