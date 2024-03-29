
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	МультиязычностьСервер.ПриСозданииНаСервере(ЭтотОбъект);
	
	РазрешитьСоздание = Параметры.Отбор.Свойство("Владелец") И ЗначениеЗаполнено(Параметры.Отбор.Владелец);
	Если НЕ РазрешитьСоздание Тогда
		Попытка
			Элементы.ФормаСоздать.Доступность = Ложь;
			Элементы.СписокКонтекстноеМеню.ПодчиненныеЭлементы.СписокКонтекстноеМенюСоздать.Доступность = Ложь;
			Элементы.СписокКонтекстноеМеню.ПодчиненныеЭлементы.СписокКонтекстноеМенюСоздать.Видимость = Ложь;
		Исключение
		КонецПопытки;
	КонецЕсли;
	
	Если Параметры.Отбор.Свойство("Владелец") И ЗначениеЗаполнено(Параметры.Отбор.Владелец) 
		И ТипЗнч(Параметры.Отбор.Владелец) = Тип("СправочникСсылка.Номенклатура") Тогда
		ВидНоменклатуры = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Параметры.Отбор.Владелец, "ВидНоменклатуры");
		ИспользованиеХарактеристик = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ВидНоменклатуры, "ИспользованиеХарактеристик");
		Если ИспользованиеХарактеристик = Перечисления.ВариантыИспользованияХарактеристикНоменклатуры.ОбщиеДляВидаНоменклатуры Тогда
			СтандартнаяОбработка = Ложь;
			ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(Список, "Владелец", ВидНоменклатуры);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

#КонецОбласти