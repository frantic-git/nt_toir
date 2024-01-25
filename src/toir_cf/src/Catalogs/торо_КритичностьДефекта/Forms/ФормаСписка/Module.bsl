#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	МультиязычностьСервер.ПриСозданииНаСервере(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	
	Если НЕ ЗавершениеРаботы Тогда 
		Оповестить("ЗакрытиеФормыСпискаКритичности");
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокПриИзменении(Элемент)
	СписокПриИзмененииНаСервере();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СписокПриИзмененииНаСервере()
	торо_РезервированиеПоПриоритетам.ОбновитьНормированноеЗначениеКритичностиДефектов();
КонецПроцедуры

#КонецОбласти