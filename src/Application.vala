/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2016 Juan Pablo Lozano <libredeb@gmail.com>
 */

//Importing libraries
using Gtk;
using GLib;
using Granite;

namespace Hashit {

    public class App : Gtk.Application {

        //Global variables
        public Window main_window;
        public Adw.ToastOverlay toast_overlay;
        public Gtk.Settings settings;
        public Gtk.HeaderBar headerbar;

        public Gtk.Entry last_hash_entry;
        public Hashit.Widgets.Selection selection_box;

        public Array<string> files_uris;
        public TextView text_view;
        public TextBuffer text_view_buffer;
        public ResultState result_flag = ResultState.NONE;

        // Compare tab elements
        private Gtk.Entry oem_hash_entry;
        private Gtk.Label compare_state_label;
        private Gtk.Box result_img_box;
        private Gtk.Image result_status_img;

        public void build_and_run () {
            // Initialize variables
            files_uris = new Array<string> ();

            /*
             * Set up Window 
             */
            this.main_window = new Window ();
            this.main_window.set_size_request (750, 570);
            this.main_window.set_title (Constants.PROGRAM_NAME);
            this.main_window.set_icon_name (Constants.EXEC_NAME);
            this.main_window.set_resizable (false);
            this.main_window.set_application (this);

            this.toast_overlay = new Adw.ToastOverlay ();

            /*
             * Set up UI 
             */
            this.headerbar = Hashit.Widgets.build_header_bar (
                this.main_window, this
            );
            this.main_window.set_titlebar (this.headerbar);

            //Boxes
            Box main_box = new Box (Orientation.HORIZONTAL, 0);
            main_box.set_margin_bottom (12);
            main_box.set_margin_end (12);
            main_box.set_margin_start (12);
            main_box.set_margin_top (12);
            Box content_box = new Box (Orientation.VERTICAL, 0);
            content_box.set_vexpand (true);
            Box drag_box = new Box (Orientation.HORIZONTAL, 0);
            Box combobox_box = new Box (Orientation.HORIZONTAL, 0);
            Box headboard_box = new Box (Orientation.HORIZONTAL, 0);
            Box input_fieldset_box = new Box (Orientation.HORIZONTAL, 0);
            Box hashtype_fieldset_box = new Box (Orientation.HORIZONTAL, 0);
            Box lasthash_fieldset_box = new Box (Orientation.HORIZONTAL, 0);
            Box input_box = new Box (Orientation.VERTICAL, 0);
            input_box.set_vexpand (true);
            Box input_content_box = new Box (Orientation.HORIZONTAL, 0);
            input_content_box.set_hexpand (true);
            input_content_box.set_margin_end (6);
            input_content_box.set_margin_start (6);
            Box hashtype_box = new Box (Orientation.VERTICAL, 0);
            hashtype_box.set_margin_top (6);
            hashtype_box.set_margin_bottom (6);
            Box lasthash_box = new Box (Orientation.VERTICAL, 0);
            lasthash_box.set_margin_top (4);
            lasthash_box.set_margin_bottom (4);
            Box lasthash_content_box = new Box (Orientation.HORIZONTAL, 0);
            lasthash_content_box.set_margin_top (6);
            lasthash_content_box.set_margin_bottom (6);
            Box selection_container_box = new Box (Orientation.VERTICAL, 0);
            selection_container_box.set_margin_top (12);
            selection_container_box.set_margin_bottom (12);
            Box results_stack_box = new Box (Orientation.VERTICAL, 0);
            Box compare_stack_box = new Box (Orientation.VERTICAL, 0);
            Box stack_box = new Box (Orientation.VERTICAL, 0);
            stack_box.set_vexpand (true);
            Box stack_switcher_box = new Box (Orientation.HORIZONTAL, 0);
            Box results_buttons_box = new Box (Orientation.HORIZONTAL, 0);
            Box textview_content_box = new Box (Orientation.VERTICAL, 0);
            textview_content_box.set_hexpand (true);
            textview_content_box.set_vexpand (true);
            Box textview_box = new Box (Orientation.HORIZONTAL, 0);
            textview_box.set_hexpand (true);
            textview_box.set_vexpand (true);
            textview_box.set_margin_bottom (12);
            textview_box.set_margin_end (12);
            textview_box.set_margin_start (12);
            textview_box.set_margin_top (12);
            Box compare_label_box = new Box (Orientation.HORIZONTAL, 0);
            Box compare_button_box = new Box (Orientation.HORIZONTAL, 0);
            Box compare_box = new Box (Orientation.VERTICAL, 0);
            compare_box.set_hexpand (true);
            compare_box.set_vexpand (true);
            compare_box.set_margin_bottom (12);
            compare_box.set_margin_end (12);
            compare_box.set_margin_start (12);
            compare_box.set_margin_top (12);
            Box compare_result_box = new Box (Orientation.HORIZONTAL, 0);
            compare_result_box.set_margin_bottom (12);
            compare_result_box.set_margin_start (12);
            compare_result_box.set_margin_top (12);
            this.result_img_box = new Box (Orientation.HORIZONTAL, 0);
            this.result_img_box.set_margin_end (21);
            this.result_img_box.set_margin_start (21);
            Box compare_state_box = new Box (Orientation.HORIZONTAL, 4);
            Box state_box = new Box (Orientation.VERTICAL, 0);
            state_box.set_vexpand (true);
            state_box.set_hexpand (true);
            Box state_content_box = new Box (Orientation.HORIZONTAL, 0);

            //Labels
            Label input_fieldset_label = new Label ("");
            input_fieldset_label.set_markup ("<b>" + _("Input File") + "</b>");
            Label hashtype_fieldset_label = new Label ("");
            hashtype_fieldset_label.set_markup ("<b>" + _("Hash Type") + "</b>");
            Label lasthash_fieldset_label = new Label ("");
            lasthash_fieldset_label.set_markup ("<b>" + _("Last Hash") + "</b>");
            lasthash_fieldset_label.set_margin_bottom (5);
            lasthash_fieldset_label.set_margin_end (5);
            lasthash_fieldset_label.set_margin_start (5);
            lasthash_fieldset_label.set_margin_top (5);
            Label compare_result_label = new Label ("");
            compare_result_label.set_markup ("<b>" + _("Original Hash:") + "</b>");
            compare_result_label.set_margin_bottom (6);
            compare_result_label.set_margin_end (6);
            compare_result_label.set_margin_start (6);
            compare_result_label.set_margin_top (6);
            this.compare_state_label = new Label ("");
            this.compare_state_label.set_markup (
                "<span font_size='large'><b>" + _("Comparison Result") + "</b></span>"
            );
            this.compare_state_label.set_margin_bottom (25);
            this.compare_state_label.set_margin_end (25);
            this.compare_state_label.set_margin_start (25);
            this.compare_state_label.set_margin_top (25);

            //Text View
            this.text_view = new TextView ();
            this.text_view.editable = false;
            this.text_view.cursor_visible = false;
            this.text_view_buffer = this.text_view.get_buffer ();

            var scrolled_result = new Gtk.ScrolledWindow ();
            scrolled_result.set_policy (PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
            scrolled_result.set_child (this.text_view);
            scrolled_result.set_hexpand (true);
            scrolled_result.set_vexpand (true);

            //Buttons
            var copy_button = new Button.with_label (_("Copy"));
            copy_button.set_margin_start (6);
            copy_button.set_margin_end (6);
            var copy_history_button = new Button.with_label (_("Copy History"));
            var compare_button = new Button.with_label (_("Compare"));
            compare_button.set_margin_bottom (4);
            compare_button.set_margin_end (4);
            compare_button.set_margin_start (4);
            compare_button.set_margin_top (4);

            //Status Icons
            this.result_status_img = new Image ();
            this.result_status_img.add_css_class (Granite.STYLE_CLASS_LARGE_ICONS);
            try {
                var result_status_pixbuf = new Gdk.Pixbuf.from_file_at_scale (
                    "/usr/share/hashit/gfx/result-status.svg", 24, 24, false
                );
                var result_status_texture = Gdk.Texture.for_pixbuf (result_status_pixbuf);
                this.result_status_img.set_from_paintable (result_status_texture);
            } catch (GLib.Error e) {
                warning ("Error creating pixbuf icon for status image");
                warning ("Check file /usr/share/hashit/gfx/result-status.svg");
            }
            Image result_ok_img = new Image ();
            result_ok_img.add_css_class (Granite.STYLE_CLASS_LARGE_ICONS);
            try {
                var result_ok_pixbuf = new Gdk.Pixbuf.from_file_at_scale (
                    "/usr/share/hashit/gfx/result-ok.svg", 24, 24, false
                );
                var result_ok_texture = Gdk.Texture.for_pixbuf (result_ok_pixbuf);
                result_ok_img.set_from_paintable (result_ok_texture);
            } catch (GLib.Error e) {
                warning ("Error creating pixbuf icon for status_ok image");
                warning ("Check file /usr/share/hashit/gfx/result-ok.svg");
            }
            Image result_error_img = new Image ();
            result_error_img.add_css_class (Granite.STYLE_CLASS_LARGE_ICONS);
            try {
                var result_error_pixbuf = new Gdk.Pixbuf.from_file_at_scale (
                    "/usr/share/hashit/gfx/result-error.svg", 24, 24, false
                );
                var result_error_texture = Gdk.Texture.for_pixbuf (result_error_pixbuf);
                result_error_img.set_from_paintable (result_error_texture);
            } catch (GLib.Error e) {
                warning ("Error creating pixbuf icon for status_error image");
                warning ("Check file /usr/share/hashit/gfx/result-error.svg");
            }

            // Entrys
            last_hash_entry = new Entry ();
            last_hash_entry.set_hexpand (true);
            last_hash_entry.set_margin_end (6);
            last_hash_entry.set_margin_start (6);
            this.oem_hash_entry = new Entry ();
            this.oem_hash_entry.set_hexpand (true);
            this.oem_hash_entry.set_margin_bottom (6);
            this.oem_hash_entry.set_margin_end (6);
            this.oem_hash_entry.set_margin_start (6);
            this.oem_hash_entry.set_margin_top (6);

            // Separators
            Separator selection_top_separator = new Separator (Gtk.Orientation.HORIZONTAL);
            Separator selection_bottom_separator = new Separator (Gtk.Orientation.HORIZONTAL);
            Separator stack_left_separator = new Separator (Gtk.Orientation.HORIZONTAL);
            stack_left_separator.set_hexpand (true);
            Separator stack_right_separator = new Separator (Gtk.Orientation.HORIZONTAL);
            stack_right_separator.set_hexpand (true);
            Separator input_fieldset_separator = new Separator (Gtk.Orientation.HORIZONTAL);
            input_fieldset_separator.set_margin_bottom (4);
            input_fieldset_separator.set_margin_end (4);
            input_fieldset_separator.set_margin_start (4);
            input_fieldset_separator.set_margin_top (4);
            input_fieldset_separator.set_hexpand (true);
            Separator input_fill_separator = new Separator (Gtk.Orientation.HORIZONTAL);
            input_fill_separator.set_margin_end (6);
            input_fill_separator.set_margin_start (6);
            Separator hashtype_fieldset_separator = new Separator (Gtk.Orientation.HORIZONTAL);
            hashtype_fieldset_separator.set_margin_bottom (4);
            hashtype_fieldset_separator.set_margin_end (4);
            hashtype_fieldset_separator.set_margin_start (4);
            hashtype_fieldset_separator.set_margin_top (4);
            hashtype_fieldset_separator.set_size_request (24, -1);
            Separator lasthash_fieldset_separator = new Separator (Gtk.Orientation.HORIZONTAL);
            lasthash_fieldset_separator.set_hexpand (true);

            //TextView Separators
            Separator text_top_separator = new Separator (Gtk.Orientation.HORIZONTAL);
            Separator text_bottom_separator = new Separator (Gtk.Orientation.HORIZONTAL);
            Separator text_left_separator = new Separator (Gtk.Orientation.VERTICAL);
            Separator text_right_separator = new Separator (Gtk.Orientation.VERTICAL);

            //Compare Button Separators
            Separator compare_left_separator = new Separator (Gtk.Orientation.HORIZONTAL);
            compare_left_separator.set_hexpand (true);
            Separator copy_left_separator = new Separator (Gtk.Orientation.HORIZONTAL);
            copy_left_separator.set_hexpand (true);
            Separator state_top_separator = new Separator (Gtk.Orientation.VERTICAL);
            state_top_separator.set_vexpand (true);
            Separator state_bottom_separator = new Separator (Gtk.Orientation.VERTICAL);
            state_bottom_separator.set_vexpand (true);
            Separator state_left_separator = new Separator (Gtk.Orientation.HORIZONTAL);
            state_left_separator.set_hexpand (true);
            Separator state_right_separator = new Separator (Gtk.Orientation.HORIZONTAL);
            state_right_separator.set_hexpand (true);

            //Separators Properties
            input_fieldset_separator.set_opacity (0.0);
            hashtype_fieldset_separator.set_opacity (0.0);
            lasthash_fieldset_separator.set_opacity (0.0);
            selection_top_separator.set_opacity (0.0);
            selection_bottom_separator.set_opacity (0.0);
            input_fill_separator.set_opacity (0.0);
            compare_left_separator.set_opacity (0.0);
            copy_left_separator.set_opacity (0.0);
            state_top_separator.set_opacity (0.0);
            state_bottom_separator.set_opacity (0.0);
            state_left_separator.set_opacity (0.0);
            state_right_separator.set_opacity (0.0);
            stack_left_separator.set_opacity (0.0);
            stack_right_separator.set_opacity (0.0);

            //Drag And Drop area
            var drag_area = new Hashit.Widgets.DragAndDrop ();
            drag_area.set_vexpand (true);
            drag_area.set_hexpand (true);
            drag_area.set_margin_bottom (12);
            drag_area.set_margin_end (12);
            drag_area.set_margin_start (12);
            drag_area.set_margin_top (12);

            //Selection Types Box
            selection_box = new Hashit.Widgets.Selection ();

            /*
             * Stack
             */
            var stack = new Stack ();
            stack.set_transition_type (Gtk.StackTransitionType.SLIDE_LEFT_RIGHT);
            stack.set_transition_duration (500);
            stack.set_hexpand (true);
            stack.set_vexpand (true);
            stack.add_titled (results_stack_box, "results_stack_box", _("Results"));
            stack.add_titled (compare_stack_box, "compare_stack_box", _("Compare"));

            var stack_switcher = new StackSwitcher ();
            stack_switcher.set_stack (stack);

            compare_button.clicked.connect (() => {
                if (last_hash_entry.get_text ().to_string () == this.oem_hash_entry.get_text ().to_string ()) {
                    switch (result_flag) {
                        case ResultState.NONE:
                            this.result_img_box.remove (this.result_status_img);
                            break;
                        case ResultState.ERROR:
                            this.result_img_box.remove (result_error_img);
                            break;
                        case ResultState.OK:
                            return;
                    }

                    result_flag = ResultState.OK;
                    this.result_img_box.append (result_ok_img);

                    this.compare_state_label.set_markup (
                        "<span font_size='large' fgcolor='#000' bgcolor='#80FF80'><b>     "
                        + _("Checksums match! File Integrity OK") + "     </b></span>"
                    );
                } else {
                    switch (result_flag) {
                        case ResultState.NONE:
                            this.result_img_box.remove (this.result_status_img);
                            break;
                        case ResultState.OK:
                            this.result_img_box.remove (result_ok_img);
                            break;
                        case ResultState.ERROR:
                            return;
                    }

                    result_flag = ResultState.ERROR;
                    this.result_img_box.append (result_error_img);

                    this.compare_state_label.set_markup (
                        "<span font_size='large' fgcolor='#000' bgcolor='#FF8080'><b>     "
                        + _("Checksums do not match! File Integrity ERROR") + "     </b></span>"
                    );
                }
                this.result_img_box.queue_draw ();
            });

            /*
             * BUILDING BOXES
             */
            //Fieldset Boxes
            input_fieldset_box.append (input_fieldset_label);
            input_fieldset_box.append (input_fieldset_separator);
            hashtype_fieldset_box.append (hashtype_fieldset_label);
            hashtype_fieldset_box.append (hashtype_fieldset_separator);
            lasthash_fieldset_box.append (lasthash_fieldset_label);
            lasthash_fieldset_box.append (lasthash_fieldset_separator);

            //First arm the Selection_Box correctly
            combobox_box.append (selection_box);
            selection_container_box.append (selection_top_separator);
            selection_container_box.append (combobox_box);
            selection_container_box.append (selection_bottom_separator);

            //TextView Boxes
            textview_content_box.append (text_top_separator);
            textview_content_box.append (scrolled_result);
            textview_content_box.append (text_bottom_separator);
            textview_box.append (text_left_separator);
            textview_box.append (textview_content_box);
            textview_box.append (text_right_separator);

            //Compare Boxes
            compare_label_box.append (compare_result_label);
            compare_button_box.append (compare_left_separator);
            compare_button_box.append (compare_button);
            this.result_img_box.append (this.result_status_img);
            compare_result_box.append (this.oem_hash_entry);
            compare_result_box.append (this.result_img_box);
            compare_state_box.append (this.compare_state_label);
            state_content_box.append (state_left_separator);
            state_content_box.append (compare_state_box);
            state_content_box.append (state_right_separator);
            state_box.append (state_top_separator);
            state_box.append (state_content_box);
            state_box.append (state_bottom_separator);
            compare_box.append (compare_label_box);
            compare_box.append (compare_result_box);
            compare_box.append (state_box);
            compare_box.append (compare_button_box);

            //Then, the Stack Boxes
            results_buttons_box.append (copy_left_separator);
            results_buttons_box.append (copy_history_button);
            results_stack_box.append (textview_box);
            results_stack_box.append (results_buttons_box);
            compare_stack_box.append (compare_box);
            stack_switcher_box.append (stack_left_separator);
            stack_switcher_box.append (stack_switcher);
            stack_switcher_box.append (stack_right_separator);
            stack_box.append (stack_switcher_box);
            stack_box.append (stack);

            //Then the other boxes
            drag_box.append (drag_area);
            lasthash_content_box.append (last_hash_entry);
            lasthash_content_box.append (copy_button);
            input_box.append (input_fieldset_box);
            input_box.append (input_fill_separator);
            input_box.append (drag_box);
            input_content_box.append (input_box);
            hashtype_box.append (hashtype_fieldset_box);
            hashtype_box.append (selection_container_box);
            lasthash_box.append (lasthash_fieldset_box);
            lasthash_box.append (lasthash_content_box);
            headboard_box.append (input_content_box);
            headboard_box.append (hashtype_box);
            content_box.append (headboard_box); //Content Box is VERTICAL
            content_box.append (lasthash_box);
            content_box.append (stack_box);
            main_box.append (content_box); //Main Box is HORIZONTAL

            /*
             * ASSIGN THE DRAG ACTION TO WIDGET
             */
            var file_target = new DropTarget (typeof (Gdk.FileList), Gdk.DragAction.COPY);

            file_target.drop.connect ((value, x, y) => {
                var file_list = (Gdk.FileList) value;

                foreach (var file in file_list.get_files()) {
                    if (file is GLib.File) {
                        var gio_file = (GLib.File) file;
                        string file_path = gio_file.get_path();
                        this.get_file_hash (file_path);
                    } else {
                        message ("File type is not recognized");
                    }
                }
                return true;
            });
            drag_box.add_controller (file_target);

            copy_button.clicked.connect (() => {
                var display = this.main_window.get_display ();
                var clipboard = display.get_clipboard ();
                clipboard.set_text (last_hash_entry.get_text ());

                var toast = new Adw.Toast ("Hash successfully copied");
                toast.set_timeout (2);
                this.toast_overlay.add_toast (toast);
            });

            copy_history_button.clicked.connect (() => {
                var display = this.main_window.get_display ();
                var clipboard = display.get_clipboard ();

                Gtk.TextBuffer buffer = this.text_view.get_buffer ();
                Gtk.TextIter start, end;
                buffer.get_bounds (out start, out end);

                string text_view_content = buffer.get_text (start, end, false);
                clipboard.set_text (text_view_content);

                var toast = new Adw.Toast ("History successfully copied");
                toast.set_timeout (2);
                this.toast_overlay.add_toast (toast);
            });

            this.toast_overlay.set_child (main_box);
            this.main_window.set_child (this.toast_overlay);
        }

        public void on_clear_button () {
            this.last_hash_entry.set_text ("");
            this.text_view_buffer.set_text ("");
            this.selection_box.reset_to_default ();

            // Reset compare tab elements
            this.oem_hash_entry.set_text ("");
            this.compare_state_label.set_markup (
                "<span font_size='large'><b>" + _("Comparison Result") + "</b></span>"
            );

            // Reset icon to default status
            while (this.result_img_box.get_first_child () != null) {
                this.result_img_box.remove (this.result_img_box.get_first_child ());
            }
            this.result_img_box.append (this.result_status_img);
            this.result_flag = ResultState.NONE;
        }

        public void on_save_button () {
            var dialog = new Gtk.FileDialog ();
            dialog.set_title (_("Save as"));
            dialog.set_initial_name ("*.txt");

            dialog.save.begin (this.main_window, null, (obj, res) => {
                try {
                    var file = dialog.save.end (res);
                    if (file != null) {
                        Gtk.TextBuffer buffer = this.text_view.get_buffer ();
                        Gtk.TextIter start, end;
                        buffer.get_bounds (out start, out end);

                        string text_view_content = buffer.get_text (start, end, false);
                        uint8[] bytes = (uint8[]) text_view_content.data;
                        string? etag = null;

                        file.replace_contents (
                            bytes,
                            null,
                            false,
                            FileCreateFlags.NONE,
                            out etag,
                            null
                        );
                    }
                } catch (Error e) {
                    warning ("Error when saving the file: %s", e.message);
                }
            });
        }

        public void get_file_hash (string path) {
            this.files_uris.append_val (path);

            string hash = Hashit.Backend.Checksum.calculate_hash (
                this.selection_box.get_dropdown_value (),
                path
            );
            this.last_hash_entry.set_text (hash);

            TextIter text_end_iter;
            this.text_view_buffer.get_end_iter (out text_end_iter);

            var file_name = Path.get_basename (path);
            string iter_text = hash + "  " + file_name + "\n";
            this.text_view_buffer.insert (
                ref text_end_iter, iter_text, iter_text.length
            );

            this.text_view.scroll_to_iter (text_end_iter, 0.0, false, 0.0, 0.0);
        }

        public App () {
            Object (
                application_id: "com.github.libredeb.hashit",
                flags: GLib.ApplicationFlags.HANDLES_OPEN
            );
        }

        private static App app; // global App instance
        public static App get_instance () {
            if (app == null)
                app = new App ();
            return app;
        }

        protected override void activate () {
            var granite_settings = Granite.Settings.get_default ();
            settings = Gtk.Settings.get_default ();
            if (granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK)
                settings.gtk_application_prefer_dark_theme = true;

            granite_settings.notify["prefers-color-scheme"].connect (() => {
                if (granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK)
                    settings.gtk_application_prefer_dark_theme = true;
            });
            if (this.main_window == null)
                build_and_run ();

            this.main_window.present ();
        }
    }
}
