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

namespace Hashit {

	public class App : Granite.Application {

		//Global variables to the workspace
		public Window main_window;//Main window
		public Hashit.GSchema.Settings settings;
        private const Gtk.TargetEntry[] targets = {
            {"text/uri-list",0,0}
        };
        private Array<string> files_uris;
        private TextView text_view;
        private string list_of_hash;

		construct
		{
        	build_data_dir     = Constants.DATADIR;
            build_pkg_data_dir = Constants.PKGDATADIR;
            build_release_name = Constants.RELEASE_NAME;
            build_version      = Constants.VERSION;
            build_version_info = Constants.VERSION_INFO;

        	program_name       = Constants.PROGRAM_NAME;//The name of your program
        	exec_name          = Constants.EXEC_NAME;//The name of the executable, usually the name in lower case

            app_copyright      = Constants.APP_YEARS;
        	app_years          = Constants.APP_YEARS;
        	app_icon           = Constants.EXEC_NAME;//The icon name for the app. Normally ship it with the project in the data directory and copy it to the icon directory. Don't include file endings here.
        	app_launcher       = Constants.APP_LAUNCHER;//The .desktop file for your app, also in data directory
        	application_id     = "org.hashit";//An unique id which will identify your application
        
        	//Those urls will be shown in the automatically generated about dialog
        	main_url           = "https://launchpad.net/hash-it";
        	bug_url            = "https://bugs.launchpad.net/hash-it";
        	help_url           = "https://answers.launchpad.net/hash-it";
        	translate_url      = "https://translations.launchpad.net/hash-it";
        
        	//Here proudly list your own name and the names of those who helped
        	about_authors      = {
                                    "Juan Pablo Lozano <libredeb@gmail.com>"
                                 };
        	about_documenters  = {
                                    "Juan Pablo Lozano <libredeb@gmail.com>"
                                 };
        	about_artists      = {
                                    "Juan Pablo Lozano <libredeb@gmail.com>", 
                                    "Ivan Matias Suarez <ivan.msuar@gmail.com>"
                                 };//If anyone got an icon or a nice mockup, you can list him here
        	about_comments     = "The most intuitive and simple hash tool checker";//A short comment on the app
        	about_translators  = "Juan Pablo Lozano <libredeb@gmail.com>";
            about_license      = "";
            //This should be one of http://unstable.valadoc.org/#!api=gtk+-3.0/Gtk.License; For elementary GPL3 is the default one, it’s a good idea to use it
        	about_license_type = License.GPL_3_0;
    	}

