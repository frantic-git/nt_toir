
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.УправлениеДоступом

// См. УправлениеДоступомПереопределяемый.ПриЗаполненииСписковСОграничениемДоступа.
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт

	Ограничение.Текст =
	"РазрешитьЧтениеИзменение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)";

КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

// СтандартныеПодсистемы.ОбновлениеВерсииИБ

// Регистрирует данные для обработчика обновления
// 
// Параметры:
//  Параметры - Структура - параметры.
//
Процедура ЗарегистрироватьДанныеКОбработкеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	ОтработаныВсеДанные = Ложь;
	Ссылка = Документы.ЭлектронныйДокументИсходящийЭДО.ПустаяСсылка();
	
	ПараметрыВыборки = Параметры.ПараметрыВыборки;
	ПараметрыВыборки.СпособВыборки = ОбновлениеИнформационнойБазы.СпособВыборкиСсылки();
	ПараметрыВыборки.ПолныеИменаОбъектов = Ссылка.Метаданные().ПолноеИмя();
	
	СостоянияЗавершения = Новый Массив;
	СостоянияЗавершения.Добавить(Перечисления.СостоянияДокументовЭДО.Аннулирован);
	СостоянияЗавершения.Добавить(Перечисления.СостоянияДокументовЭДО.ЗакрытПринудительно);
	СостоянияЗавершения.Добавить(Перечисления.СостоянияДокументовЭДО.ОбменЗавершен);
	СостоянияЗавершения.Добавить(Перечисления.СостоянияДокументовЭДО.ОбменЗавершенСИсправлением);
	СостоянияЗавершения.Добавить(Перечисления.СостоянияДокументовЭДО.ЗакрытСОтклонениемПриглашения);
	
	Пока Не ОтработаныВсеДанные Цикл
		
		Запрос = Новый Запрос;
		Запрос.Текст = 
			"ВЫБРАТЬ ПЕРВЫЕ 1000
			|	ЭлектронныйДокументИсходящийЭДО.Ссылка КАК Ссылка
			|ИЗ
			|	Документ.ЭлектронныйДокументИсходящийЭДО КАК ЭлектронныйДокументИсходящийЭДО
			|ГДЕ
			|	ЭлектронныйДокументИсходящийЭДО.Ссылка > &Ссылка
			// Заполнение истории обработки.
			|	И ((ЭлектронныйДокументИсходящийЭДО.ДатаПодписания = &ПустаяДата
			|		И ЭлектронныйДокументИсходящийЭДО.ДатаОтправки = &ПустаяДата
			|		И ЭлектронныйДокументИсходящийЭДО.ДатаАннулирования = &ПустаяДата
			|		И НЕ ЭлектронныйДокументИсходящийЭДО.УдалитьСостояниеЭДО В (&СостоянияЗавершения))
			// Заполнение по новой архитектуре настроек ЭДО.
			|		ИЛИ (ЭлектронныйДокументИсходящийЭДО.ИдентификаторОрганизации = """"
			|			ИЛИ ЭлектронныйДокументИсходящийЭДО.ИдентификаторКонтрагента = """"
			|			ИЛИ ЭлектронныйДокументИсходящийЭДО.СпособОбмена = ЗНАЧЕНИЕ(Перечисление.СпособыОбменаЭД.ПустаяСсылка))
			// Заполнение по новой архитектуре документов ЭДО.
			|		ИЛИ ЭлектронныйДокументИсходящийЭДО.ТипРегламента = ЗНАЧЕНИЕ(Перечисление.ТипыРегламентовЭДО.ПустаяСсылка))
			|
			|УПОРЯДОЧИТЬ ПО
			|	Ссылка";
		
		Запрос.УстановитьПараметр("Ссылка", Ссылка);
		Запрос.УстановитьПараметр("ПустаяДата", Дата(1, 1, 1));
		Запрос.УстановитьПараметр("СостоянияЗавершения", СостоянияЗавершения);
		МассивСсылок = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
		
		ОбновлениеИнформационнойБазы.ОтметитьКОбработке(Параметры, МассивСсылок);
		
		КоличествоСсылок = МассивСсылок.Количество();
		Если КоличествоСсылок < 1000 Тогда
			ОтработаныВсеДанные = Истина;
		КонецЕсли;
		
		Если КоличествоСсылок > 0 Тогда
			Ссылка = МассивСсылок[КоличествоСсылок - 1];
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

