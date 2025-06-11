/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2016 Juan Pablo Lozano <libredeb@gmail.com>
 */

namespace Hashit.Widgets.FileDialog {

    public delegate void StringCallback (string? path);

    async void select_file (Gtk.Window parent, owned StringCallback callback) {
        var dialog = new Gtk.FileDialog ();
        dialog.set_title (_("Select file"));

        try {
            var file = yield dialog.open (parent, null);
            callback (file != null ? file.get_path () : null);
        } catch (Error e) {
            warning ("Error when selecting file %s", e.message);
            callback (null);
        }
    }

}
