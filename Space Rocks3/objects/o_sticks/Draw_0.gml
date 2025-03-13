var main_scale = 120 * stick_scale;

if (device == -1)
{
	for(var i = 0; i < 3; i++)
	{
		if (device_mouse_check_button_pressed(i,mb_left))
		{
			if (zone == "full")
			{
				if (!view_enabled)	
				{
					var rx_first = 0;
					var ry_first = 0;
					var rx_last  = room_width;
					var ry_last  = room_height;
				}
				else
				{
					var rx_first = camera_get_view_x(view_camera[0]);
					var ry_first = camera_get_view_y(view_camera[0]);
					var rx_last  = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]);
					var ry_last  = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]);
				}
			}
			if (zone == "left")
			{
				if (!view_enabled)	
				{
					var rx_first = 0;
					var ry_first = 0;
					var rx_last  = room_width/2;
					var ry_last  = room_height;
				}
				else
				{
					var rx_first = camera_get_view_x(view_camera[0]);
					var ry_first = camera_get_view_y(view_camera[0]);
					var rx_last  = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])/2;
					var ry_last  = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]);
				}
			}
			if (zone == "right")
			{
				if (!view_enabled)	
				{
					var rx_first = room_width/2;
					var ry_first = 0;
					var rx_last  = room_width;
					var ry_last  = room_height;
				}
				else
				{
					var rx_first = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])/2;
					var ry_first = camera_get_view_y(view_camera[0]);
					var rx_last  = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]);
					var ry_last  = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]);
				}
			}
			
			if (point_in_rectangle(device_mouse_x(i),device_mouse_y(i),rx_first,ry_first,rx_last,ry_last))
			{
				device = i;
				
				if (!view_enabled)	
				{
					stick_x = device_mouse_x(i);
					stick_y = device_mouse_y(i);
				}
				else
				{
					stick_x = device_mouse_x(i) - camera_get_view_x(view_camera[0]);
					stick_y = device_mouse_y(i) - camera_get_view_y(view_camera[0]);
				}
				break;
			}
		}
	}
}

if (mouse_check_button_released(mb_left))
{
	device = -1;
	
	stick_x       = 0;
	stick_y       = 0;
	pos_x         = 0;
	pos_y         = 0;
}