// Обработчик обновления.
// 
// Параметры:
//  Параметры - Структура - параметры.
//
Процедура ОбработатьДанныеДляПереходаНаНовуюВерсию(Параметры) Экспорт
	
	МетаданныеОбъекта = Метаданные.Документы.ЭлектронныйДокументИсходящийЭДО;
	ПолноеИмяОбъекта = МетаданныеОбъекта.ПолноеИмя();
	
	Если ОбновлениеИнформационнойБазы.ЕстьЗаблокированныеПредыдущимиОчередямиДанные(Параметры.Очередь,
			"Справочник.СообщениеЭДОПрисоединенныеФайлы")
		ИЛИ ОбновлениеИнформационнойБазы.ЕстьЗаблокированныеПредыдущимиОчередямиДанные(Параметры.Очередь,
			"РегистрСведений.ОператорыЭДО")
		ИЛИ ОбновлениеИнформационнойБазы.ЕстьЗаблокированныеПредыдущимиОчередямиДанные(Параметры.Очередь,
			"РегистрСведений.ПриглашенияКОбменуЭлектроннымиДокументами") Тогда
		
		Параметры.ОбработкаЗавершена = ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(
			Параметры.Очередь, ПолноеИмяОбъекта);
		Возврат;
	КонецЕсли;
	
	ПараметрыОтметкиВыполнения = ОбновлениеИнформационнойБазы.ДополнительныеПараметрыОтметкиОбработки();
	
	ВыбранныеДанные = ОбновлениеИнформационнойБазы.ДанныеДляОбновленияВМногопоточномОбработчике(Параметры);
	
	Если Не ЗначениеЗаполнено(ВыбранныеДанные) Тогда
		Параметры.ОбработкаЗавершена = ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(
			Параметры.Очередь, ПолноеИмяОбъекта);
		Возврат;
	КонецЕсли;
	
	ОбъектовОбработано = 0;
	ПроблемныхОбъектов = 0;
	
	НаборСсылок = ВыбранныеДанные.ВыгрузитьКолонку("Ссылка");
	
	ИсторияОбработки = ИсторияОбработкиДокументов(НаборСсылок);
	Реквизиты = РеквизитыДокументов(НаборСсылок);
	ДанныеДляЗаполнения = ЭлектронныеДокументыЭДО.Обновление_ДанныеДляЗаполненияДокументовПоНовойАрхитектуре(
		ВыбранныеДанные);
	
	Для каждого СсылкаНаОбъект Из НаборСсылок Цикл
		
		НачатьТранзакцию();
		Попытка
			
			Блокировка = Новый БлокировкаДанных;
			ЭлементБлокировки = Блокировка.Добавить(ПолноеИмяОбъекта);
			ЭлементБлокировки.УстановитьЗначение("Ссылка", СсылкаНаОбъект);
			ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
			Блокировка.Заблокировать();
			
			Записать = Ложь;
			
			Объект = СсылкаНаОбъект.ПолучитьОбъект();
			Если Объект <> Неопределено Тогда
				ОбработатьДанные_ЗаполнитьИсториюОбработки(Объект, ИсторияОбработки, Записать);
				ОбработатьДанные_НоваяАрхитектураНастроекЭДО(Объект, Реквизиты, Записать);
				ЭлектронныеДокументыЭДО.Обновление_ЗаполнитьДокументПоНовойАрхитектуре(
					Объект, ДанныеДляЗаполнения, Ложь, Записать);
			КонецЕсли;
			
			Если Записать Тогда
				ОбновлениеИнформационнойБазы.ЗаписатьОбъект(Объект);
			Иначе
				ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(СсылкаНаОбъект, ПараметрыОтметкиВыполнения);
			КонецЕсли;
			
			ОбъектовОбработано = ОбъектовОбработано + 1;
			
			ЗафиксироватьТранзакцию();
			
		Исключение
			
			ОтменитьТранзакцию();
			ОбновлениеИнформационнойБазы.ОтметитьВыполнениеОбработки(СсылкаНаОбъект, ПараметрыОтметкиВыполнения);
			ПроблемныхОбъектов = ПроблемныхОбъектов + 1;
			ШаблонСообщения = НСтр("ru = 'Не удалось обработать исходящий электронный документ: %1 по причине:'");
			ТекстСообщения = СтрШаблон(ШаблонСообщения, СсылкаНаОбъект) + Символы.ПС + ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
			ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(), УровеньЖурналаРегистрации.Предупреждение,
				МетаданныеОбъекта, СсылкаНаОбъект, ТекстСообщения);
			
		КонецПопытки;
		
	КонецЦикла;
	
	Если ОбъектовОбработано = 0 И ПроблемныхОбъектов <> 0 Тогда
		ШаблонСообщения = НСтр("ru = 'Не удалось обработать некоторые исходящие электронные документы (пропущены): %1'");
		ТекстСообщения = СтрШаблон(ШаблонСообщения, ПроблемныхОбъектов);
		ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(),
			УровеньЖурналаРегистрации.Информация, МетаданныеОбъекта,, ТекстСообщения);
	Иначе
		ШаблонСообщения = НСтр("ru = 'Обработана очередная порция исходящих электронных документов: %1'");
		ТекстСообщения = СтрШаблон(ШаблонСообщения, ОбъектовОбработано);
		ЗаписьЖурналаРегистрации(ОбновлениеИнформационнойБазы.СобытиеЖурналаРегистрации(),
			УровеньЖурналаРегистрации.Информация, МетаданныеОбъекта,, ТекстСообщения);
	КонецЕсли;
	
	Параметры.ПрогрессВыполнения.ОбработаноОбъектов = Параметры.ПрогрессВыполнения.ОбработаноОбъектов
		+ ОбъектовОбработано;
	
	Параметры.ОбработкаЗавершена = ОбновлениеИнформационнойБазы.ОбработкаДанныхЗавершена(
		Параметры.Очередь, ПолноеИмяОбъекта);
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.ОбновлениеВерсииИБ

