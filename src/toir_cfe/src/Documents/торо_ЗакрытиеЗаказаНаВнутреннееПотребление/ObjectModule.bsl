
#Область ОбработчикиСобытий
	
&ИзменениеИКонтроль("ОбработкаЗаполнения")
Процедура проф_ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	Если ТипЗнч(ДанныеЗаполнения) = Тип("Структура") И ДанныеЗаполнения.Свойство("ИзРабочегоМестаМТО") И ДанныеЗаполнения.ИзРабочегоМестаМТО Тогда
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, ДанныеЗаполнения);
		#Вставка
		//++ Проф-ИТ, #27, Соловьев А.А., 28.08.2023
		Если ДанныеЗаполнения.Свойство("ЗаказНаВнутреннееПотребление") Тогда
			проф_Назначение = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ДанныеЗаполнения.ЗаказНаВнутреннееПотребление, "проф_Назначение");
			Если Не ЗначениеЗаполнено(проф_Назначение) Тогда 
				ТекстСообщения = СтрШаблон(НСтр("ru = 'У документа-основния %1 не заполнено Назначение'"), 
					ДанныеЗаполнения.ЗаказНаВнутреннееПотребление);
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
				СтандартнаяОбработка = Ложь;
				Возврат;
			КонецЕсли;	
		КонецЕсли;	
		//-- Проф-ИТ, #27, Соловьев А.А., 28.08.2023
		#КонецВставки
	КонецЕсли;
	торо_ЗаполнениеДокументов.ЗаполнитьСтандартныеРеквизитыШапкиПоУмолчанию(ЭтотОбъект);
КонецПроцедуры

&После("ПередЗаписью")
Процедура проф_ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	//++ Проф-ИТ, #401, Соловьев А.А., 11.12.2023
	Если РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда 
		проф_ОбщегоНазначенияВызовСервера.ПроверитьПризнакПодразделенияОрганизации(ЭтотОбъект["Подразделение"], Отказ);
	КонецЕсли;
	//-- Проф-ИТ, #401, Соловьев А.А., 11.12.2023
	
КонецПроцедуры

#КонецОбласти