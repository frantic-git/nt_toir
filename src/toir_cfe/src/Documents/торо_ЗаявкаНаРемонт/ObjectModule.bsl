#Область ОбработчикиСобытий

&ИзменениеИКонтроль("ПередЗаписью")
Процедура проф_ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)

	МассивОР = ОбщегоНазначения.ВыгрузитьКолонку(РемонтыОборудования, "ОбъектРемонта", Истина);
	ОбъектыРемонтаСтрокой = торо_ЗаполнениеДокументов20.СформироватьСтрокуОбъектовРемонта(МассивОР);

	МассивВидовРемонта = ОбщегоНазначения.ВыгрузитьКолонку(РемонтыОборудования, "ВидРемонтныхРабот", Истина);
	ВидыРемонтаСтрокой = торо_ЗаполнениеДокументов20.СформироватьСтрокуОбъектовРемонта(МассивВидовРемонта);

	ДополнительныеСвойства.Вставить("НоваяЗаявка", НЕ Проведен);

	// Получение удаленных ремонтов при перепроведении документа. Используются при формировании записей
	// регистров торо_ПлановыеИсполнителиРемонтов, торо_ОбщиеДанныеПоРемонтам, торо_СвернутыеФактическиеДатыРемонтов.
	Если Проведен И РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда
		МассивIDДокумента = РемонтыОборудования.ВыгрузитьКолонку("ID");
		МассивУдаленныхID = торо_Ремонты.ПолучитьIDУдаленныхРемонтовДокумента(МассивIDДокумента, Ссылка);
		ДополнительныеСвойства.Вставить("МассивУдаленныхID", МассивУдаленныхID);
	Иначе
		ДополнительныеСвойства.Вставить("МассивУдаленныхID", Новый Массив());
	КонецЕсли;

	Если ЭтоНовый() Тогда
		Автор = Пользователи.ТекущийПользователь();
	КонецЕсли;
	
	#Вставка
	//++ Проф-ИТ, #238, Башинская А.Ю., 29.08.2023 
	Если проф_СтатусСогласования = Перечисления.торо_СтатусыУтвержденияЗаказовНаВП.проф_Новый Тогда
		
		проф_ПлановыеМатериальныеЗатратыИЗапчасти.Очистить();
		
		Для Каждого Стр Из МатериальныеЗатраты Цикл
			Нстр = проф_ПлановыеМатериальныеЗатратыИЗапчасти.Добавить();
			ЗаполнитьЗначенияСвойств(Нстр, Стр);
		КонецЦикла;         
		
		Для Каждого Стр Из ЗапчастиРемонта Цикл
			Нстр = проф_ПлановыеМатериальныеЗатратыИЗапчасти.Добавить();
			ЗаполнитьЗначенияСвойств(Нстр, Стр);
		КонецЦикла;
		
	КонецЕсли;
	//-- Проф-ИТ, #238, Башинская А.Ю., 29.08.2023 
	
	//++ Проф-ИТ, #205, Карпов Д.Ю., 09.10.2023,
	проф_ПересчитатьНомерСтрокВТЧ(); 
	Если ТипЗнч(ЭтотОбъект.ОбменДанными.Отправитель) = Тип("ПланОбменаСсылка.ОбменТОИР30ЕРП20") Тогда 
		БезусловнаяЗапись = Истина;
	КонецЕсли;
	//-- Проф-ИТ, #205, Карпов Д.Ю., 09.10.2023,
	
	//++ Проф-ИТ, #326, Соловьев А.А., 01.11.2023
	ДополнительныеСвойства.Вставить("проф_ЭксплуатацияВозможна", Ссылка.проф_ЭксплуатацияВозможна);
	//-- Проф-ИТ, #326, Соловьев А.А., 01.11.2023 
	
	//Не понятно зачем всегда устанавливать статус Утвержден
	////++ Проф-ИТ, #334, Сергеев Д.Н., 02.11.2023
	//проф_СтатусСогласования = Перечисления.торо_СтатусыУтвержденияЗаказовНаВП.Утвержден;
	////-- Проф-ИТ, #334, Сергеев Д.Н., 02.11.2023 
	
	//++ Проф-ИТ, #359, Соловьев А.А., 23.11.2023
	ШаблонНазначения = Документы.торо_ЗаявкаНаРемонт.ШаблонНазначения(ЭтотОбъект);
	Справочники.проф_Назначения.ПроверитьЗаполнитьПередЗаписью(проф_Назначение, ШаблонНазначения, ЭтотОбъект, "проф_НаправлениеДеятельности", Отказ);
	//-- Проф-ИТ, #359, Соловьев А.А., 23.11.2023
	
	//++ Проф-ИТ, #401, Соловьев А.А., 11.12.2023
	Если РежимЗаписи = РежимЗаписиДокумента.Проведение Тогда 
		проф_ОбщегоНазначенияВызовСервера.ПроверитьПризнакПодразделенияОрганизации(ЭтотОбъект["Подразделение"], Отказ);
	КонецЕсли;
	//-- Проф-ИТ, #401, Соловьев А.А., 11.12.2023
	
	//++ Проф-ИТ, #439, Корнилов М.С., 18.01.2024
	проф_ЗаполнитьБлокировкуСтрокиУТЧ();
	//-- Проф-ИТ, #439, Корнилов М.С., 18.01.2024
	#КонецВставки 
	