#КонецОбласти

#КонецОбласти

#КонецЕсли

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияПолейПредставления(Поля, СтандартнаяОбработка)
	
	ЭлектронныеДокументыЭДОКлиентСервер.ОбработкаПолученияПолейПредставленияДокумента(Поля, СтандартнаяОбработка);
	
КонецПроцедуры

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)
	
	ЭлектронныеДокументыЭДОКлиентСервер.ОбработкаПолученияПредставленияДокумента(
		Данные, Представление, СтандартнаяОбработка);
	
КонецПроцедуры

#КонецОбласти

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныеПроцедурыИФункции

#Область Обновление

Процедура ОбработатьДанные_ЗаполнитьИсториюОбработки(Объект, ИсторияОбработки, Записать)
	
	СтрокаИсторииОбработки = ИсторияОбработки.Найти(Объект.Ссылка, "ЭлектронныйДокумент");
	Если СтрокаИсторииОбработки = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Объект.ДатаПодписания)
		ИЛИ ЗначениеЗаполнено(Объект.ДатаОтправки)
		ИЛИ ЗначениеЗаполнено(Объект.ДатаАннулирования) Тогда
		Возврат;
	КонецЕсли;
	
	ДатаНеизвестна = Дата(3000, 1, 1);
	
	Если Не ЗначениеЗаполнено(Объект.ДатаПодписания)
		И СтрокаИсторииОбработки.ДатаПодписания <> ДатаНеизвестна Тогда
		Объект.ДатаПодписания = СтрокаИсторииОбработки.ДатаПодписания;
		Записать = Истина;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Объект.ДатаОтправки)
		И СтрокаИсторииОбработки.ДатаОтправки <> ДатаНеизвестна Тогда
		Объект.ДатаОтправки = СтрокаИсторииОбработки.ДатаОтправки;
		Записать = Истина;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Объект.ДатаАннулирования)
		И СтрокаИсторииОбработки.ДатаАннулирования <> ДатаНеизвестна Тогда
		Объект.ДатаАннулирования = СтрокаИсторииОбработки.ДатаАннулирования;
		Записать = Истина;
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработатьДанные_НоваяАрхитектураНастроекЭДО(Объект, Реквизиты, Записать)
	
	СтрокаРеквизитов = Реквизиты.Найти(Объект.Ссылка, "ЭлектронныйДокумент");
	Если СтрокаРеквизитов = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Объект.ИдентификаторОрганизации)
		И ЗначениеЗаполнено(СтрокаРеквизитов.ИдентификаторОрганизации) Тогда
		
		Объект.ИдентификаторОрганизации = СтрокаРеквизитов.ИдентификаторОрганизации;
		Записать = Истина;
		
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Объект.ИдентификаторКонтрагента)
		И ЗначениеЗаполнено(СтрокаРеквизитов.ИдентификаторКонтрагента) Тогда
		
		Объект.ИдентификаторКонтрагента = СтрокаРеквизитов.ИдентификаторКонтрагента;
		Записать = Истина;
		
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Объект.СпособОбмена)
		И ЗначениеЗаполнено(СтрокаРеквизитов.СпособОбменаЭД) Тогда
		
		Объект.СпособОбмена = СтрокаРеквизитов.СпособОбменаЭД;
		Записать = Истина;
		
	КонецЕсли;
	
	Если Объект.ВыгружатьДополнительныеСведения <> СтрокаРеквизитов.ВыгружатьДополнительныеСведения Тогда
		
		Объект.ВыгружатьДополнительныеСведения = СтрокаРеквизитов.ВыгружатьДополнительныеСведения;
		Записать = Истина;
		
	КонецЕсли;
	
