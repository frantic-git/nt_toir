
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)	
	УстановитьЗначенияПоУмолчанию();
	МассивСтрок = Параметры.МассивСтруктурСтрокТЧ;
	Для Каждого СтруктураСтроки Из МассивСтрок Цикл
		НС = ТаблицаОценокРМ.Добавить();
		ЗаполнитьЗначенияСвойств(НС, СтруктураСтроки);
	КонецЦикла;
	МассивВидовРемонта = Параметры.МассивВидовРемонта;
	Для Каждого ПереданныйВидРемонта Из МассивВидовРемонта Цикл
		Элементы.ВидРемонта.СписокВыбора.Добавить(ПереданныйВидРемонта.Ссылка);
		Элементы.ТаблицаОценокРМВидРемонта.СписокВыбора.Добавить(ПереданныйВидРемонта.Ссылка);
	КонецЦикла;
	ВопросПриЗакрытии = Ложь;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ИзменитьЗначенияФлажков(Истина);
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	Если ЭтаФорма.Модифицированность И ВопросПриЗакрытии = Ложь Тогда
		ВопросПриЗакрытии = Истина;
	КонецЕсли; 
	Если ВопросПриЗакрытии Тогда
		Отказ = Истина;
		Если Не ЗавершениеРаботы Тогда
			ОписаниеОповещения = Новый ОписаниеОповещения("ПередЗакрытиемЗавершение", ЭтотОбъект);
			ПоказатьВопрос(ОписаниеОповещения, НСтр("ru = 'Данные были изменены. Сохранить изменения?'"), РежимДиалогаВопрос.ДаНетОтмена);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура УстановитьФлажки(Команда)
	ИзменитьЗначенияФлажков(Истина);
КонецПроцедуры

&НаКлиенте
Процедура СнятьФлажки(Команда)
	ИзменитьЗначенияФлажков(Ложь);
КонецПроцедуры

&НаКлиенте
Процедура ИнвертироватьФлажки(Команда)
	ИзменитьЗначенияФлажков();
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьДанные(Команда)
	Для Каждого Строка Из ТаблицаОценокРМ Цикл
		Если Строка.Пометка Тогда
			Если НЕ НеМенятьДату
				ИЛИ НЕ (ЗначениеЗаполнено(Строка.Период) И НеМенятьДату) Тогда
				Строка.Период = Дата;
			КонецЕсли;
			
			Если НЕ НеМенятьВидРемонта
				ИЛИ НЕ (ЗначениеЗаполнено(Строка.ВидРемонта) И НеМенятьВидРемонта) Тогда
				Строка.ВидРемонта = ВидРемонта;
			КонецЕсли;
			
			Если НЕ НеМенятьСезон
				ИЛИ НЕ (ЗначениеЗаполнено(Строка.Сезон) И НеМенятьСезон) Тогда
				Строка.Сезон = Сезон;
			КонецЕсли;
			
			Если НЕ НеМенятьВероятностьВыходаИзСтроя
				ИЛИ НЕ (ЗначениеЗаполнено(Строка.ВероятностьВыходаИзСтроя) И НеМенятьВероятностьВыходаИзСтроя) Тогда
				Строка.ВероятностьВыходаИзСтроя = ВероятностьВыходаИзСтроя;
			КонецЕсли;
			
			Если НЕ НеМенятьУщерб
				ИЛИ НЕ (ЗначениеЗаполнено(Строка.Ущерб) И НеМенятьУщерб) Тогда
				Строка.Ущерб = Ущерб;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	Модифицированность = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ПеренестиВДокумент(Команда)
	МассивСтруктур = Новый Массив;
	КолонкиТЧ = "НомерСтроки, Период, ВидРемонта, Сезон, ВероятностьВыходаИзСтроя, Ущерб";
	ВопросПриЗакрытии = Ложь;
	Модифицированность = Ложь;	
	Для каждого СтрокаТЧ Из ТаблицаОценокРМ Цикл
		ПоискДублей = Новый Структура("Период, ВидРемонта, Сезон");
		ЗаполнитьЗначенияСвойств(ПоискДублей, СтрокаТЧ);
		НайданныеСтроки = ТаблицаОценокРМ.НайтиСтроки(ПоискДублей);
		Если НайданныеСтроки.Количество() > 1 Тогда
			ТекстСообщения = НСтр("ru = 'Среди строк оценок риск-менеджмента имеются дублирующиеся!'");
			ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
			Возврат;
		КонецЕсли;
		СтруктураСтрокиТЧ = Новый Структура(КолонкиТЧ);
		ЗаполнитьЗначенияСвойств(СтруктураСтрокиТЧ, СтрокаТЧ);
		МассивСтруктур.Добавить(СтруктураСтрокиТЧ);
		
	КонецЦикла;
	Закрыть(МассивСтруктур);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПередЗакрытиемЗавершение(Результат, ДопПараметры) Экспорт

	Если Результат = КодВозвратаДиалога.Да Тогда
		ВопросПриЗакрытии = Ложь;
		ЭтаФорма.Модифицированность = Ложь;
		ПеренестиВДокумент("");
	КонецЕсли;

	Если Результат = КодВозвратаДиалога.Нет Тогда 
		ВопросПриЗакрытии = Ложь;
		ЭтаФорма.Модифицированность = Ложь;
		ЭтаФорма.Закрыть();
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ИзменитьЗначенияФлажков(НовоеЗначение = Неопределено)

	Для каждого СтрокаТЧ Из ТаблицаОценокРМ Цикл
		СтрокаТЧ.Пометка = ?(НовоеЗначение = Неопределено, Не СтрокаТЧ.Пометка, НовоеЗначение);
	КонецЦикла;

КонецПроцедуры

&НаСервере
Процедура УстановитьЗначенияПоУмолчанию()

	ЗначенияФлаговНеизменности = Истина;
	
	НеМенятьВероятностьВыходаИзСтроя	= ЗначенияФлаговНеизменности;
	НеМенятьДату						= ЗначенияФлаговНеизменности;
	НеМенятьВидРемонта					= ЗначенияФлаговНеизменности;
	НеМенятьСезон						= ЗначенияФлаговНеизменности;
	НеМенятьУщерб						= ЗначенияФлаговНеизменности;

КонецПроцедуры

#КонецОбласти