КонецПроцедуры

&ИзменениеИКонтроль("ОбработкаПроведения")
Процедура проф_ОбработкаПроведения(Отказ, РежимПроведения)

	МассивДокументовОснований = ОбщегоНазначения.ВыгрузитьКолонку(ДокументыОснования, "ДокументОснование");

	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	торо_ВнешнееОснованиеДляРабот.Ссылка КАК Ссылка,
	|	торо_ВнешнееОснованиеДляРабот.Проведен КАК Проведен
	|ИЗ
	|	Документ.торо_ВнешнееОснованиеДляРабот КАК торо_ВнешнееОснованиеДляРабот
	|ГДЕ
	|	торо_ВнешнееОснованиеДляРабот.Ссылка В(&МассивДокОсн)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	торо_ВыявленныеДефекты.Ссылка,
	|	торо_ВыявленныеДефекты.Проведен
	|ИЗ
	|	Документ.торо_ВыявленныеДефекты КАК торо_ВыявленныеДефекты
	|ГДЕ
	|	торо_ВыявленныеДефекты.Ссылка В(&МассивДокОсн)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	торо_ПланГрафикРемонта.Ссылка,
	|	торо_ПланГрафикРемонта.Проведен
	|ИЗ
	|	Документ.торо_ПланГрафикРемонта КАК торо_ПланГрафикРемонта
	|ГДЕ
	|	торо_ПланГрафикРемонта.Ссылка В(&МассивДокОсн)");

	Запрос.УстановитьПараметр("МассивДокОсн", МассивДокументовОснований); 	
	Выборка = Запрос.Выполнить().Выбрать();

	Пока Выборка.Следующий() Цикл
		Если Не Выборка.Проведен Тогда
			ТекстСообщения = НСтр("ru = 'Есть непроведенный документ основание: " + Строка(Выборка.Ссылка) + "'");
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения,,,, Отказ);
			Возврат;
		КонецЕсли;		
	КонецЦикла;

	ШаблонСообщения = НСтр("ru = 'Для объекта ремонта ""%1"" с видом ремонта ""%2"" отсутствуют строки в дереве ремонтных работ.'");
	Для Каждого СтрокаСРемонтом Из РемонтыОборудования Цикл		
		МассивСтрок = РемонтныеРаботы.НайтиСтроки(Новый структура("РемонтыОборудования_ID", СтрокаСРемонтом.ID));
		Если МассивСтрок.Количество() = 0 Тогда			
			ТекстСообщения = СтрШаблон(ШаблонСообщения, СтрокаСРемонтом.ОбъектРемонта, СтрокаСРемонтом.ВидРемонтныхРабот);
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения,,,,Отказ);
			Возврат;			
		КонецЕсли;		
	КонецЦикла;	

	Если ДокументыОснования.Количество()>0 Тогда
		ПроверитьДатуДокумента(Отказ);
	КонецЕсли;

	РемонтыОборудованияТаблицаЗначений = РемонтыОборудования.Выгрузить(); 
	РемонтыОтсутствующиеВДокументахИсточниках = торо_Ремонты.ПроверитьНаличиеРемонтовВДокументахИсточникахПоIDРемонта(РемонтыОборудованияТаблицаЗначений);

	Если НЕ РемонтыОтсутствующиеВДокументахИсточниках = Неопределено Тогда

		Для каждого Ремонт Из РемонтыОтсутствующиеВДокументахИсточниках Цикл
			ШаблонСообщения = НСтр("ru = 'Для объекта ремонта ""%1"" отсутствует соответствующий ремонт в документе основании ""%2"".'");
			ТекстСообщения = СтрШаблон(ШаблонСообщения, Ремонт.ОбъектРемонта, Ремонт.ДокументИсточник);
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения,,,,Отказ);			
		КонецЦикла;

	КонецЕсли;

	Если Не Отказ Тогда

		УстановитьУправляемыеБлокировки();
		ДвиженияПоРегистрам(РежимПроведения, Отказ);

	КонецЕсли;

	торо_РаботаСоСтатусамиДокументовСервер.УстановитьСтатусРемонтовПриПроведении(ЭтотОбъект);
	торо_РаботаСоСтатусамиДокументовСервер.УстановитьСтатусДокумента(Ссылка, Ссылка, Перечисления.торо_СтатусыДокументов.Зарегистрирован);
	торо_РаботаСоСтатусамиДокументовСервер.ИзменитьСтатусыДокументовРемонта(Ссылка);

	СписокПолучателей = Новый СписокЗначений;
	ТаблицаСтатусовПоБригадам = торо_РаботаСоСтатусамиДокументовСервер.ДанныеСтатусовРемонтовЗаявкиПоИсполнителям(Ссылка);
	Для каждого Строка Из ИсполнителиПоРемонтам Цикл 

		СтруктураПоиска = Новый Структура("ИДРемонта, Исполнитель, УточнениеИсполнителя", Строка.РемонтыОборудования_ID, Строка.Исполнитель, Строка.УточнениеИсполнителя);
		НайденныеСтроки = ТаблицаСтатусовПоБригадам.НайтиСтроки(СтруктураПоиска);

		Если НайденныеСтроки.Количество() > 0 И НайденныеСтроки[0].Статус <> Перечисления.торо_СтатусыРемонтов.ОтказИсполнителя 
			И НайденныеСтроки[0].Статус <> Перечисления.торо_СтатусыРемонтов.ОтказПодразделения Тогда 
			СписокПолучателей.Добавить(Строка.УточнениеИсполнителя);
		КонецЕсли;

	КонецЦикла;
	торо_МобильныеПриложенияУведомления.ОтправитьУведомлениеОЗаявке(Ссылка, ДополнительныеСвойства.НоваяЗаявка, Отказ, СписокПолучателей);
	
	торо_Ремонты.ОбновитьЗаписиНезависимыхРегистровПоРемонтам(ЭтотОбъект, РежимЗаписиДокумента.Проведение);
	
	#Вставка
	//++ Проф-ИТ, #222, Башинская А.Ю., 03.08.2023, создание док.Состояние ОР на основании 
	проф_СоздатьСостояниеОбъектовРемонтаНаОсновании();
	//-- Проф-ИТ, #222, Башинская А.Ю., 03.08.2023
	
	//++ Проф-ИТ, #205, Карпов Д.Ю., 09.10.2023,
	проф_ЗаполнитьТоварыВЗаявкеНаПотребление(Отказ);
	//-- Проф-ИТ, #205, Карпов Д.Ю., 09.10.2023,
	#КонецВставки  
	