КонецПроцедуры

Функция ИсторияОбработкиДокументов(Знач НаборДокументооборотов)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ЖурналСобытийЭД.ВладелецЭД КАК ЭлектронныйДокумент,
	|	МИНИМУМ(ВЫБОР
	|			КОГДА ЖурналСобытийЭД.СтатусЭД В (&СтатусыПодписан)
	|				ТОГДА ЖурналСобытийЭД.Дата
	|			ИНАЧЕ ДАТАВРЕМЯ(3000, 1, 1)
	|		КОНЕЦ) КАК ДатаПодписания,
	|	МИНИМУМ(ВЫБОР
	|			КОГДА ЖурналСобытийЭД.СтатусЭД В (&СтатусыОтправлен)
	|				ТОГДА ЖурналСобытийЭД.Дата
	|			ИНАЧЕ ДАТАВРЕМЯ(3000, 1, 1)
	|		КОНЕЦ) КАК ДатаОтправки,
	|	МИНИМУМ(ВЫБОР
	|			КОГДА ЖурналСобытийЭД.СтатусЭД В (&СтатусыАннулирован)
	|				ТОГДА ЖурналСобытийЭД.Дата
	|			ИНАЧЕ ДАТАВРЕМЯ(3000, 1, 1)
	|		КОНЕЦ) КАК ДатаАннулирования
	|ИЗ
	|	РегистрСведений.УдалитьЖурналСобытийЭД КАК ЖурналСобытийЭД
	|ГДЕ
	|	ЖурналСобытийЭД.ВладелецЭД В(&НаборДокументооборотов)
	|	И ЖурналСобытийЭД.ПрисоединенныйФайл.УдалитьТипЭлементаВерсииЭД В(&ТипыПервичныхЭД)
	|
	|СГРУППИРОВАТЬ ПО
	|	ЖурналСобытийЭД.ВладелецЭД";
	Запрос.УстановитьПараметр("НаборДокументооборотов", НаборДокументооборотов);
	СтатусыПодписан = Новый Массив;
	СтатусыПодписан.Добавить(Перечисления.СтатусыСообщенийЭДО.Подписан);
	СтатусыПодписан.Добавить(Перечисления.СтатусыСообщенийЭДО.УдалитьПолностьюПодписан);
	Запрос.УстановитьПараметр("СтатусыПодписан", СтатусыПодписан);
	СтатусыОтправлен = Новый Массив;
	СтатусыОтправлен.Добавить(Перечисления.СтатусыСообщенийЭДО.Отправлен);
	СтатусыОтправлен.Добавить(Перечисления.СтатусыСообщенийЭДО.УдалитьПереданОператору);
	Запрос.УстановитьПараметр("СтатусыОтправлен", СтатусыОтправлен);
	СтатусыАннулирован = Новый Массив;
	СтатусыАннулирован.Добавить(Перечисления.СтатусыСообщенийЭДО.УдалитьАннулирован);
	Запрос.УстановитьПараметр("СтатусыАннулирован", СтатусыАннулирован);
	
	ТипыПервичныхЭД = Новый Массив;
	ТипыПервичныхЭД.Добавить(Перечисления.ТипыЭлементовРегламентаЭДО.УдалитьСЧФДОПУПД);
	ТипыПервичныхЭД.Добавить(Перечисления.ТипыЭлементовРегламентаЭДО.УдалитьСЧФУПД);
	ТипыПервичныхЭД.Добавить(Перечисления.ТипыЭлементовРегламентаЭДО.УдалитьДОПУПД);
	ТипыПервичныхЭД.Добавить(Перечисления.ТипыЭлементовРегламентаЭДО.УдалитьКСЧФДИСУКД);
	ТипыПервичныхЭД.Добавить(Перечисления.ТипыЭлементовРегламентаЭДО.УдалитьКСЧФУКД);
	ТипыПервичныхЭД.Добавить(Перечисления.ТипыЭлементовРегламентаЭДО.УдалитьДИСУКД);
	ТипыПервичныхЭД.Добавить(Перечисления.ТипыЭлементовРегламентаЭДО.УдалитьДОП);
	ТипыПервичныхЭД.Добавить(Перечисления.ТипыЭлементовРегламентаЭДО.УдалитьПервичныйЭД);
	ТипыПервичныхЭД.Добавить(Перечисления.ТипыЭлементовРегламентаЭДО.УдалитьЭСФ);
	Запрос.УстановитьПараметр("ТипыПервичныхЭД", ТипыПервичныхЭД);
	
	ИсторияОбработки = Запрос.Выполнить().Выгрузить();
	ИсторияОбработки.Индексы.Добавить("ЭлектронныйДокумент");
	
	Возврат ИсторияОбработки;
	
