
#Область СлужебныеПроцедурыИФункции

Процедура СотрудникиПередЗаписью(Форма, Отказ, ПараметрыЗаписи) Экспорт
	
	СотрудникиКлиентРасширенный.СотрудникиПередЗаписью(Форма, Отказ, ПараметрыЗаписи);
	
КонецПроцедуры

Процедура ФизическиеЛицаПередЗаписью(Форма, Отказ, ПараметрыЗаписи, ОповещениеЗавершения = Неопределено, ЗакрытьПослеЗаписи = Истина) Экспорт
	
	СотрудникиКлиентРасширенный.ФизическиеЛицаПередЗаписью(Форма, Отказ, ПараметрыЗаписи, ОповещениеЗавершения, ЗакрытьПослеЗаписи);
	
КонецПроцедуры

Процедура ФизическиеЛицаОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник) Экспорт
	
	СотрудникиКлиентРасширенный.ФизическиеЛицаОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник);
	
КонецПроцедуры

Процедура ФизическиеЛицаИННПриИзменении(Форма, Элемент) Экспорт
	
	СотрудникиКлиентРасширенный.ФизическиеЛицаИННПриИзменении(Форма, Элемент);
	
КонецПроцедуры

Процедура ФизическиеЛицаСтраховойНомерПФРПриИзменении(Форма, Элемент) Экспорт
	
	СотрудникиКлиентРасширенный.ФизическиеЛицаСтраховойНомерПФРПриИзменении(Форма, Элемент);
	
КонецПроцедуры

// Обработчик события "ПриИзменении".
// Параметры:
//		Форма - ФормаКлиентскогоПриложения - форма документа.
Процедура ДокументыФизическихЛицВидДокументаПриИзменении(Форма) Экспорт
	
	СотрудникиКлиентРасширенный.ДокументыФизическихЛицВидДокументаПриИзменении(Форма);
	
КонецПроцедуры

// Обработчик события "ПриИзменении".
// Параметры:
//		Форма - ФормаКлиентскогоПриложения - форма документа.
//		Элемент - ПолеВвода - элемент формы.
Процедура ДокументыФизическихЛицНомерПриИзменении(Форма, Элемент) Экспорт
	
	СотрудникиКлиентРасширенный.ДокументыФизическихЛицНомерПриИзменении(Форма, Элемент);
	
КонецПроцедуры

#КонецОбласти