КонецПроцедуры

&После("ОбработкаЗаполнения")
Процедура проф_ОбработкаЗаполнения(Основание)
	
	Если ТипЗнч(Основание) = Тип("Соответствие") Тогда
		Для каждого ДокОснование Из Основание Цикл
			проф_ТипЗаказа = ТипЗаказаДокумента(ДокОснование.Значение);
			//++ Проф-ИТ, #326, Соловьев А.А., 01.11.2023
			Заполнитьпроф_ЭксплуатацияВозможнаПодразделение(ДокОснование);
			//-- Проф-ИТ, #326, Соловьев А.А., 01.11.2023
			Прервать;
		КонецЦикла; 
	Иначе
		проф_ТипЗаказа = ТипЗаказаДокумента(Основание);
		//++ Проф-ИТ, #326, Соловьев А.А., 01.11.2023
		Заполнитьпроф_ЭксплуатацияВозможнаПодразделение(Основание);
		//-- Проф-ИТ, #326, Соловьев А.А., 01.11.2023
	КонецЕсли;
	
КонецПроцедуры

&После("ПриЗаписи")
Процедура проф_ПриЗаписи(Отказ)
	
	//++ Проф-ИТ, #359, Соловьев А.А., 23.11.2023
	ШаблонНазначения = Документы.торо_ЗаявкаНаРемонт.ШаблонНазначения(ЭтотОбъект);
	НалогообложениеНДС = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(проф_НаправлениеДеятельности, "НалогообложениеНДС");
	Справочники.проф_Назначения.ПриЗаписиДокумента(проф_Назначение, ШаблонНазначения, ЭтотОбъект, Подразделение, НалогообложениеНДС);
	//-- Проф-ИТ, #359, Соловьев А.А., 23.11.2023
	