КонецФункции

Функция РеквизитыДокументов(Знач НаборДокументооборотов)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ЭлектронныйДокументИсходящийЭДО.Ссылка КАК Ссылка,
	|	ЭлектронныйДокументИсходящийЭДО.УдалитьНастройкаЭДО.ИдентификаторОрганизации КАК ИдентификаторОрганизации,
	|	ЭлектронныйДокументИсходящийЭДО.УдалитьНастройкаЭДО.ИдентификаторКонтрагента КАК ИдентификаторКонтрагента,
	|	ЭлектронныйДокументИсходящийЭДО.УдалитьНастройкаЭДО.СпособОбменаЭД КАК СпособОбменаЭД,
	|	ВЫРАЗИТЬ(ЭлектронныйДокументИсходящийЭДО.УдалитьПрофильНастроекЭДО.ОператорЭДОИд КАК СТРОКА(10)) КАК ИдентификаторОператора,
	|	ЭлектронныйДокументИсходящийЭДО.УдалитьНастройкаЭДО КАК НастройкаЭДО,
	|	ЭлектронныйДокументИсходящийЭДО.УдалитьВидДокумента КАК ВидЭД
	|ПОМЕСТИТЬ РеквизитыДокумента
	|ИЗ
	|	Документ.ЭлектронныйДокументИсходящийЭДО КАК ЭлектронныйДокументИсходящийЭДО
	|ГДЕ
	|	ЭлектронныйДокументИсходящийЭДО.Ссылка В(&НаборДокументооборотов)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	РеквизитыДокумента.Ссылка КАК ЭлектронныйДокумент,
	|	ЕСТЬNULL(НастройкиИсходящие.ИдентификаторОрганизации, РеквизитыДокумента.ИдентификаторОрганизации) КАК ИдентификаторОрганизации,
	|	ЕСТЬNULL(НастройкиИсходящие.ИдентификаторКонтрагента, РеквизитыДокумента.ИдентификаторКонтрагента) КАК ИдентификаторКонтрагента,
	|	ЕСТЬNULL(НастройкиИсходящие.СпособОбменаЭД, РеквизитыДокумента.СпособОбменаЭД) КАК СпособОбменаЭД,
	|	ЕСТЬNULL(ОператорыЭДО.ОтправлятьДополнительныеСведения, ЛОЖЬ) КАК ВыгружатьДополнительныеСведения
	|ИЗ
	|	РеквизитыДокумента КАК РеквизитыДокумента
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ОператорыЭДО КАК ОператорыЭДО
	|		ПО (РеквизитыДокумента.ИдентификаторОператора = ОператорыЭДО.ИдентификаторОператора
	|				ИЛИ РеквизитыДокумента.СпособОбменаЭД = &ЧерезТакском
	|					И ОператорыЭДО.СпособОбменаЭД = &ЧерезТакском)
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.УдалитьСоглашенияОбИспользованииЭД.ИсходящиеДокументы КАК НастройкиИсходящие
	|		ПО РеквизитыДокумента.НастройкаЭДО = НастройкиИсходящие.Ссылка
	|			И РеквизитыДокумента.ВидЭД = НастройкиИсходящие.ИсходящийДокумент";
	Запрос.УстановитьПараметр("НаборДокументооборотов", НаборДокументооборотов);
	Запрос.УстановитьПараметр("ЧерезТакском", Перечисления.СпособыОбменаЭД.ЧерезОператораЭДОТакском);
	
	Реквизиты = Запрос.Выполнить().Выгрузить();
	Реквизиты.Индексы.Добавить("ЭлектронныйДокумент");
	
	Возврат Реквизиты;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#КонецЕсли