if (device != -1)
{
	var current_color = draw_get_color();
	draw_set_color(stick_color);
	if (!view_enabled)	
	{
		var tmp_cx = 0;
		var tmp_cy = 0;
	}
	else
	{
		var tmp_cx = camera_get_view_x(view_camera[0]);
		var tmp_cy = camera_get_view_y(view_camera[0]);
	}
	
	
	if (point_distance(tmp_cx + stick_x,tmp_cy + stick_y,device_mouse_x(device),device_mouse_y(device)) < main_scale)
	{
		pos_x = device_mouse_x(device);
		pos_y = device_mouse_y(device);
	}
	else
	{
		var _dir = point_direction(tmp_cx + stick_x,tmp_cy + stick_y,device_mouse_x(device),device_mouse_y(device));
		
		pos_x = tmp_cx + stick_x + lengthdir_x(main_scale,_dir);
		pos_y = tmp_cy + stick_y + lengthdir_y(main_scale,_dir);
	}
	
	stick_pos   = point_distance(tmp_cx + stick_x,tmp_cy + stick_y,pos_x,pos_y) / main_scale;
	stick_angle = point_direction(tmp_cx + stick_x,tmp_cy + stick_y,pos_x,pos_y);
	
	if (stick_pos > 0.05)
	{
		var stick_tmp_dir = round(point_direction(tmp_cx + stick_x,tmp_cy + stick_y,pos_x,pos_y) / 45);
		show_debug_message(string(stick_tmp_dir))
		switch(stick_tmp_dir)
		{
			case 0:     stick_portait = 1  stick_land = 0;break;
			case 1:     stick_portait = 1  stick_land = -1;break;
			case 2:     stick_portait = 0  stick_land = -1;break;
			case 3:     stick_portait = -1  stick_land = -1;break;
			case 4:     stick_portait = -1  stick_land = 0;break;
			case 5:     stick_portait = -1  stick_land = 1;break;
			case 6:     stick_portait = 0  stick_land = 1;break;
			case 7:     stick_portait = 1  stick_land = 1;break;
		}
	}
	else
	{
		stick_land    = 0;
		stick_portait = 0;
	}
	
	if (sprite_back == -1)
	{
		draw_set_alpha(0.4);
		draw_circle(tmp_cx + stick_x,tmp_cy + stick_y,main_scale,stick_fill);
		draw_set_alpha(1);
		
		if (type == "free")
		{
			draw_circle(pos_x,pos_y,main_scale * 0.35,stick_fill);
		}
		if (type == "4dir")
		{
			var _dir    = point_direction(tmp_cx + stick_x,tmp_cy + stick_y,device_mouse_x(device),device_mouse_y(device));
			_dir        = ((_dir div 90 ) * 90);
			var __pos_x = tmp_cx + stick_x + lengthdir_x(main_scale / 2,_dir);
			var __pos_y = tmp_cy + stick_y + lengthdir_y(main_scale / 2,_dir);
			draw_circle(__pos_x,__pos_y,main_scale * 0.35,stick_fill);
		}
		if (type == "8dir")
		{
			var _dir    = point_direction(tmp_cx + stick_x,tmp_cy + stick_y,device_mouse_x(device),device_mouse_y(device));
			_dir        = ((_dir div 45 ) * 45);
			var __pos_x = tmp_cx + stick_x + lengthdir_x(main_scale / 2,_dir);
			var __pos_y = tmp_cy + stick_y + lengthdir_y(main_scale / 2,_dir);
			draw_circle(__pos_x,__pos_y,main_scale * 0.35,stick_fill);
		}	
	}
	else
	{
		draw_sprite_pos(sprite_back,0,
		tmp_cx + stick_x - (main_scale),tmp_cy + stick_y - (main_scale),
		tmp_cx + stick_x + (main_scale),tmp_cy + stick_y - (main_scale),
		tmp_cx + stick_x + (main_scale),tmp_cy + stick_y + (main_scale),
		tmp_cx + stick_x - (main_scale),tmp_cy + stick_y + (main_scale),0.6);
		
		if (type == "free")
		{
			var pos_scale = main_scale * 0.35;
			draw_sprite_pos(sprite_top,0,
			pos_x - (pos_scale),pos_y - (pos_scale),
			pos_x + (pos_scale),pos_y - (pos_scale),
			pos_x + (pos_scale),pos_y + (pos_scale),
			pos_x - (pos_scale),pos_y + (pos_scale),1);
		}
		if (type == "4dir")
		{
			var _dir    = point_direction(tmp_cx + stick_x,tmp_cy + stick_y,device_mouse_x(device),device_mouse_y(device));
			_dir        = ((_dir div 90 ) * 90);
			var __pos_x = tmp_cx + stick_x + lengthdir_x(main_scale / 2,_dir);
			var __pos_y = tmp_cy + stick_y + lengthdir_y(main_scale / 2,_dir);

			var pos_scale = main_scale * 0.35;
			draw_sprite_pos(sprite_top,0,
			__pos_x - (pos_scale),__pos_y - (pos_scale),
			__pos_x + (pos_scale),__pos_y - (pos_scale),
			__pos_x + (pos_scale),__pos_y + (pos_scale),
			__pos_x - (pos_scale),__pos_y + (pos_scale),1);
		}
		if (type == "8dir")
		{
			var _dir    = point_direction(tmp_cx + stick_x,tmp_cy + stick_y,device_mouse_x(device),device_mouse_y(device));
			_dir        = ((_dir div 45 ) * 45);
			var __pos_x = tmp_cx + stick_x + lengthdir_x(main_scale / 2,_dir);
			var __pos_y = tmp_cy + stick_y + lengthdir_y(main_scale / 2,_dir);
			var pos_scale = main_scale * 0.35;
			
			draw_sprite_pos(sprite_top,0,
			__pos_x - (pos_scale),__pos_y - (pos_scale),
			__pos_x + (pos_scale),__pos_y - (pos_scale),
			__pos_x + (pos_scale),__pos_y + (pos_scale),
			__pos_x - (pos_scale),__pos_y + (pos_scale),1);
		}	
	}
	
	draw_set_color(current_color);	
}
else
{
	stick_pos = 0;
	
	stick_land    = 0;
	stick_portait = 0;
}