КонецПроцедуры

&После("ПриКопировании")
Процедура проф_ПриКопировании(ОбъектКопирования)
	
	проф_СтатусСогласования = Перечисления.торо_СтатусыУтвержденияЗаказовНаВП.проф_Новый;
	проф_ДатаУтверждения    = Дата(1, 1, 1);
	проф_КЗНР               = Неопределено;
	проф_Назначение         = Неопределено; 
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

//++ Проф-ИТ, #326, Соловьев А.А., 01.11.2023

Процедура Заполнитьпроф_ЭксплуатацияВозможнаПодразделение(Основание)
	
	ТипОснования = ТипЗнч(Основание);
	
	Если ТипОснования =  Тип("ДокументСсылка.торо_ВыявленныеДефекты") Тогда
		проф_ЭксплуатацияВозможна = Основание.проф_ЭксплуатацияВозможна;
		//++ Проф-ИТ, #373, Соловьев А.А., 28.11.2023
		Подразделение = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ПараметрыСеанса.ТекущийПользователь, "Подразделение");
		//-- Проф-ИТ, #373, Соловьев А.А., 28.11.2023
	ИначеЕсли ТипОснования =  Тип("ДокументСсылка.торо_ВнешнееОснованиеДляРабот") Тогда
		проф_ЭксплуатацияВозможна = Основание.проф_ЭксплуатацияВозможна;
		//++ Проф-ИТ, #373, Соловьев А.А., 28.11.2023
	ИначеЕсли ТипОснования =  Тип("КлючИЗначение") Тогда
		Подразделение = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ПараметрыСеанса.ТекущийПользователь, "Подразделение");
		//-- Проф-ИТ, #373, Соловьев А.А., 28.11.2023
	КонецЕсли;
	
КонецПроцедуры

//-- Проф-ИТ, #326, Соловьев А.А., 01.11.2023

//++ Проф-ИТ, #222, Лавриненко Т.В.,21.08.2023 

Процедура проф_СоздатьСостояниеОбъектовРемонтаНаОсновании()
	
	//++ Проф-ИТ, #326, Соловьев А.А., 01.11.2023		
	Если ДополнительныеСвойства.Свойство("проф_ЭксплуатацияВозможна")
		И ДополнительныеСвойства.проф_ЭксплуатацияВозможна <> проф_ЭксплуатацияВозможна Тогда
		НайденныйДокумент = Неопределено;
	Иначе
		НайденныйДокумент = проф_НайтиСозданныйРанееДокументСостояниеОР();
	КонецЕсли;
	//-- Проф-ИТ, #326, Соловьев А.А., 01.11.2023
	
	Если НайденныйДокумент = Неопределено Тогда
		// Нужно создавать документ
		ДокументСОР = Документы.торо_СостоянияОбъектовРемонта.СоздатьДокумент();
		ДокументСОР.Дата = ТекущаяДатаСеанса();
	Иначе  
		// Обновим уже созданный документ
		ДокументСОР = НайденныйДокумент.ПолучитьОбъект();   
	КонецЕсли;
	
	ДокументСОР.Заполнить(Ссылка);
	ДокументСОР.Автор = Ссылка.Автор;
	ДокументСОР.Ответственный = Ссылка.Ответственный;	
	ДокументСОР.Записать(РежимЗаписиДокумента.Проведение); 		
	
КонецПроцедуры

Функция проф_НайтиСозданныйРанееДокументСостояниеОР()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	торо_СостоянияОбъектовРемонта.Ссылка КАК Ссылка
	|ИЗ
	|	Документ.торо_СостоянияОбъектовРемонта КАК торо_СостоянияОбъектовРемонта
	|ГДЕ
	|	НЕ торо_СостоянияОбъектовРемонта.ПометкаУдаления 
	|	И торо_СостоянияОбъектовРемонта.Проведен
	|	И торо_СостоянияОбъектовРемонта.ДокументОснование = &ДокументОснование";
	Запрос.УстановитьПараметр("ДокументОснование", Ссылка);
	РезультатЗапроса = Запрос.Выполнить();	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		Возврат	ВыборкаДетальныеЗаписи.Ссылка;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

//++ Проф-ИТ, #222, Лавриненко Т.В.,21.08.2023 

