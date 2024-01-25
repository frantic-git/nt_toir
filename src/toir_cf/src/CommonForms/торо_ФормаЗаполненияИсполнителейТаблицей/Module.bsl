#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("ТаблицаИсполнителей") Тогда
		ТаблицаИсполнителей.Загрузить(Параметры.ТаблицаИсполнителей[0].Выгрузить());
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТаблицаИсполнителей
&НаКлиенте
Процедура ТаблицаИсполнителейКвалификацияНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	СписокВыбора = Новый СписокЗначений;
	СписокВыбора.Добавить("<основная>" ,"Основная");
	СписокВыбора.Добавить("Выбрать..." ,"Произвольная");
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ОбработкаВыбораСпособаЗаполненияКвалификации", ЭтаФорма);
	ПоказатьВыборИзСписка(ОписаниеОповещения, СписокВыбора, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбораСпособаЗаполненияКвалификации(ВыбранноеЗначение, ДопПараметры) Экспорт
	
	ТекущиеДанные = Элементы.ТаблицаИсполнителей.ТекущиеДанные;
	Если ВыбранноеЗначение = Неопределено ИЛИ ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли; 
	
	Если ВыбранноеЗначение.Представление = "Произвольная" Тогда
		ОписаниеОповещения = Новый ОписаниеОповещения("ОбработкаВыбораКвалификации", ЭтаФорма, ТекущиеДанные);
		ОткрытьФорму("Справочник.торо_КвалификацииРемонтногоПерсонала.ФормаВыбора",, ЭтаФорма,, ВариантОткрытияОкна.ОтдельноеОкно,, ОписаниеОповещения, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);		
	Иначе
		ТекущиеДанные.Квалификация = "<основная>";
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбораКвалификации(ВыбраннаяКвалификация, ДопПараметры) Экспорт
	
	Если ЗначениеЗаполнено(ВыбраннаяКвалификация) Тогда
		ДопПараметры.Квалификация = ВыбраннаяКвалификация;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы
&НаКлиенте
Процедура Выбрать(Команда)
	Закрыть(ТаблицаИсполнителей);	
КонецПроцедуры

#КонецОбласти

