move_x = web_get_horizont_key(joy);
move_y = web_get_vertical_key(joy);

x += move_x * 5;
y += move_y * 5;

// Проверяем нажатые кнопки крестовины
var move_x = gamepad_button_check(0, gp_padr) - gamepad_button_check(0, gp_padl);
var move_y = gamepad_button_check(0, gp_padd) - gamepad_button_check(0, gp_padu);

// Проверяем, есть ли наклон
if (move_x != 0 || move_y != 0) {
    image_angle = point_direction(0, 0, move_x, move_y);
}


if mouse_check_button_pressed(mb_left)
{
	instance_create_layer(x, y, "Instances", obj_bullet);	
}