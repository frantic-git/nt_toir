#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ТаблицаСоответствийВерсий.Загрузить(ПолучитьТаблицуВерсийПриложенийРелизам());
	ВерсияТОиР = ОбновлениеИнформационнойБазы.ВерсияИБ("ТехническоеОбслуживаниеИРемонты3");

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ПолучитьТаблицуВерсийПриложенийРелизам() 

	ТаблицаСоответствияВерсийМПРелизам = Новый ТаблицаЗначений;
	ТаблицаСоответствияВерсийМПРелизам.Колонки.Добавить("ВерсияРелиза");
	ТаблицаСоответствияВерсийМПРелизам.Колонки.Добавить("ВерсияМП");
	
	МакетСоответствие = Обработки.торо_МобильныеПриложения.ПолучитьМакет("СоответствиеВерсийПриложенияВерсиямРелизов");
	ОбластьСоответствие = МакетСоответствие.ПолучитьОбласть("СоответствиеВерсийПриложенияВерсиямРелизов"); 

	Для Сч = 1 По ОбластьСоответствие.ВысотаТаблицы Цикл
		СтрокаТаблицы				= ТаблицаСоответствияВерсийМПРелизам.Добавить();
		СтрокаТаблицы.ВерсияРелиза	= ОбластьСоответствие.Область(Сч,1,Сч,1).Текст;
		СтрокаТаблицы.ВерсияМП		= ОбластьСоответствие.Область(Сч,2,Сч,2).Текст;
	КонецЦикла;
	
	Возврат ТаблицаСоответствияВерсийМПРелизам;
	
КонецФункции

#КонецОбласти