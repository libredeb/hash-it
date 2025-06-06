/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2016 Juan Pablo Lozano <libredeb@gmail.com>
 */
using Gtk;

public static int main (string[] args) {
    Gtk.init ();
    var app = Hashit.App.get_instance ();
    app.run (args);
    return 0;
}
