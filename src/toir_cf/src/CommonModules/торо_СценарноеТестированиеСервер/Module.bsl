
#Область СлужебныеПроцедурыИФункции

Функция ПолучитьСвободныйПорт() Экспорт
	
	Возврат 1550;
	
КонецФункции

Процедура ПодготовитьБазуДляТеста() Экспорт
	
	// Действия по очистке базы и рапроведению документов, если требуется.
	
КонецПроцедуры

Функция НайтиЭлементСправочникаПоНаименованию(ИмяСправочника, НаименованиеЭлемента, Родитель = Неопределено) Экспорт
	
	Возврат Справочники[ИмяСправочника].НайтиПоНаименованию(НаименованиеЭлемента, Истина, Родитель);
	
КонецФункции

Функция ПолучитьДатуОтчсчетаНаработки(ПодразделениеПользователя) Экспорт
	
	Запрос = Новый Запрос;
	
	Если ЗначениеЗаполнено(ПодразделениеПользователя) Тогда
		
		Запрос.Текст =
		"ВЫБРАТЬ
		|	торо_ОбъектыРемонта.Ссылка КАК Ссылка
		|ПОМЕСТИТЬ СписокОР
		|ИЗ
		|	Справочник.торо_ОбъектыРемонта КАК торо_ОбъектыРемонта
		|ГДЕ
		|	торо_ОбъектыРемонта.Подразделение = &Подразделение
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	МАКСИМУМ(торо_ПериодыНаработкиОРСрезПоследних.Период) КАК ДатаКон,
		|	торо_ПериодыНаработкиОРСрезПоследних.ОбъектРемонта КАК ОбъектРемонта
		|ИЗ
		|	РегистрСведений.торо_ПериодыНаработкиОР.СрезПоследних(
		|			,
		|			ОбъектРемонта В
		|				(ВЫБРАТЬ
		|					СписокОР.Ссылка
		|				ИЗ
		|					СписокОР КАК СписокОР)) КАК торо_ПериодыНаработкиОРСрезПоследних
		|
		|СГРУППИРОВАТЬ ПО
		|	торо_ПериодыНаработкиОРСрезПоследних.ОбъектРемонта";
		
		Запрос.УстановитьПараметр("Подразделение", ПодразделениеПользователя);
		
	Иначе
		
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	МАКСИМУМ(торо_ПериодыНаработкиОРСрезПоследних.Период) КАК ДатаКон,
		|	торо_ПериодыНаработкиОРСрезПоследних.ОбъектРемонта КАК ОбъектРемонта
		|ИЗ
		|	РегистрСведений.торо_ПериодыНаработкиОР.СрезПоследних КАК торо_ПериодыНаработкиОРСрезПоследних
		|
		|СГРУППИРОВАТЬ ПО
		|	торо_ПериодыНаработкиОРСрезПоследних.ОбъектРемонта";
		
	КонецЕсли;
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	ДатаОтсчета = Дата(1,1,1);
	Если Выборка.Следующий() Тогда
		ДатаОтсчета = Выборка.ДатаКон;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(ДатаОтсчета) Тогда
		ДатаОтсчета = КонецДня(НачалоГода(ТекущаяДата()))+1;
	Иначе
		ДатаОтсчета = КонецДня(ДатаОтсчета)+1;
	КонецЕсли;
	
	Возврат ДатаОтсчета;
	
КонецФункции

Функция ПолучитьДатуОтчсчетаКонтролируемыхПоказателей(ПодразделениеПользователя) Экспорт
	
	Запрос = Новый Запрос;
	
	Если ЗначениеЗаполнено(ПодразделениеПользователя) Тогда
		
		Запрос.Текст =
		"ВЫБРАТЬ
		|	торо_ОбъектыРемонта.Ссылка
		|ПОМЕСТИТЬ СписокОР
		|ИЗ
		|	Справочник.торо_ОбъектыРемонта КАК торо_ОбъектыРемонта
		|ГДЕ
		|	торо_ОбъектыРемонта.Подразделение = &Подразделение
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	торо_ЗначенияКонтролируемыхПоказателейСрезПоследних.ДатаКонтроля
		|ИЗ
		|	РегистрСведений.торо_ЗначенияКонтролируемыхПоказателей.СрезПоследних(
		|			,
		|			ОбъектРемонта В
		|				(ВЫБРАТЬ
		|					СписокОР.Ссылка
		|				ИЗ
		|					СписокОР КАК СписокОР)) КАК торо_ЗначенияКонтролируемыхПоказателейСрезПоследних";
		
		Запрос.УстановитьПараметр("Подразделение", ПодразделениеПользователя);
		
	Иначе
		
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	торо_ЗначенияКонтролируемыхПоказателейСрезПоследних.ДатаКонтроля
		|ИЗ
		|	РегистрСведений.торо_ЗначенияКонтролируемыхПоказателей.СрезПоследних(, ) КАК торо_ЗначенияКонтролируемыхПоказателейСрезПоследних";
		
	КонецЕсли;
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	ДатаОтсчета = Дата(1,1,1);
	Если Выборка.Следующий() Тогда
		ДатаОтсчета = Выборка.ДатаКонтроля;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(ДатаОтсчета) Тогда
		ДатаОтсчета = КонецДня(НачалоГода(ТекущаяДата()))+1;
	Иначе
		ДатаОтсчета = КонецДня(ДатаОтсчета)+1;
	КонецЕсли;
	
	Возврат ДатаОтсчета;
	
КонецФункции

#КонецОбласти
