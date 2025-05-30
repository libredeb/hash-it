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

	public class Header : HeaderBar {

		public Hashit.App app;

		public ToolButton open_button;
		public ToolButton save_button;
		public ToolButton clear_button;

        private Image open_button_image;
		private Image save_button_image;
		private Image clear_button_image;

		public Header (Hashit.App app) {
			// Set up defaults
			this.app = app;
			this.show_close_button = true;
			this.title = Constants.PROGRAM_NAME;
			get_style_context ().add_class ("primary-toolbar");

			/*** Set up UI ***/
			var menu 	= new Gtk.Menu ();
			//var appmenu = this.app.create_appmenu (menu);

			/*
             * OPEN BUTTON
             */
            open_button_image = new Image ();
            open_button_image.set_from_icon_name ("folder-open", Gtk.IconSize.LARGE_TOOLBAR);
			open_button = new ToolButton (open_button_image, "Open Button");
			open_button.set_tooltip_text ("Select File(s)");

			/*
             * SAVE BUTTON
             */
			save_button_image = new Image ();
            save_button_image.set_from_icon_name ("document-save-as", Gtk.IconSize.LARGE_TOOLBAR);
			save_button = new ToolButton (save_button_image, "Save Button");
			save_button.set_tooltip_text ("Save results to a file");

			/*
             * CLEAR BUTTON
             */
			clear_button_image = new Image ();
            clear_button_image.set_from_icon_name ("edit-clear", Gtk.IconSize.LARGE_TOOLBAR);
			clear_button = new ToolButton (clear_button_image, "Clear Button");
			clear_button.set_tooltip_text ("Clear");

			this.pack_start (open_button);
			this.pack_start (save_button);
			//this.pack_end (appmenu);
			this.pack_end (clear_button);

			this.show_all ();
		}
	}
}
