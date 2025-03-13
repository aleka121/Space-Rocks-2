//~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Стики для мобильных версия 0.0.1 скачено с https://boosty.to/gamemakerboost
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/*
У каждого стика есть тип - type: 
free - свободное передвижение в границах
8dir - направление в 8 сторон
4dir - направление в 4 стороны

Каждому стику можно задать зону в которой он работает - zone:
full  - весь экран
right - только правая сторона
left  - только левая сторона

Каждый стик можно масштабировать в нужный размер - scale:
изначально равен 1(100%), 0 это будет(0%), 2(200%), 0.5(50%)

Параметр - _depth: Глубина, опционален

1. как создать джой?
Вызываем функцию и помещаем в переменную указатель на джойстик:
joy = web_stick_create("free","full");
создаст джойстик с указателем в "joy" со свободным вращением, и областью нажатия весь экран

2.Можно ли редактировать стик?
Да, для этого есть набор команд:

 2.1 web_stick_sprite(joy,спрайт_рамки,спрайт_джойстика)
 спрайты сами автоматически будут масштабироваться под размер, поэтому используйте любой размер

2.2 web_stick_color(joy,color)
 цвет заливки для джойстика
 
 2.3 web_stick_fill(joy,fill)
 заливать ли область джойстика, или рисовать только обводку
 
 2.4 web_stick_scale(joy,scale)
 Размер джойстика, по аналогии выше (1 по умолчанию)

3.Как получать значения со стика?
 Для этого воспользуйтесь web_get_* функциями
 
 3.1 web_get_angle(joy) 
 возвращает направление джойстика(от 0 до 360)
 
 3.2 web_get_horizont_key(joy) 
  возвращает значение как если бы Вы использвовали разницу символов с клавиатуры,
 возвращает значения по горизонтали в диапозоне -1, 1
 
 3.3 web_get_vertical_key(joy) 
 возвращает значение как если бы Вы использвовали разницу символов с клавиатуры,
 возвращает значения по вертикали в диапозоне -1, 1
 
 3.4 web_get_pos(joy) 
 Возвращает позицию джойстика для определения расстояния (например для ускорения)
 в диапозоне от 0 до 1
*/
function web_stick_create(type = "8dir",zone = "full",scale = 1,_depth = -1000_000_000)
{	
	var ins         = instance_create_depth(0,0,_depth,o_sticks);
	ins.type        = type;
	ins.zone        = zone;
	ins.stick_scale = scale;
	return ins;
}

function web_stick_sprite(_id = undefined,_spriteb = -1,_spritet = -1)
{	
	if (instance_exists(_id))
	{
		with(_id)
		{
			sprite_back = _spriteb;
			sprite_top  = _spritet;
		}
	}
}

function web_stick_scale(_id = undefined,_scale = 1)
{	
	if (instance_exists(_id))
	{
		with(_id)
		{
			stick_scale = _scale;
		}
	}
}


function web_stick_color(_id = undefined,_color = c_white)
{	
	if (instance_exists(_id))
	{
		with(_id)
		{
			stick_color = _color
		}
	}
}

function web_stick_fill(_id = undefined,_fill = 0)
{	
	if (instance_exists(_id))
	{
		with(_id)
		{
			stick_fill = _fill
		}
	}
}

function web_get_horizont_key(_id = undefined)
{	
	if (instance_exists(_id))
	{
		with(_id)
		{
			return  stick_portait;
		}
	}
}
function web_get_vertical_key(_id = undefined)
{	
	if (instance_exists(_id))
	{
		with(_id)
		{
			return stick_land;
		}
	}
}
function web_get_pos(_id = undefined)
{	
	if (instance_exists(_id))
	{
		with(_id)
		{
			return stick_pos;
		}
	}
}
function web_get_angle(_id = undefined)
{	
	if (instance_exists(_id))
	{
		with(_id)
		{
			return stick_angle;
		}
	}
}