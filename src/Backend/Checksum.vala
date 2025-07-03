/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2016 Juan Pablo Lozano <libredeb@gmail.com>
 */

namespace Hashit.Backend.Checksum {

    public static string? calculate_hash (string type, string file_path) {
        GLib.Checksum checksum = null;

        switch (type) {
            case "MD5":
                checksum = new GLib.Checksum (GLib.ChecksumType.MD5);
                break;
            case "SHA1":
                checksum = new GLib.Checksum (GLib.ChecksumType.SHA1);
                break;
            case "SHA256":
                checksum = new GLib.Checksum (GLib.ChecksumType.SHA256);
                break;
            case "SHA512":
                checksum = new GLib.Checksum (GLib.ChecksumType.SHA512);
                break;
        }

        FileStream? stream = FileStream.open (file_path, "rb");
        if (stream == null) {
            warning ("Failed to open \"%s\": %s", file_path, strerror(errno));
            return null;
        }

        uint8 buffer[100];
        size_t size;

        while ((size = stream.read (buffer)) > 0) {
            checksum.update (buffer, size);
        }

        unowned string digest = checksum.get_string ();
        return digest;
    }

}
