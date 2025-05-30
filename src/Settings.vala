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

namespace Hashit.GSchema
{
	public class Settings : Granite.Services.Settings
	{
    	public int opening_x { get; set; }
    	public int opening_y { get; set; }
    
    	static Settings? instance = null;
    
    	public Settings ()
    	{
        	base ("org.hashit");
    	}
    
    	public static Settings get_default ()
    	{
        	if (instance == null)
            	instance = new Settings ();
        	return instance;
    	}
	}
}
