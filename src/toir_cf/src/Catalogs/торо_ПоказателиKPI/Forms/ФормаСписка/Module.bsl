
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	МультиязычностьСервер.ПриСозданииНаСервере(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОткрытьФорму("ОбщаяФорма.торо_ФормаОбновленияПоставляемойМоделиПоказателейKPI",, ЭтаФорма, УникальныйИдентификатор,,,, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВосстановитьПоставляемуюМодельПоказателей(Команда)
	
	ПоказатьВопрос(Новый ОписаниеОповещения("ВосстановитьПоставляемуюМодельПоказателейЗавершение", ЭтаФорма), 
		НСтр("ru= 'Настройки поставляемых показателей KPI и вариантов анализа будут сброшены.
		|Продолжить с потерей настроек поставляемой модели показателей?'"), РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте 
Процедура ВосстановитьПоставляемуюМодельПоказателейЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Нет Тогда
		Возврат;
	КонецЕсли;
	
	ВосстановитьПоставляемуюМодельПоказателейНаСервере();
	
КонецПроцедуры

&НаСервереБезКонтекста 
Процедура ВосстановитьПоставляемуюМодельПоказателейНаСервере()
	торо_ПоказателиKPI.ВосстановитьПоставляемуюМодельПоказателей();
КонецПроцедуры

#КонецОбласти