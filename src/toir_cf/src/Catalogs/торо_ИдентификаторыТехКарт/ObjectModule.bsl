#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда 

#Область ОбработчикиСобытий

Процедура ПриЧтенииПредставленийНаСервере() Экспорт
    МультиязычностьСервер.ПриЧтенииПредставленийНаСервере(ЭтотОбъект);
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Если НЕ ЭтоГруппа И НЕ ЗначениеЗаполнено(Статус) Тогда
		Статус = Перечисления.торо_СтатусыНормативныхРемонтовИТехКарт.ВРазработке;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	Если Ссылка.ПометкаУдаления <> ПометкаУдаления Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	торо_ВерсииТехКарт.ТехКарта
		|ИЗ
		|	РегистрСведений.торо_ВерсииТехКарт КАК торо_ВерсииТехКарт
		|ГДЕ
		|	торо_ВерсииТехКарт.ИдентификаторТехКарты = &ИдентификаторТехКарты";
					   
		Запрос.УстановитьПараметр("ИдентификаторТехКарты", Ссылка);
		РезультатЗапроса = Запрос.Выполнить();
		Выборка = РезультатЗапроса.Выбрать();
		
		Пока Выборка.Следующий() Цикл
			ТехКартаОбъект = Выборка.ТехКарта.ПолучитьОбъект();
			ТехКартаОбъект.УстановитьПометкуУдаления(ПометкаУдаления);
			ТехКартаОбъект.Записать();
		КонецЦикла;
		
	КонецЕсли;
	
	Если Не Отказ Тогда
		торо_МТОСервер.ПоместитьРемонтыВРегистрДляПроверкиАктуальности(Ссылка);
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Функция выполняет проверку на использование ремонта
//	в вышестоящих ремонтах.
//
// Параметры:
//	ТекЭлемент - текущий элемент справочника
//	ЭлементПоиска - элемент для сравнения.
//
// Возвращаемое значение:
//	Истина - есть зацикливание, Ложь - нет.
//
Функция ЕстьЗацикливаниеРемонтов(ТекЭлемент, ЭлементПоиска) Экспорт
	
	Если ТипЗнч(ТекЭлемент)<> Тип("СправочникСсылка.торо_ИдентификаторыТехКарт") ИЛИ
		ТипЗнч(ТекЭлемент)=Тип("СправочникСсылка.торо_ИдентификаторыТехКарт") И ЭлементПоиска.Пустая() И Не ЗначениеЗаполнено(ТекЭлемент) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	СтруктураВозврата = Новый Соответствие;
	
	Если ТекЭлемент = ЭлементПоиска Тогда
		СтруктураВозврата.Вставить(ТекЭлемент.Наименование, ЭлементПоиска.Наименование);
		Возврат СтруктураВозврата;
	КонецЕсли;
	
	ВерсияТК = РегистрыСведений.торо_ВерсииТехКарт.ПолучитьВерсиюТехКарты(ТекЭлемент);
	
	Если ЗначениеЗаполнено(ВерсияТК) Тогда
		
		Для Каждого СтрокаОпераций Из ВерсияТК.СписокОпераций Цикл
			
			Если ТипЗнч(СтрокаОпераций.Операция)<> Тип("СправочникСсылка.торо_ИдентификаторыТехКарт") Тогда
				Продолжить;
			КонецЕсли;
			
			Если СтрокаОпераций.Операция = ЭлементПоиска Тогда
				
				СтруктураВозврата.Вставить(ЭлементПоиска.Наименование, ТекЭлемент.Наименование);
				Возврат СтруктураВозврата;
				
			Иначе 
				
				Возврат ЕстьЗацикливаниеРемонтов(СтрокаОпераций.Операция, ЭлементПоиска);
				
			КонецЕсли;
			
		КонецЦикла;
	КонецЕсли;
	
	Возврат СтруктураВозврата;
	
КонецФункции

#КонецОбласти

#КонецЕсли