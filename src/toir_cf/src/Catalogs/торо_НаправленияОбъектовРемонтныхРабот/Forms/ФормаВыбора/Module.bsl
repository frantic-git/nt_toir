#Область ОбработчикиСобытийФормы
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	МультиязычностьСервер.ПриСозданииНаСервере(ЭтотОбъект);
	
	Если Параметры.Свойство("СписокОтбора") Тогда
		ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
		ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.ВСписке;
		ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Ссылка");
		ЭлементОтбора.ПравоеЗначение = Параметры.СписокОтбора;
		ЭлементОтбора.Использование = Истина;
	КонецЕсли;
	
КонецПроцедуры
#КонецОбласти