//++ Проф-ИТ, #168, Лавриненко Т.В.,21.08.2023 
Функция ТипЗаказаДокумента(Основание) 
	
	ТипЗаказа = Перечисления.проф_ТипЗаказаНаРемонт.ПустаяСсылка();
	Если ТипЗнч(Основание) =  Тип("ДокументСсылка.торо_ПланГрафикРемонта") Тогда
		ТипЗаказа = Перечисления.проф_ТипЗаказаНаРемонт.Плановый;
	ИначеЕсли ТипЗнч(Основание) =  Тип("ДокументСсылка.торо_ВыявленныеДефекты") Тогда
		Если ЗначениеЗаполнено(Основание.проф_ТипЗаказа)Тогда
			ТипЗаказа = Основание.проф_ТипЗаказа;
		Иначе
			ТипЗаказа = Перечисления.проф_ТипЗаказаНаРемонт.Аварийный;
		КонецЕсли;	 
	ИначеЕсли ТипЗнч(Основание) =  Тип("ДокументСсылка.торо_ВнешнееОснованиеДляРабот") Тогда
		ТипЗаказа = Перечисления.проф_ТипЗаказаНаРемонт.Внеплановый;
		//++ Проф-ИТ, #291, Корнилов М.С., 20.10.2023
		ЗаполнитьТЧМатериальныеЗатратыИЗапчастиРемонта(Основание);
		//-- Проф-ИТ, #291, Корнилов М.С., 20.10.2023
	Иначе
		ТипЗаказа = Перечисления.проф_ТипЗаказаНаРемонт.ПустаяСсылка();	
	КонецЕсли;
	
	Возврат ТипЗаказа;
	
КонецФункции	