    	public void build_and_run () {
    		// Instantiate settings and Initialize variables
    		settings = Hashit.GSchema.Settings.get_default ();
            files_uris = new Array<string> ();

    		/*
             * Set up Window 
             */
    		this.main_window = new Window ();
    		this.main_window.move (settings.opening_x, settings.opening_y);
        	this.main_window.set_size_request (750, 570);
        	this.main_window.set_border_width (12);
        	this.main_window.set_title (Constants.PROGRAM_NAME);
        	this.main_window.set_icon_name (Constants.EXEC_NAME);
        	this.main_window.set_resizable (false);
        	this.main_window.set_application (this);
        	this.main_window.get_style_context ().add_class ("main_window");


        	/*
             * Set up UI 
             */
        	// HeaderBar
        	var header_bar = new Hashit.Widgets.Header (this);
        	header_bar.get_style_context ().add_class ("header_bar");
        	this.main_window.set_titlebar (header_bar);

            //Boxes
            Box main_box                = new Box (Orientation.HORIZONTAL, 0);
            Box content_box             = new Box (Orientation.VERTICAL, 0);
            Box drag_box                = new Box (Orientation.HORIZONTAL, 0);
            Box combobox_box            = new Box (Orientation.HORIZONTAL, 0);
            Box headboard_box           = new Box (Orientation.HORIZONTAL, 0);
            Box input_fieldset_box      = new Box (Orientation.HORIZONTAL, 0);
            Box hashtype_fieldset_box   = new Box (Orientation.HORIZONTAL, 0);
            Box lasthash_fieldset_box   = new Box (Orientation.HORIZONTAL, 0);
            Box input_box               = new Box (Orientation.VERTICAL, 0);
            Box input_content_box       = new Box (Orientation.HORIZONTAL, 0);
            Box hashtype_box            = new Box (Orientation.VERTICAL, 0);
            Box lasthash_box            = new Box (Orientation.VERTICAL, 0);
            Box lasthash_content_box    = new Box (Orientation.HORIZONTAL, 0);
            Box selection_container_box = new Box (Orientation.VERTICAL, 0);
            Box results_stack_box       = new Box (Orientation.VERTICAL, 0);
            Box compare_stack_box       = new Box (Orientation.VERTICAL, 0);
            Box stack_box               = new Box (Orientation.VERTICAL, 0);
            Box stack_switcher_box      = new Box (Orientation.HORIZONTAL, 0);
            Box results_buttons_box     = new Box (Orientation.HORIZONTAL, 0);
            Box textview_content_box    = new Box (Orientation.VERTICAL, 0);
            Box textview_box            = new Box (Orientation.HORIZONTAL, 0);
            Box compare_label_box       = new Box (Orientation.HORIZONTAL, 0);
            Box compare_button_box      = new Box (Orientation.HORIZONTAL, 0);
            Box compare_box             = new Box (Orientation.VERTICAL, 0);
            Box compare_result_box      = new Box (Orientation.HORIZONTAL, 0);
            Box result_img_box          = new Box (Orientation.HORIZONTAL, 0);
            Box compare_state_box       = new Box (Orientation.HORIZONTAL, 4);
            Box state_box               = new Box (Orientation.VERTICAL, 0);
            Box state_content_box       = new Box (Orientation.HORIZONTAL, 0);

            //Labels
            Label input_fieldset_label    = new Label ("");
            input_fieldset_label.set_markup ("<b>" + "Input File" + "</b>");
            Label hashtype_fieldset_label = new Label ("");
            hashtype_fieldset_label.set_markup ("<b>" + "Hash Type" + "</b>");
            Label lasthash_fieldset_label = new Label ("");
            lasthash_fieldset_label.set_markup ("<b>" + "Last Hash" + "</b>");
            Label compare_result_label    = new Label ("");
            compare_result_label.set_markup ("<b>" + "Original Hash:" + "</b>");
            Label compare_state_label     = new Label ("");
            compare_state_label.set_markup ("<span font_size='large'><b>" + "Compare State" + "</b></span>");

            //Text View
            this.text_view = new TextView ();
            this.text_view.editable = false;
            this.text_view.cursor_visible = false;
            this.text_view.get_style_context ().add_class("text_view");
            
            var scrolled_result = new ScrolledWindow (null, null);
            scrolled_result.set_policy (PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
            scrolled_result.add (this.text_view);

            //Buttons
            var copy_button           = new Button.with_label ("Copy");
            var copy_clipboard_button = new Button.with_label ("Copy to Clipboard");
            var compare_button        = new Button.with_label ("Compare");

            //Status Icons
            Image result_status_img = new Image ();
			try
			{
				var result_status_pixbuf = new Gdk.Pixbuf.from_file_at_scale ("/usr/share/hashit/gfx/result-status.svg", 24, 24, false);
				result_status_img.set_from_pixbuf (result_status_pixbuf);
			  } catch (GLib.Error e) {
				stderr.printf ("COM.HASHIT.APP.CORE: [GLIB::ERROR CREATING PIXBUF ICON]\n");
				stderr.printf (">>> Check file: /usr/share/hashit/gfx/result-status.svg\n");
			}
            Image result_ok_img = new Image ();
			try
			{
				var result_ok_pixbuf = new Gdk.Pixbuf.from_file_at_scale ("/usr/share/hashit/gfx/result-ok.svg", 24, 24, false);
				result_ok_img.set_from_pixbuf (result_ok_pixbuf);
			  } catch (GLib.Error e) {
				stderr.printf ("COM.HASHIT.APP.CORE: [GLIB::ERROR CREATING PIXBUF ICON]\n");
				stderr.printf (">>> Check file: /usr/share/hashit/gfx/result-ok.svg\n");
			}
            Image result_error_img = new Image ();
			try
			{
				var result_error_pixbuf = new Gdk.Pixbuf.from_file_at_scale ("/usr/share/hashit/gfx/result-error.svg", 24, 24, false);
				result_error_img.set_from_pixbuf (result_error_pixbuf);
			  } catch (GLib.Error e) {
				stderr.printf ("COM.HASHIT.APP.CORE: [GLIB::ERROR CREATING PIXBUF ICON]\n");
				stderr.printf (">>> Check file: /usr/share/hashit/gfx/result-error.svg\n");
			}

            //Entrys
            var last_hash_entry = new Entry ();
            var oem_hash_entry = new Entry ();

            //Separators
            Separator selection_top_separator     = new Separator (Gtk.Orientation.HORIZONTAL);
            Separator selection_bottom_separator  = new Separator (Gtk.Orientation.HORIZONTAL);
            Separator stack_left_separator        = new Separator (Gtk.Orientation.HORIZONTAL);
            Separator stack_right_separator       = new Separator (Gtk.Orientation.HORIZONTAL);
            Separator input_fieldset_separator    = new Separator (Gtk.Orientation.HORIZONTAL);
            Separator input_fill_separator    = new Separator (Gtk.Orientation.HORIZONTAL);
            Separator hashtype_fieldset_separator = new Separator (Gtk.Orientation.HORIZONTAL);
            Separator lasthash_fieldset_separator = new Separator (Gtk.Orientation.HORIZONTAL);
            //TextView Separators
            Separator text_top_separator          = new Separator (Gtk.Orientation.HORIZONTAL);
            Separator text_bottom_separator       = new Separator (Gtk.Orientation.HORIZONTAL);
            Separator text_left_separator         = new Separator (Gtk.Orientation.VERTICAL);
            Separator text_right_separator        = new Separator (Gtk.Orientation.VERTICAL);
            //Compare Button Separators
            Separator compare_left_separator      = new Separator (Gtk.Orientation.HORIZONTAL);
            Separator state_top_separator         = new Separator (Gtk.Orientation.VERTICAL);
            Separator state_bottom_separator      = new Separator (Gtk.Orientation.VERTICAL);
            Separator state_left_separator        = new Separator (Gtk.Orientation.HORIZONTAL);
            Separator state_right_separator       = new Separator (Gtk.Orientation.HORIZONTAL);
            //Separators Properties
            selection_top_separator.set_opacity (0.0);
            selection_bottom_separator.set_opacity (0.0);
            input_fill_separator.set_opacity (0.0);
            compare_left_separator.set_opacity (0.0);
            state_top_separator.set_opacity (0.0);
            state_bottom_separator.set_opacity (0.0);
            state_left_separator.set_opacity (0.0);
            state_right_separator.set_opacity (0.0);

            //Drag And Drop area
            var drag_area = new Hashit.Widgets.DragAndDrop ();

            //Selection Types Box
            var selection_box = new Hashit.Widgets.Selection ();

            /*
             * Stack
             */
            var stack = new Stack ();
            stack.set_transition_type (Gtk.StackTransitionType.SLIDE_LEFT_RIGHT);
    		stack.set_transition_duration (500);
    		stack.expand = true;
            stack.add_titled (results_stack_box, "results_stack_box", "Results");
    		stack.add_titled (compare_stack_box, "compare_stack_box", "Compare");

            var stack_switcher = new StackSwitcher ();
            stack_switcher.set_stack (stack);

            
            //Temporary Function, then, delete theese block
            copy_clipboard_button.clicked.connect (() => {
                for (int i = 0; i < files_uris.length; i++) {
		            stdout.printf ("%s\n", files_uris.index (i));
	            }

                stdout.printf ("Type: %s\n", selection_box.get_active_item ());
            });

            compare_button.clicked.connect (() => {
                if (last_hash_entry.get_text ().to_string() == oem_hash_entry.get_text ().to_string())
                {
                    result_img_box.remove (result_status_img);
                    result_img_box.add (result_ok_img);
                    result_ok_img.show ();
                    compare_state_label.set_markup ("<span font_size='large' bgcolor='#80FF80'><b>     " + selection_box.get_active_item () + " Checksums match! File Integrity is OK" + "     </b></span>");
                } else {
                    result_img_box.remove (result_status_img);
                    result_img_box.add (result_error_img);
                    result_error_img.show ();
                    compare_state_label.set_markup ("<span font_size='large' bgcolor='#FF8080'><b>     " + selection_box.get_active_item () + " Checksums do not match! File Integrity ERROR" + "     </b></span>");
                }
            });

            /*
             * ARM BOXES
             */
            //Fieldset Boxes
            input_fieldset_box.pack_start (input_fieldset_label, false, true, 0);
            input_fieldset_box.pack_start (input_fieldset_separator, true, true, 4);
            hashtype_fieldset_box.pack_start (hashtype_fieldset_label, false, true, 0);
            hashtype_fieldset_box.pack_start (hashtype_fieldset_separator, true, true, 4);
            lasthash_fieldset_box.pack_start (lasthash_fieldset_label, false, true, 5);
            lasthash_fieldset_box.pack_start (lasthash_fieldset_separator, true, true, 0);

            //First arm the Selection_Box correctly
            combobox_box.pack_start (selection_box, false, false, 0);
            selection_container_box.pack_start (selection_top_separator, true, true, 0);
            selection_container_box.pack_start (combobox_box, false, false, 0);
            selection_container_box.pack_start (selection_bottom_separator, true, true, 0);

            //TextView Boxes
            textview_content_box.pack_start (text_top_separator, false, true, 0);
            textview_content_box.pack_start (scrolled_result, true, true, 0);
            textview_content_box.pack_start (text_bottom_separator, false, true, 0);
            textview_box.pack_start (text_left_separator, false, true, 0);
            textview_box.pack_start (textview_content_box, true, true, 0);
            textview_box.pack_start (text_right_separator, false, true, 0);

            //Compare Boxes
            compare_label_box.pack_start (compare_result_label, false, false, 6);
            compare_button_box.pack_start (compare_left_separator, true, true, 0);
            compare_button_box.pack_start (compare_button, false, false, 6);
            result_img_box.add (result_status_img);
            compare_result_box.pack_start (oem_hash_entry, true, true, 6);
            compare_result_box.pack_start (result_img_box, false, false, 21);
            compare_state_box.pack_start (compare_state_label, false, true, 25);
            state_content_box.pack_start (state_left_separator, true, false, 0);
            state_content_box.pack_start (compare_state_box, false, false, 0);
            state_content_box.pack_start (state_right_separator, true, false, 0);
            state_box.pack_start (state_top_separator, true, true, 0);
            state_box.pack_start (state_content_box, false, true, 0);
            state_box.pack_start (state_bottom_separator, true, true, 0);
            compare_box.pack_start (compare_label_box, false, false, 0);
            compare_box.pack_start (compare_result_box, false, true, 12);
            compare_box.pack_start (state_box, true, true, 0);
            compare_box.pack_start (compare_button_box, false, false, 6);

            //Then, the Stack Boxes
            results_buttons_box.pack_end (copy_clipboard_button, false, false, 0);
            results_stack_box.pack_start (textview_box, true, true, 12);
            results_stack_box.pack_start (results_buttons_box, false, true, 0);
            compare_stack_box.pack_start (compare_box, true, true, 12);
            stack_switcher_box.pack_start (stack_left_separator, true, true, 0);
            stack_switcher_box.pack_start (stack_switcher, false, false, 0);
            stack_switcher_box.pack_start (stack_right_separator, true, true, 0);
            stack_box.pack_start (stack_switcher_box, false, true, 0);
            stack_box.pack_start (stack, false, true, 0);

            //Then the other boxes
            drag_box.pack_start (drag_area, true, true, 12);
            lasthash_content_box.pack_start (last_hash_entry, true, true, 6);
            lasthash_content_box.pack_start (copy_button, false, false, 6);
            input_box.pack_start (input_fieldset_box, false, true, 0);
            input_box.pack_start (input_fill_separator, false, true, 6);
            input_box.pack_start (drag_box, false, true, 0);
            input_content_box.pack_start (input_box, true, true, 0);
            hashtype_box.pack_start (hashtype_fieldset_box, false, false, 0);
            hashtype_box.pack_start (selection_container_box, false, false, 11);
            lasthash_box.pack_start (lasthash_fieldset_box, false, false, 0);
            lasthash_box.pack_start (lasthash_content_box, false, false, 6);
            headboard_box.pack_start (input_content_box, true, true, 6);
            headboard_box.pack_start (hashtype_box, false, true, 6);
            content_box.pack_start (headboard_box, false, true, 0);//Content Box is VERTICAL
            content_box.pack_start (lasthash_box, false, true, 4);
            content_box.pack_start (stack_box, true, true, 0);
            main_box.pack_start (content_box, true, true, 0);//Main Box is HORIZONTAL

            /*
             * ASSIGN THE DRAG ACTION TO WIDGET
             */
            Gtk.drag_dest_set (drag_box, Gtk.DestDefaults.ALL, targets, Gdk.DragAction.COPY);
            drag_box.drag_data_received.connect(this.on_drag_data_received);

    		/*
             * Function to save settings in GSchema
             */
    		this.main_window.delete_event.connect (() => {
    			int x, y;// Position variables

    			this.main_window.get_position (out x, out y);// Get position in variables

    			// Save Values in GSCHEMA
				settings.opening_x = x;
    			settings.opening_y = y;
    
    			return false;
			});

        	this.main_window.add (main_box);
        	this.main_window.show_all ();
    	}

    	public App () {
    		this.set_flags (ApplicationFlags.HANDLES_OPEN);
        	Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = false;
    	}

    	public override void activate () {
    		if (this.main_window == null)
            	build_and_run ();
    	}

        private void on_drag_data_received (Gdk.DragContext drag_context, int x, int y,
                                            Gtk.SelectionData data, uint info, uint time) 
        {


            foreach (string uri in data.get_uris ()) {

                string file_path = uri.replace("file://","").replace("file:/","");

                file_path = Uri.unescape_string (file_path);

                files_uris.append_val (file_path);

                                
            }

            list_of_hash = "";

            for (int i = 0; i < files_uris.length; i++) {
                list_of_hash += files_uris.index (i) + "\n";
            }

            this.text_view.buffer.text = list_of_hash;

            Gtk.drag_finish (drag_context, true, false, time);
        }

	}
}