&ИзменениеИКонтроль("ПроверитьЗаполнениеТабличнойЧастиРемонтыОборудования")
Процедура проф_ПроверитьЗаполнениеТабличнойЧастиРемонтыОборудования(Отказ)

	// Укажем, что надо проверить:
	СтруктураОбязательныхПолей = Новый Структура("ОбъектРемонта,ВидРемонтныхРабот,ДатаНачала, ДатаОкончания");

	// Вызовем общую процедуру проверки.
	торо_ЗаполнениеДокументов.ПроверитьЗаполнениеТабличнойЧасти(ЭтотОбъект, "РемонтыОборудования", СтруктураОбязательныхПолей, Отказ, "");

	#Вставка
	//++ Проф-ИТ, #238, Башинская А.Ю., 30.08.2023    
	КолонкаОбъектРемонта = ЭтотОбъект.РемонтыОборудования.Выгрузить(,"ОбъектРемонта");   
	КолонкаОбъектРемонта.Свернуть("ОбъектРемонта");    
	Если КолонкаОбъектРемонта.Количество() > 1 Тогда         
		СообщениеОбОшибке = НСтр("ru = 'В документе должны быть данные по одному объекту ремонта!'");
		ОбщегоНазначения.СообщитьПользователю(СообщениеОбОшибке,, "Объект.РемонтыОборудования",, Отказ);				
	КонецЕсли;
	//-- Проф-ИТ, #238, Башинская А.Ю., 30.08.2023 
	
	//++ Проф-ИТ, #285, Сергеев Д.Н., 10.01.2024
	ВидРемРаботДооборудование = Справочники.проф_НастройкиСистемы.ПолучитьНастройкуСистемы("Дооборудование", "ВидРемонтаДляДооборудования"); 
	Если ВидРемРаботДооборудование = Неопределено Тогда
	    ТекстСообщения = НСтр("ru = 'Не найден элемент справочника ""Настройки системы"" ""ВидРемонтаДляДооборудования"".'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	Иначе
		//ТаблицаВидРемРабот = ВидРемРаботДооборудование.Список.Выгрузить(); 
		ВсеПозицииНеДооборудование = Истина;
		ПозицияНеДооборудование = Ложь;
		Для каждого текСтрока Из РемонтыОборудования Цикл
			//НайденнаяСтрока = ТаблицаВидРемРабот.Найти(текСтрока.ВидРемонтныхРабот, "Значение");
			Если текСтрока.ВидРемонтныхРабот = ВидРемРаботДооборудование Тогда
				ВсеПозицииНеДооборудование = Ложь;
			Иначе
				ПозицияНеДооборудование = Истина;
			КонецЕсли;
		КонецЦикла; 
		
		Если НЕ ВсеПозицииНеДооборудование И ПозицияНеДооборудование Тогда
			ТекстСообщения = НСтр("ru = 'В документе может быть только вид ремонтных работ по дооборудованию.'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,,, Отказ);  
		КонецЕсли;
	КонецЕсли;
	//-- Проф-ИТ, #285, Сергеев Д.Н., 10.01.2024
	#КонецВставки
КонецПроцедуры

//-- Проф-ИТ, #168, Лавриненко Т.В.,21.08.2023

//++ Проф-ИТ, #205, Карпов Д.Ю., 09.10.2023

Процедура проф_ПересчитатьНомерСтрокВТЧ() 
	
	ЗаполнитьНомерСтроки(МатериальныеЗатраты);
	ЗаполнитьНомерСтроки(ЗапчастиРемонта);
	
КонецПроцедуры
 
Процедура ЗаполнитьНомерСтроки(Таблица)

	Для Каждого Стр Из Таблица Цикл
		Если Не ЗначениеЗаполнено(Стр.проф_ИДСтроки) Тогда
			Стр.проф_ИДСтроки = Строка(Новый УникальныйИдентификатор);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Процедура проф_ЗаполнитьТоварыВЗаявкеНаПотребление(Отказ)
		
	Если ДополнительныеСвойства.Свойство("ПроверкаПерезаполненияМатреиалов") Тогда
		Возврат;
	КонецЕсли;
		
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
			|	ЗаказНаВнутреннееПотребление.Ссылка КАК Ссылка
			|ИЗ
			|	Документ.ЗаказНаВнутреннееПотребление КАК ЗаказНаВнутреннееПотребление 
			|ГДЕ
			|	ЗаказНаВнутреннееПотребление.ДокументОснование = &ДокументЗаявка
			|	И ЗаказНаВнутреннееПотребление.ПометкаУдаления = Ложь";
	Запрос.УстановитьПараметр("ДокументЗаявка", Ссылка);
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	Выборка.Следующий();
	ДокументВнПотребление = Выборка.Ссылка;
	
	МассивID = Новый Массив;
	Для Каждого ТекРемонт Из РемонтыОборудования Цикл		
		МассивID.Добавить(ТекРемонт.ID);  	
	КонецЦикла;
	
	МассивСтрокНоменклатуры = СформироватьМассивНоменклатурыКЗаказуСервере(МассивID); 
	Если МассивСтрокНоменклатуры <> Неопределено Тогда 
		ДокОбъект = ДокументВнПотребление.ПолучитьОбъект();
		ДокОбъект.Товары.Очистить(); 
		ДокОбъект.МаксимальныйКодСтроки = 0;
		ДокОбъект.проф_ТоварыИсточника.Очистить();
		Для Каждого Строка Из МассивСтрокНоменклатуры Цикл
			НС = ДокОбъект.Товары.Добавить();
			ЗаполнитьЗначенияСвойств(НС, Строка);
			НС.КоличествоУпаковок = Строка.Количество; 
			
			НС = ДокОбъект.проф_ТоварыИсточника.Добавить();
			ЗаполнитьЗначенияСвойств(НС, Строка);
			НС.КоличествоУпаковок = Строка.Количество; 
		КонецЦикла; 
		
		//++ Проф-ИТ, #317, Соловьев А.А., 30.10.2023		
		ДокОбъект.Товары.Свернуть("Номенклатура, Характеристика, проф_ПризнакЗапчасти, проф_КЗаказу", "КоличествоУпаковок, Количество");
		//-- Проф-ИТ, #317, Соловьев А.А., 30.10.2023
		УстановитьКлючВСтрокахТабличнойЧасти(ДокОбъект, "Товары"); 
		Для Каждого Строка Из ДокОбъект.Товары Цикл
			Отбор = Новый Структура("Номенклатура, Характеристика", Строка.Номенклатура, Строка.Характеристика);
			НС = ДокОбъект.проф_ТоварыИсточника.НайтиСтроки(Отбор);
			Для Каждого Стр Из НС Цикл
				Стр.КодСтроки = Строка.КодСтроки;
			КонецЦикла;
		КонецЦикла; 
		Попытка 
			//++ Проф-ИТ, #228, Соловьев А.А., 23.10.2023
			ДокОбъект.БезусловнаяЗапись = БезусловнаяЗапись;
			//-- Проф-ИТ, #228, Соловьев А.А., 23.10.2023
			ДокОбъект.ДополнительныеСвойства.Вставить("ПроверкаПерезаполненияМатреиалов");
			ДокОбъект.Записать(РежимЗаписиДокумента.Проведение);
		Исключение   
			ОбщегоНазначения.СообщитьПользователю(ОписаниеОшибки(), , , , Отказ);
		КонецПопытки;
	КонецЕсли;

КонецПроцедуры 

Функция СформироватьМассивНоменклатурыКЗаказуСервере(ID)
	
	Если ТипЗнч(ID) = Тип("Массив") Тогда
		НоменклатураКСписанию = МатериальныеЗатраты.Выгрузить();
		ЗапчастиКСписанию = ЗапчастиРемонта.Выгрузить();
	Иначе
		НоменклатураКСписанию = МатериальныеЗатраты.Выгрузить(Новый Структура("РемонтыОборудования_ID", ID));
		ЗапчастиКСписанию = ЗапчастиРемонта.Выгрузить(Новый Структура("РемонтыОборудования_ID", ID));
	КонецЕсли;	

	НоменклатураКСписанию.Колонки.Добавить("проф_ПризнакЗапчасти", Новый ОписаниеТипов("Булево"));
	Для Каждого СтрокаЗапчасти Из ЗапчастиКСписанию Цикл
		СтрокаНоменклатуры = НоменклатураКСписанию.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаНоменклатуры, СтрокаЗапчасти);
		СтрокаНоменклатуры.КоличествоЕдиниц = СтрокаЗапчасти.Количество;
		СтрокаНоменклатуры.проф_ПризнакЗапчасти = Истина;
	КонецЦикла;
	
	СтрГруппировкаКолонок = "Номенклатура, ХарактеристикаНоменклатуры, ID, РемонтыОборудования_ID, проф_ПризнакЗапчасти";
	//++ Проф-ИТ, #317, Соловьев А.А., 30.10.2023
	СтрГруппировкаКолонок = СтрГруппировкаКолонок + ", проф_КЗаказу";
	//-- Проф-ИТ, #317, Соловьев А.А., 30.10.2023
	НоменклатураКСписанию.Свернуть(СтрГруппировкаКолонок, "КоличествоЕдиниц");

	Товары = Новый Массив;
	Услуга = Перечисления.ТипыНоменклатуры.Услуга;
	Работа = Перечисления.ТипыНоменклатуры.Работа;
		
	Для Каждого Строка Из НоменклатураКСписанию Цикл
		
		Если Строка.Номенклатура.ТипНоменклатуры = Услуга 
		Или Строка.Номенклатура.ТипНоменклатуры = Работа Тогда
			Продолжить;
		КонецЕсли;
		
		Структура = Новый Структура("Номенклатура, Характеристика, Количество, ID,
									|РемонтыОборудования_ID, проф_ПризнакЗапчасти");
		ЗаполнитьЗначенияСвойств(Структура, Строка);
		Структура.Вставить("Характеристика", Строка.ХарактеристикаНоменклатуры);
		Структура.Вставить("Количество", Строка.КоличествоЕдиниц);
		//++ Проф-ИТ, #317, Соловьев А.А., 30.10.2023
		Структура.Вставить("проф_КЗаказу", Строка.проф_КЗаказу);
		//-- Проф-ИТ, #317, Соловьев А.А., 30.10.2023
			
		Товары.Добавить(Структура);
	КонецЦикла;
	
	Если Товары.Количество() > 0 Тогда
		Возврат Товары;
	Иначе
		Возврат Неопределено;
	КонецЕсли; 
	
КонецФункции 

Процедура УстановитьКлючВСтрокахТабличнойЧасти(Объект,
											   ИмяТабличнойЧасти,
											   РеквизитМаксимальныйКодСтроки = "МаксимальныйКодСтроки")

	СтрокиБезКлюча = Объект[ИмяТабличнойЧасти].НайтиСтроки(Новый Структура("КодСтроки", 0));
	Если СтрокиБезКлюча.Количество() > 0 Тогда
		
		ТекущийКод = Объект[РеквизитМаксимальныйКодСтроки];
		
		Для Каждого СтрокаТовары Из СтрокиБезКлюча Цикл
			
			ТекущийКод = ТекущийКод + 1;
			СтрокаТовары.КодСтроки = ТекущийКод;
			
		КонецЦикла;
		
		Объект[РеквизитМаксимальныйКодСтроки] = ТекущийКод;
		
	КонецЕсли;

КонецПроцедуры

//-- Проф-ИТ, #205, Карпов Д.Ю., 09.10.2023

//++ Проф-ИТ, #291, Корнилов М.С., 20.10.2023
Процедура ЗаполнитьТЧМатериальныеЗатратыИЗапчастиРемонта(Основание)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	торо_ВнешнееОснованиеДляРаботпроф_МатериальныеЗатраты.ID КАК ID,
	|	торо_ВнешнееОснованиеДляРаботпроф_МатериальныеЗатраты.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
	|	торо_ВнешнееОснованиеДляРаботпроф_МатериальныеЗатраты.Количество КАК Количество,
	|	торо_ВнешнееОснованиеДляРаботпроф_МатериальныеЗатраты.Номенклатура КАК Номенклатура,
	|	торо_ВнешнееОснованиеДляРаботпроф_МатериальныеЗатраты.ХарактеристикаНоменклатуры КАК ХарактеристикаНоменклатуры,
	|	торо_ВнешнееОснованиеДляРаботпроф_МатериальныеЗатраты.РемонтыОборудования_ID КАК РемонтыОборудования_ID,
	|	торо_ВнешнееОснованиеДляРаботпроф_МатериальныеЗатраты.КоличествоЕдиниц КАК КоличествоЕдиниц
	|ИЗ
	|	Документ.торо_ВнешнееОснованиеДляРабот.проф_МатериальныеЗатраты КАК торо_ВнешнееОснованиеДляРаботпроф_МатериальныеЗатраты
	|ГДЕ
	|	торо_ВнешнееОснованиеДляРаботпроф_МатериальныеЗатраты.Ссылка = &Основание
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	торо_ВнешнееОснованиеДляРаботпроф_СерийныеЗапчасти.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
	|	торо_ВнешнееОснованиеДляРаботпроф_СерийныеЗапчасти.Количество КАК Количество,
	|	торо_ВнешнееОснованиеДляРаботпроф_СерийныеЗапчасти.Номенклатура КАК Номенклатура,
	|	торо_ВнешнееОснованиеДляРаботпроф_СерийныеЗапчасти.ХарактеристикаНоменклатуры КАК ХарактеристикаНоменклатуры,
	|	торо_ВнешнееОснованиеДляРаботпроф_СерийныеЗапчасти.РемонтыОборудования_ID КАК РемонтыОборудования_ID,
	|	торо_ВнешнееОснованиеДляРаботпроф_СерийныеЗапчасти.ID КАК ID
	|ИЗ
	|	Документ.торо_ВнешнееОснованиеДляРабот.проф_СерийныеЗапчасти КАК торо_ВнешнееОснованиеДляРаботпроф_СерийныеЗапчасти
	|ГДЕ
	|	торо_ВнешнееОснованиеДляРаботпроф_СерийныеЗапчасти.Ссылка = &Основание";
	
	Запрос.УстановитьПараметр("Основание", Основание);
	МассивРезультатов = Запрос.ВыполнитьПакет();
	
	ВыборкаМатериальныеЗатраты = МассивРезультатов[0].Выбрать();
	
	Пока ВыборкаМатериальныеЗатраты.Следующий() Цикл
	 	Нстр = МатериальныеЗатраты.Добавить();
		ЗаполнитьЗначенияСвойств(Нстр, ВыборкаМатериальныеЗатраты); 
	КонецЦикла; 
	
	ВыборкаСерийныеЗапчасти = МассивРезультатов[1].Выбрать();
	
	Пока ВыборкаСерийныеЗапчасти.Следующий() Цикл
		Нстр = ЗапчастиРемонта.Добавить();
		ЗаполнитьЗначенияСвойств(Нстр, ВыборкаСерийныеЗапчасти);
	КонецЦикла;
	
КонецПроцедуры
//-- Проф-ИТ, #291, Корнилов М.С., 20.10.2023

//++ Проф-ИТ, #439, Корнилов М.С., 18.01.2024
Процедура проф_ЗаполнитьБлокировкуСтрокиУТЧ()
	
	Если проф_СтатусСогласования = Перечисления.торо_СтатусыУтвержденияЗаказовНаВП.Утвержден Тогда
		Для Каждого Строка Из ЗапчастиРемонта Цикл 
			Строка.проф_БлокировкаСтроки = Истина;		
		КонецЦикла;
		
		Для Каждого Строка Из Инструменты Цикл 
			Строка.проф_БлокировкаСтроки = Истина;		
		КонецЦикла;
		
		Для Каждого Строка Из МатериальныеЗатраты Цикл 
			Строка.проф_БлокировкаСтроки = Истина;		
		КонецЦикла;
		
		Для Каждого Строка Из РемонтныеРаботы Цикл 
			Строка.проф_БлокировкаСтроки = Истина;		
		КонецЦикла;
		
		Для Каждого Строка Из РемонтыОборудования Цикл 
			Строка.проф_БлокировкаСтроки = Истина;		
		КонецЦикла;
		
		Для Каждого Строка Из ДокументыОснования Цикл 
			Строка.проф_БлокировкаСтроки = Истина;		
		КонецЦикла;
	КонецЕсли; 
	
КонецПроцедуры
//++ Проф-ИТ, #439, Корнилов М.С., 18.01.2024

#КонецОбласти
